import os.path
import subprocess

import ranger.api
from ranger.container.directory import Directory

old_hook_init = ranger.api.hook_init

def hook_init(fm):
    command = 'git rev-parse --git-dir 2> /dev/null'

    proc = fm.execute_command(command, stdout=subprocess.PIPE)
    stdout, stderr = proc.communicate()

    if proc.returncode == 0:
        git_dir = stdout.decode('utf-8').rstrip('\n')

        fm.bookmarks.dct['%'] = Directory(os.path.dirname(os.path.abspath(git_dir)))
        fm.bookmarks.dct['$'] = Directory(os.path.abspath('.'))

    return old_hook_init(fm)

ranger.api.hook_init = hook_init
