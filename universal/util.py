from __future__ import print_function

import os
import shutil

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
