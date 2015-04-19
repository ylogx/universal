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
    ''' Check the required programs are
        installed.
        PARAM exec_list: list of programs to check
        RETURN: True if all installed else False
    '''

    all_installed = True
    for exe in exec_list:
        if shutil.which(exe) is None:
            print("Executable: " + exe + " is not installed")
            all_installed = False
    return all_installed


def update():
    ''' Updates the tool
    '''
    if not check_exec_installed(["wget", "unzip"]):
        print("please install the missing executables and retry")
        exit(1)

    # retrieve new file
    subprocess.call(["wget", "-c", \
                     "https://github.com/shubhamchaudhary/universal/archive/master.zip"])

    # able to successfully retrieve the file
    perform_system_command("unzip master.zip")

    os.chdir("universal-master/")  # preferred way to change directory
    perform_system_command("sh install")
    os.chdir("../")
    perform_system_command("rm -rf ./universal-master master.zip")
#    os.chdir("-")


def problem():
    ''' Opens a Issue page @github
        to raise a issue.
    '''
    print("Thanks in advance for taking out time")
    print("Click on the green New Issue button on the right side")
    print("Opening browser")
    perform_system_command("xdg-open \
            'https://github.com/shubhamchaudhary/universal/issues'")
