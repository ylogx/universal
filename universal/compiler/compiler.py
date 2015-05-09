from ..util import get_file_tuple
from .language.gcc import Gcc

class Compiler():

    def compile(self, filename):
        (directory, name, extension) = get_file_tuple(filename)
        if extension == Gcc.extension():
            gcc = Gcc()
            gcc.compile(filename)

