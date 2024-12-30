#!/usr/bin/env python

import re
from glob import glob
from subprocess import call

files = set(glob("*.jpg") + glob("*.png") + glob("*.mp4"))

for file in files:
    if dates := re.search(r"(\d{4})(\d{2})(\d{2})_(\d{2})(\d{2})(\d{2})", file):
        call(
            f"touch -d '{dates.group(1)}/{dates.group(2)}/{dates.group(3)} {dates.group(4)}:{dates.group(5)}:{dates.group(6)}' '{file}'",
            shell=True,
        )
