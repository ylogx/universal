from __future__ import print_function
import os
from .language import Language
from universal.config import EXECUTABLE_GPP, DEFAULT_GPP_FLAGS
from universal.util import perform_system_command, get_file_tuple


class Gpp(Language):
    @staticmethod
    def extension():
        return 'cpp'

    def __init__(self, filename):
        """ :param filename: file to use
        """
        self.filename = filename

    def compile(self):
        """ :return: 0 if compilation successful
        """
        command = get_command_for_compilation(self.filename)
        return perform_system_command(command)

    def run(self):
        command_run = get_command_to_run(self.filename)
        return perform_system_command(command_run)


def get_command_for_compilation(filename):
    (directory, name, extension) = get_file_tuple(filename)
    output_filename = directory + '/' + name + '.out'
    command = EXECUTABLE_GPP + ' ' + \
              DEFAULT_GPP_FLAGS + \
              ' -o ' + output_filename + \
              ' ' + filename
    return command


def get_command_to_run(filename):
    (directory, name, extension) = get_file_tuple(filename)
    output_file = directory + '/' + name + '.out'
    command_run = output_file
    test_file = directory + '/' + name + '.input'
    if os.path.exists(test_file):
        command_run += ' < ' + test_file
    return command_run
