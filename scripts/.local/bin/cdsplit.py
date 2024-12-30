#!/usr/bin/env python

import argparse
from glob import glob
from os import chdir, getenv, listdir, makedirs, path, remove
from shutil import copy
from subprocess import call

home = getenv("HOME")
output_dir = f"{home}/Music/compressed"

parser = argparse.ArgumentParser(
    description="split raw music albums or just compress them"
)

parser.add_argument(
    "-b",
    "--bitrate",
    required=False,
    default="160k",
    metavar="",
    help="specify the bitrate, eg '120k' ",
)

parser.add_argument(
    "-f",
    "--format",
    required=False,
    default="libopus",
    metavar="",
    help="specify the format for ffmpeg to use, eg 'libopus' ",
)

parser.add_argument(
    "-e",
    "--extension",
    required=False,
    default="opus",
    metavar="",
    help="specify the extension for ffmpeg to use, (must be compatible with the format)",
)

parser.add_argument(
    "-o",
    "--output",
    required=False,
    default=output_dir,
    metavar="",
    help="specify the output directory",
)

parser.add_argument(
    "input",
    nargs="+",
    metavar="",
    help="specify the base directory of the operation",
)

args = parser.parse_args()


def requirements(album_dir: str) -> None:
    exists = path.exists(output_dir)
    if not exists:
        makedirs(output_dir)

    exists = path.exists(f"{output_dir}/{album_dir}")
    if not exists:
        makedirs(f"{output_dir}/{album_dir}")


def base_format(album: str):
    files = listdir(album)
    for file in files:
        if file.endswith(".flac"):
            return "flac"
        elif file.endswith(".ape"):
            return "ape"
        elif file.endswith(".m4a"):
            return "m4a"
        else:
            continue
    else:
        print("appropriate format not found, aborting.")
        return False


def counting(format: str) -> int:
    total = len({f for f in listdir() if f.lower().endswith(format)})
    return total


def cue_exists() -> None:
    if not glob("*.cue"):
        print("the cuesheet was not found!")
        quit(1)


def genre_fetcher(count: int) -> str:
    if count != 1:
        return input("What's the album's genre? ")
    cue_file = glob("*.cue")
    if not cue_file:
        return input("What's the album's genre? ")
    cue_file = cue_file[0]
    with open(cue_file) as cue_sheet:
        contents = cue_sheet.readlines()
        try:
            for line in contents:
                if "rem genre" in line.lower():
                    genre = line.split('"')[1].lower()
                    verification = input(f"is '{genre}' the correct genre? [Y/n] ")
                    if verification.lower() == ("y" or "" or "yes"):
                        return genre
                    else:
                        return input("What's the album's genre? ")
        # if the 'REM GENRE' line exists but it doesn't have double quotes execute the exception
        except IndexError:
            return input("What's the album's genre? ")


def year_fetcher() -> str:
    cue_file = glob("*.cue")
    if not cue_file:
        return "0"
    cue_file = cue_file[0]
    with open(cue_file) as cue_sheet:
        contents = cue_sheet.readlines()
        for line in contents:
            if "rem date" in line.lower():
                date = line.split(" ")[-1]
                return date
        else:
            date = input("what year was the album released at? (leave empty for 0) ")
            if date:
                return date
            else:
                return "0"


def splitter(format: str, album_dir: str) -> None:
    call(
        f"shnsplit -f *.cue -t 'shnsplit %n. %t' -o flac *.{format} -d '{output_dir}/{album_dir}'",
        shell=True,
    )
    files = set(glob("*.cue") + glob("*.jpg") + glob("*.png"))
    for file in files:
        copy(file, f"{output_dir}/{album_dir}")


def tagger() -> None:
    call("cuetag *.cue *.flac || cuetag.sh *.cue *.flac", shell=True)


def converter(amount: int, genre: str, year: str = "0", album_dir: str = "") -> None:
    files = glob("*.flac")
    if amount == 1:
        for file in files:
            file = file.removesuffix(".flac")
            output = f"{file.removeprefix('shnsplit ')}.{args.extension}"
            call(
                f"ffmpeg -i '{file}.flac' -c:a {args.format} -b:a {args.bitrate} -metadata genre='{genre}' -metadata year='{year}' '{output}'",
                shell=True,
            )
    else:
        cover_art = set(glob("*.jpeg") + glob("*.jpg") + glob("*.png"))
        for pics in cover_art:
            copy(pics, f"{output_dir}/{album_dir}")
        for file in files:
            file = file.removesuffix(".flac")
            output = f"{output_dir}/{album_dir}/{file.removeprefix('shnsplit ')}.{args.extension}"
            call(
                f"ffmpeg -i '{file}.flac' -c:a {args.format} -b:a {args.bitrate} -metadata genre='{genre}' -metadata year='{year}' '{output}'",
                shell=True,
            )


def cleaner():
    garbage = set(glob("*.flac") + glob("*.cue"))
    for file in garbage:
        remove(file)


def main():
    for relative_album_path in args.input:
        album_dir = relative_album_path.split("/")[-1]
        format = base_format(relative_album_path)
        if not format:
            continue
        absolute_album_path = path.abspath(relative_album_path)
        chdir(absolute_album_path)
        raw_files = counting(format)
        if raw_files == 1:
            cue_exists()
            requirements(album_dir)
            genre = genre_fetcher(raw_files)
            year = year_fetcher()
            splitter(format, album_dir)
            chdir(f"{output_dir}/{album_dir}")
            tagger()
            converter(raw_files, genre, year)
            cleaner()
        elif raw_files > 1:
            requirements(album_dir)
            genre = genre_fetcher(raw_files)
            converter(raw_files, genre, album_dir=album_dir)


if __name__ == "__main__":
    main()
