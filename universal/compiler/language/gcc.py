from __future__ import print_function
import os
from .language import Language
from universal.config import EXECUTABLE_GCC, GCC_FLAGS
from universal.util import perform_system_command, get_file_tuple


class Gcc(Language):
    @staticmethod
    def extension():
        return 'c'

    def __init__(self, filename):
        self.filename = filename

    def compile(self):
        """
        :param filename: file to compile
        :return: 0 if compilation successful
        """
        # Filename should be checked where called from
        command, directory, name = get_command_for_compilation(self.filename)
        return perform_system_command(command)

    def run(self):
        command_run = get_command_to_run(self.filename)
        return perform_system_command(command_run)


def get_command_to_run(filename):
    (directory, name, extension) = get_file_tuple(filename)
    output_file = directory + "/" + name + ".out"
    command_run = output_file
    test_file = directory + "/" + name + ".input"
    if os.path.exists(test_file):
        command_run += " < " + test_file
    return command_run

def get_command_for_compilation(filename):
    (directory, name, extension) = get_file_tuple(filename)
    output_filename = directory + '/' + name + '.out'
    command = EXECUTABLE_GCC + " " + \
              GCC_FLAGS + \
              " -o " + output_filename + \
              ' ' + filename
    return command, directory, name
