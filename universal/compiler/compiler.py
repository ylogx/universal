from ..util import get_file_tuple
from .language.gcc import Gcc

class Compiler():

    def __init__(self, filename):
        self.filename = filename

    def compile(self):
        (directory, name, extension) = get_file_tuple(self.filename)
        if extension == Gcc.extension():
            gcc = Gcc(self.filename)
            return_code = gcc.compile()
        return return_code

