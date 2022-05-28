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

re_correct = re.compile(rf'{args.prefix}-((?:19|20)\d\d)-(0?[1-9]|1[0-2])-(0?[1-9]|[1-2]\d|3[0-1])[^\d]', re.IGNORECASE)
re_edition = re.compile('|'.join(editions.keys()), re.IGNORECASE)
regexes = [
    # matches: DD Month YY|YYYY (needs to be before Month DD YY|YYYY)
    re.compile(rf'(?P<day>0?[1-9]|[1-2]\d|3[0-1])[^\d]*(?P<month>{months_str})[^\d]*(?P<year>(?:19|20)?\d\d)[^\d]', re.IGNORECASE),
    # matches: Month DD YY|YYYY
    re.compile(rf'(?P<month>{months_str})[^\d]*(?P<day>0?[1-9]|[1-2]\d|3[0-1])[^\d]*(?P<year>(?:19|20)?\d\d)[^\d]', re.IGNORECASE),
    # matches: YY|YYYY Month DD
    re.compile(rf'(?P<year>(?:19|20)?\d\d)[^\d]*(?P<month>{months_str})[^\d]*(?P<day>0?[1-9]|[1-2]\d|3[0-1])[^\d]', re.IGNORECASE),
    # matches: YY|YYYY M|MM D|DD
    re.compile('(?P<year>(?:19|20)?\d\d)[^\d](?P<month>0?[1-9]|1[0-2])[^\d](?P<day>0?[1-9]|[1-2]\d|3[0-1])[^\d]', re.IGNORECASE),
    # matches: YY|YYYYMMDD
    re.compile('(^|[^\d])(?P<year>(?:19|20)?\d\d)(?P<month>0[1-9]|1[0-2])(?P<day>0[1-9]|[1-2]\d|3[0-1])[^\d]', re.IGNORECASE),
    # matches: DD?MM?YY|YYYY
    re.compile('(^|[^\d])(?P<day>0[1-9]|[1-2]\d|3[0-1])[^\d]?(?P<month>0[1-9]|1[0-2])[^\d]?(?P<year>(?:19|20)?\d\d)[^\d]', re.IGNORECASE),
    # matches: MM?DD?YY|YYYY
    re.compile('(^|[^\d])(?P<month>0[1-9]|1[0-2])[^\d]?(?P<day>0[1-9]|[1-2]\d|3[0-1])[^\d]?(?P<year>(?:19|20)?\d\d)[^\d]', re.IGNORECASE),
]
re_ext = re.compile('\.\w+$')


def two_digit(value):
    string = str(value)

    if len(string) == 2:
        return string
    
    return '0' + string
    
def month_number(value):
    try:
        return months.index(value.lower()) + 1
    except (AttributeError, ValueError):
        return value


for filename in args.files:
    if re_correct.match(filename):
        print('- ' + COLORS.OK + 'ALREADY CORRECT: ' + filename + COLORS.ENDC)
        continue

    for idx, regex in enumerate(regexes):
        m = regex.search(filename)

        if m:
            print('match ' + str(idx))
            result = [m.group('year'),  month_number(m.group('month')), m.group('day')]
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

            print('- ' + COLORS.SUCCESS + 'RENAMED: ' + filename + ' -> ' + new_filename + ' (match ' + str(idx) + ')' + COLORS.ENDC)
            break
    else:
        print('- ' + COLORS.FAIL + 'NO MATCH: ' + filename + COLORS.ENDC)

