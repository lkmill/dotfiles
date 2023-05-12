#!/usr/bin/python3

import os
import sys
import subprocess
import argparse
import datetime
import re
from pathlib import Path

parser = argparse.ArgumentParser()

parser.add_argument('path', type=str, help='File to modify')
# parser.add_argument('url', type=str, help='URL of the screenshot')

path = parser.parse_args().path

def rename(file_path):
    try:
        process = subprocess.run(['exiftool', '-SubSecCreateDate', '-Quicktime:CreationDate', '-Quicktime:CreateDate', file_path], capture_output = True)
        m = re.search(r'([^+-]*)([-+][\d:]+)?', process.stdout.decode('utf-8').split('\n')[0])
        year, month, day, hours, minutes, seconds, *milliseconds = [int(i) for i in re.findall(r'\d+', m.group(1))][0:7]
        milliseconds = 0 if not len(milliseconds) else milliseconds[0]

        if m.group(2):
            m2 = re.search(r'([-\+])(\d{2}):(\d{2})', m.group(2))
            timedelta = datetime.timedelta(hours=int(m2.group(2)), minutes=int(m2.group(3)))
            tz = datetime.timezone(-timedelta if m2.group(1) == '-' else timedelta) 
        else:
            tz = datetime.timezone.utc

        dt = datetime.datetime(year, month, day, hours, minutes, seconds, milliseconds * 1000, tz)

        dir = os.path.split(file_path)[0]
        ext = os.path.splitext(file_path)[1].lower()

        new_filename = str(dt.astimezone(datetime.timezone.utc).strftime('%Y%m%d_%H%M%S%f')[:-3]) + ext
        new_file_path = os.path.join(dir, new_filename)

        os.rename(file_path, new_file_path)

        print(file_path + ' > ' + new_file_path)
    except:
        print('Error: ', file_path)


if os.path.isdir(path):
    for filename in os.listdir(path):
        rename(os.path.join(path, filename))

else:
    rename(path)

## IDEAS

# - argument for choosing which exif property to use for date
# - argument for deciding what timezone (utc, current or the dates to begin with at least)
# - argument to skip tz, for example photos from the 5s did not have timezone
#   dates but the .mov files did. so if the .mov files had used timezone, then
#   the dates would not match the images taken around the same time
