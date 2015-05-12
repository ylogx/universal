import os
try:
    import configparser
except ImportError as e:
    import configparser2 as configparser

EXECUTABLE_GCC      = 'gcc'
EXECUTABLE_GPP      = 'g++'
EXECUTABLE_PYTHON   = 'python'
EXECUTABLE_JAVAC    = 'javac'
EXECUTABLE_JAVA     = 'java'

DEFAULT_GCC_FLAGS = " -g -O2" \
                    " -Wall -Wextra" \
                    " -Isrc -rdynamic -fomit-frame-pointer" \
                    " -lm -lrt"
DEFAULT_GPP_FLAGS = " -g -O2" \
                    " -Wall -Wextra" \
                    " -std=c++11" \
                    " -Isrc -rdynamic -fomit-frame-pointer"

FLAG_SECTION_KEY = 'flags'
FLAG_GCC = 'gcc'
FLAG_GPP = 'gpp'


def get_gcc_flags():
    return get_flag_value(FLAG_GCC, DEFAULT_GCC_FLAGS)


def get_gpp_flags():
    return get_flag_value(FLAG_GPP, DEFAULT_GPP_FLAGS)


def get_flag_value(flag_key, fallback):
    config = get_config_file()
    if (config is not None
            and FLAG_SECTION_KEY in config.sections()):
        return config.get(FLAG_SECTION_KEY, flag_key, fallback=fallback)
    return fallback


def get_config_file():
    config = configparser.ConfigParser()
    config.read(get_config_filename())
    return config


def get_config_filename():
    return os.path.join(os.path.expanduser('~'), '.universalrc')
