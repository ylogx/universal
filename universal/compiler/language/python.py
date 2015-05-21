from __future__ import print_function
import os
from .language import Language
from universal.config import EXECUTABLE_PYTHON
from universal.util import perform_system_command, get_file_tuple


class Python(Language):
    @staticmethod
    def extension():
        return 'py'

    def __init__(self, filename):
        """ :param filename: file to use
        """
        self.filename = filename

    def compile(self):
        """ :return: 0 if compilation successful
        """
        return 0

    def run(self):
        command_run = get_command_to_run(self.filename)
        return perform_system_command(command_run)


def get_command_to_run(filename):
    (directory, name, extension) = get_file_tuple(filename)

    command_run = EXECUTABLE_PYTHON + " " + filename
    test_file = directory + "/" + name + ".input"
    if os.path.exists(test_file):
        command_run += " < " + test_file
    return command_run
