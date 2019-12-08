#!/usr/bin/python3

import os
import argparse
from subprocess import run

storage_root = '/mnt/storage'
home_root = '~'

home_dirs = [
  'archives',
  'photos',
]

storage_dirs = [
  'ebooks',
  'music',
]

parser = argparse.ArgumentParser()

group = parser.add_mutually_exclusive_group(required=True)
group.add_argument('-B', '--backup', help='Backup files to the remote location', action='store_true')
group.add_argument('-R', '--restore', help='Restore files from the remote location', action='store_true')
parser.add_argument('-d', '--dry-run', help='Run rsync in a dry run', action='store_true')
parser.add_argument('-r', '--remote', help='The remote location', default='lohfu@loader')
parser.add_argument('-l', '--local', help='The local location', default='/mnt/storage')
parser.add_argument('dir', type=str, nargs='*', help='the directories to copy', default=home_dirs + storage_dirs)
args = parser.parse_args()


def sync(params, dirs, server_dir):
    if (args.backup):
        src = args.local
        dest = args.remote + ':' + server_dir
    else:
        src = args.remote + ':' + server_dir
        dest = args.local

    if (args.dry_run):
        params += 'n'

    dirs = map(lambda x: os.path.join(src, x), dirs)

    command = ['rsync', params, '--delete', '--filter=: .rsync']
    command.extend(dirs)
    command.append(dest)

    run(command)

home_dirs = [ x for x in args.dir if x in home_dirs ]
storage_dirs = [ x for x in args.dir if x in storage_dirs ]

if (len(home_dirs) > 0):
    sync('-av', home_dirs, home_root)

if (len(storage_dirs)):
    sync('-av', storage_dirs, storage_root)
