#!/usr/bin/python3

import os
import argparse
import re

from subprocess import run

class COLORS:
    OK = '\033[94m'
    SUCCESS = '\033[92m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

parser = argparse.ArgumentParser(description='')
parser.add_argument('-p', '--prefix', help='the prefix', required=True)
parser.add_argument('-s', '--suffix', help='an optional suffix')
parser.add_argument('files', nargs='*', help='the files to rename')

args = parser.parse_args()

months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
]

months_str = '|'.join(months)

editions = {
    'austral': 'AU',
    'europe': 'EU',
    'international': 'Int',
    'uk': 'UK',
    'us': 'US',
}

re_correct = re.compile(rf'{args.prefix}-((?:20)?[1-2]\d)-(0?[1-9]|1[0-2])-(0?[1-9]|[1-2]\d|3[0-1])[^\d]', re.IGNORECASE)
re_edition = re.compile('|'.join(editions.keys()), re.IGNORECASE)
# matches: Month DD YY|YYYY
re_1 = re.compile(rf'({months_str})[^\d]*(0?[1-9]|[1-2]\d|3[0-1])[^\d]*(20[1-2]\d)[^\d]', re.IGNORECASE)
# matches: DD Month YY|YYYY
re_2 = re.compile(rf'(0?[1-9]|[1-2]\d|3[0-1])[^\d]*({months_str})[^\d]*(20[1-2]\d)[^\d]', re.IGNORECASE)
# matches: YY|YYYY Month DD
re_3 = re.compile(rf'(20[1-2]\d)[^\d]*({months_str})[^\d]*(0?[1-9]|[1-2]\d|3[0-1])[^\d]', re.IGNORECASE)
re_4 = re.compile('((?:20)?[1-2]\d)[^\d](0?[1-9]|1[0-2])[^\d](0?[1-9]|[1-2]\d|3[0-1])[^\d]', re.IGNORECASE)
re_ext = re.compile('\.pdf$')

def match_1(filename):
    m = re_1.search(filename)

    if (m):
        return [m.group(3), months.index(m.group(1).lower()) + 1, m.group(2)]

def match_2(filename):
    m = re_2.search(filename)

    if (m):
        return [m.group(3), months.index(m.group(2).lower()) + 1, m.group(1)]

def match_3(filename):
    m = re_3.search(filename)

    if (m):
        return [m.group(1), months.index(m.group(2).lower()) + 1, m.group(3)]

def match_4(filename):
    m = re_4.search(filename)

    if (m):
        return [m.group(1),  m.group(2), m.group(3)]

matches = [ match_1, match_2, match_3, match_4 ]

def two_digit(value):
    string = str(value)

    if len(string) == 2:
        return string
    
    return '0' + string
    



for filename in args.files:
    print(filename)
    if re_correct.match(filename):
        print('- ' + COLORS.OK + 'ALREADY CORRECT' + COLORS.ENDC)
        continue


    for match in matches:
        result = match(filename)

        if result:
            ext = re_ext.search(filename)
            edition = re_edition.search(filename)
            [ year, month, day ] = result
            new_filename = args.prefix + '-' + rf'{year}-{two_digit(month)}-{two_digit(day)}'

            if edition:
                new_filename += '-' + editions[edition.group(0).lower()]

            if args.suffix:
                new_filename += args.suffix

            count = 0

            while os.path.exists('./' + new_filename + ('' if count == 0 else '_' + str(count)) + ext.group(0)):
                count += 1
                
            new_filename += ('' if count == 0 else '_' + str(count)) + ext.group(0)

            os.rename(filename, new_filename)

            print('- ' + COLORS.SUCCESS + 'RENAMED: ' + new_filename + COLORS.ENDC)
            break
    else:
        print('- ' + COLORS.FAIL + 'NO MATCH!!!!' + COLORS.ENDC)
