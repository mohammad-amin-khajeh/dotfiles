#!/usr/bin/env python

import re
from glob import glob
from subprocess import call

files = set(glob("*.jpg") + glob("*.png") + glob("*.mp4"))
intab = "۱۲۳۴۵۶۷۸۹۰١٢٣٤٥٦٧٨٩٠"
outtab = "12345678901234567890"
translation_table = str.maketrans(intab, outtab)

for file in files:
    if dates := re.search(
        r".*(\d{4})-*(\d{2})-*(\d{2})_(\d{2})-*(\d{2})-*(\d{2})", file
    ):
        year = dates.group(1).translate(translation_table)
        month = dates.group(2).translate(translation_table)
        day = dates.group(3).translate(translation_table)
        hour = dates.group(4).translate(translation_table)
        minute = dates.group(5).translate(translation_table)
        second = dates.group(6).translate(translation_table)

        call(
            f"touch -m -d '{year}/{month}/{day} {hour}:{minute}:{second}' '{file}'",
            shell=True,
        )
