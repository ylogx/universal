from .language import Language

class Gcc(Language):
    @staticmethod
    def extension():
        return 'c'

    def compile(self, filename):
        pass

    def run(self):
        pass