#!/usr/bin/python3

import os
import argparse
from subprocess import run

default_dirs = [
  '.config',
  '.local',
  '.password-store',
  '.ssh',
  '.vault',
  'bin',
  'biz',
  'cfg',
  'dev',
  'doc',
  'edu',
  'img',
  'jot',
  'lib',
  'usr',
]

checksum_dirs = [
 '.vault'
]

parser = argparse.ArgumentParser()

group = parser.add_mutually_exclusive_group(required=True)
group.add_argument('-B', '--backup', help='Backup files to the remote location', action='store_true')
group.add_argument('-R', '--restore', help='Restore files from the remote location', action='store_true')
parser.add_argument('-d', '--dry-run', help='Run rsync in a dry run', action='store_true')
parser.add_argument('-r', '--remote', help='The remote location', default='lohfu@loader:~/home')
parser.add_argument('-l', '--local', help='The local location', default=os.environ['HOME'])
parser.add_argument('dir', type=str, nargs='*', help='the directories to copy', default=default_dirs)
args = parser.parse_args()

if (args.backup): 
    src = args.local
    dest = args.remote
else:
    src = args.remote
    dest = args.local

def sync(params, dirs):
    if (args.dry_run):
        params += 'n'

    dirs = map(lambda x: os.path.join(src, x), dirs)

    command = ['rsync', params, '--delete', '--filter=: .rsync']
    command.extend(dirs)
    command.append(dest)

    run(command)


regular_param_dirs = [ x for x in args.dir if x not in checksum_dirs ]
checksum_param_dirs = [ x for x in args.dir if x in checksum_dirs ]

if (len(regular_param_dirs)):
    sync('-av', regular_param_dirs)

if (len(checksum_param_dirs) > 0):
    sync('-acv', checksum_param_dirs)
