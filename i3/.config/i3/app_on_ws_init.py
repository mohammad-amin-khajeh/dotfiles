#!/usr/bin/env python

from i3ipc import Connection
import argparse

parser = argparse.ArgumentParser(
    description="execute commands based on the newly created workspace"
)

parser.add_argument(
    "--workspace",
    nargs="+",
    required=True,
)

parser.add_argument(
    "--command",
    nargs="+",
    required=True,
)

args = parser.parse_args()

i3 = Connection()


def on_workspace(i3, e):
    if e.current.name in args.workspace[0] and not len(e.current.leaves()):
        i3.command("exec --no-startup-id {}".format(args.command[0]))

    elif e.current.name in args.workspace[1] and not len(e.current.leaves()):
        i3.command("exec --no-startup-id {}".format(args.command[1]))

    elif e.current.name in args.workspace[2] and not len(e.current.leaves()):
        i3.command("exec --no-startup-id {}".format(args.command[2]))

    elif e.current.name in args.workspace[3] and not len(e.current.leaves()):
        i3.command("exec --no-startup-id {}".format(args.command[3]))

    elif e.current.name in args.workspace[4] and not len(e.current.leaves()):
        i3.command("exec --no-startup-id {}".format(args.command[4]))

    elif e.current.name in args.workspace[5] and not len(e.current.leaves()):
        i3.command("exec --no-startup-id {}".format(args.command[5]))

    elif e.current.name in args.workspace[6] and not len(e.current.leaves()):
        i3.command("exec --no-startup-id {}".format(args.command[6]))


i3.on("workspace::focus", on_workspace)

i3.main()
