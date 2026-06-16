#!/usr/bin/python3

import os
import argparse
from subprocess import run

storage_root = '/mnt/storage'
home_root = '~/'

home_dirs = [
    'archives',
    'photos',
    'tmp',
    'tmp2',
]

storage_dirs = [
    'ebooks',
    'music',
]

parser = argparse.ArgumentParser(add_help=False)

group = parser.add_mutually_exclusive_group(required=True)
parser.add_argument('--help', action='help', help='show this help message and exit')
group.add_argument('-B', '--backup', help='backup files TO the remote location', action='store_true')
group.add_argument('-R', '--restore', help='restore files FROM the remote location', action='store_true')
parser.add_argument('-d', '--dry-run', help='run rsync in a dry run', action='store_true')
parser.add_argument('-c', '--checksum', help='checksum', action='store_true')
parser.add_argument('-m', '--merge', help='do not delete files', action='store_true')
parser.add_argument('-h', '--host', help='remote host', default='lohfu@loader')
parser.add_argument('-l', '--local', help='local location', default=os.path.join(os.environ['HOME'], 'media'))
parser.add_argument('dir', type=str, nargs='*', help='directories to copy', default=home_dirs + storage_dirs)
args = parser.parse_args()


def sync(params, dirs, remote_dir):
    if args.backup:
        src = args.local
        dest = args.host + ':' + remote_dir
    else:
        src = args.host + ':' + remote_dir
        dest = args.local

    if args.dry_run:
        params += 'n'

    if args.checksum:
        params += 'c'

    dirs = map(lambda x: os.path.join(src, x), dirs)

    command = ['rsync', params, '--filter=: .rsync']

    if not args.merge:
        command.append('--delete')

    command.extend(dirs)
    command.append(dest)

    run(command)


home_dirs = [x for x in args.dir if x in home_dirs]
storage_dirs = [x for x in args.dir if x in storage_dirs]

# rsync -a means:
#   r: recursive
#   l: when symlinks are encountered, recreate the symlink on the destination
#   p: preserve permissions
#   t: preserve times
#   g: preserve group
#   o: preserver owner
#   D: equal to --devices --specials
#   k, --copy-dirlinks: causes the sending side to treat a symlink to a directory as though it were a real directory
#   K, --keep-dirlinks
default_params = '-rltDvkK'

if len(home_dirs) > 0:
    sync(default_params, home_dirs, home_root)

if len(storage_dirs):
    sync(default_params, storage_dirs, storage_root)
