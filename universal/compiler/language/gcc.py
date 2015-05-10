from __future__ import print_function
import os
from .language import Language
from universal.config import EXECUTABLE_GCC, GCC_FLAGS
from universal.pretty_printer import YELLOW, RESET
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
        command, directory, name = self.get_command_for_compilation(self.filename)
        out = perform_system_command(command)
        return out

    def run(self):
        command_run = self.get_command_to_run()
        return perform_system_command(command_run)

    def get_command_for_compilation(self, filename):
        (directory, name, extension) = get_file_tuple(filename)
        output_filename = directory + '/' + name + '.out'
        command = EXECUTABLE_GCC + " " + \
                  GCC_FLAGS + \
                  " -o " + output_filename + \
                  ' ' + filename
        return command, directory, name

    def get_command_to_run(self):
        (directory, name, extension) = get_file_tuple(self.filename)
        output_file = directory + "/" + name + ".out"
        command_run = output_file
        test_file = directory + "/" + name + ".input"
        if os.path.exists(test_file):
            command_run += " < " + test_file
        return command_run
