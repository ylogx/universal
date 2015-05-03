from __future__ import print_function

import os
import shutil
import subprocess

def perform_system_command(command):
    print("Doing: ", command)
    out = os.system(command)
    return int(out)


def get_file_tuple(filename):
    directory = os.path.dirname(os.path.abspath(filename))
    basename = os.path.basename(filename)
    filename_tuple = basename.split('.')
    extension = filename_tuple[-1]
    name = '.'.join(filename_tuple[:-1])
    return directory, name, extension

def check_exec_installed(exec_list):
    """ Check the required programs are
        installed.
        PARAM exec_list: list of programs to check
        RETURN: True if all installed else False
    """
    all_installed = True
    for exe in exec_list:
        if not is_tool(exe):
            print("Executable: " + exe + " is not installed")
            all_installed = False
    return all_installed

def is_tool(name):
    try:
        devnull = open(os.devnull)
        subprocess.Popen([name], stdout=devnull, stderr=devnull).communicate()
    except OSError as e:
        if e.errno == os.errno.ENOENT:
            return False
    return True


def update():
    """ Updates the tool
    """
    check_exec_installed(['pip'])
    perform_system_command("pip install --upgrade universal")


def problem():
    """ Opens a Issue page @github
        to raise a issue.
    """
    print("Thanks in advance for taking out time")
    print("Click on the green New Issue button on the right side")
    print("Opening browser")
    perform_system_command("xdg-open "
            "'https://github.com/shubhamchaudhary/universal/issues'")
