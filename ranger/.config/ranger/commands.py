import subprocess
import os.path
from ranger.api.commands import Command

def fzf (fm, list_command):
    command = list_command + " | fzf +m"
    
    proc = fm.execute_command(command, stdout=subprocess.PIPE)

    stdout, stderr = proc.communicate()

    if proc.returncode == 0:
        result = stdout.decode('utf-8').rstrip('\n')
        return result

class fzf_select (Command):
    def execute(self):
        arg = self.arg(1)

        if (arg):
            if arg in self.fm.bookmarks:
                root_dir = self.fm.bookmarks[arg].realpath
            elif os.path.isdir(arg):
                root_dir = arg
            elif os.path.isfile(arg):
                root_dir = os.path.dirname(arg)
        else:
            root_dir = self.fm.thisdir.realpath

        command = self.get_command(root_dir)
        
        result = fzf (self.fm, command)

        if result:
            abs_path = os.path.join(root_dir, result)

            if os.path.isdir(abs_path):
                self.fm.cd(abs_path)
            else:
                self.fm.select_file(abs_path)

    def get_command(self, root_dir):
        cut = len(root_dir) + 2

        return "fd --hidden --follow --exclude '.git' '' " + root_dir + "| cut -b" + str(cut) + "-"


class fzf_select_file (fzf_select):
    def get_command(self, root_dir):
        cut = len(root_dir) + 2

        return "fd --type f --hidden --follow --exclude '.git' '' " + root_dir + "| cut -b" + str(cut) + "-"

class fzf_select_directory (fzf_select):
    def get_command(self, root_dir):
        cut = len(root_dir) + 2

        return "fd --type d --hidden --follow --exclude '.git' '' " + root_dir + "| cut -b" + str(cut) + "-"
