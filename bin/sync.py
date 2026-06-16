#!/usr/bin/python3

import os
import argparse
from subprocess import run
from datetime import datetime

default_dirs = [
    '.config',
    '.local',
    '.pgadmin',
    '.password-store',
    '.ssh',
    '.vault',
    '.zotero',
    'bin',
    'biz',
    'cfg',
    'dev',
    'doc',
    'edu',
    'img',
    'own',
    'jot',
    'lib',
    'usr',
]

checksum_dirs = ['.vault']

parser = argparse.ArgumentParser(add_help=False)

group = parser.add_mutually_exclusive_group(required=True)
parser.add_argument('--help', action='help', help='show this help message and exit')
group.add_argument('-B', '--backup', help='backup files to the remote location', action='store_true')
group.add_argument('-R', '--restore', help='restore files from the remote location', action='store_true')
parser.add_argument('-d', '--dry-run', help='run rsync in a dry run', action='store_true')
parser.add_argument('-h', '--host', help='remote host', default='lohfu@loader')
parser.add_argument('-r', '--remote-dir', help='remote location', default='~/home')
parser.add_argument('-l', '--local-dir', help='local location', default=os.environ['HOME'])
parser.add_argument('dir', type=str, nargs='*', help='directories to copy', default=default_dirs)
args = parser.parse_args()

remote = f'{args.host}:{args.remote_dir}'

if args.backup:
    src = args.local_dir
    dest = remote
else:
    src = remote
    dest = args.local_dir


def sync(params, dirs):
    if args.dry_run:
        params += 'n'

    dirs = map(lambda x: os.path.join(src, x), dirs)

    command = ['rsync', params, '--delete', '--filter=: .rsync']
    command.extend(dirs)
    command.append(dest)

    run(command)


regular_param_dirs = [x for x in args.dir if x not in checksum_dirs]
checksum_param_dirs = [x for x in args.dir if x in checksum_dirs]

if len(regular_param_dirs):
    sync('-av', regular_param_dirs)

if len(checksum_param_dirs) > 0:
    sync('-acv', checksum_param_dirs)


BLUE = '\033[94m'
GREEN = '\033[92m'
WHITE = '\033[0m'
RED = '\033[91m'

print(
    f'\n{"!DRY! " if args.dry_run else ""}finished {f"{GREEN}backup{WHITE}" if args.backup else f"{RED}restore{WHITE}"} @ {BLUE}{str(datetime.now())}{WHITE}'
)
