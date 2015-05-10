from abc import ABCMeta, abstractmethod

class Language:
    __metaclass__ = ABCMeta

    @staticmethod
    @abstractmethod
    def extension():
        pass

    @abstractmethod
    def compile(self):
        pass

    @abstractmethod
    def run(self):
        pass

