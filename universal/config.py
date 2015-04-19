EXECUTABLE_GCC      = 'gcc'
EXECUTABLE_GPP      = 'g++'
EXECUTABLE_PYTHON   = 'python'
EXECUTABLE_JAVAC    = 'javac'
EXECUTABLE_JAVA     = 'java'

GCC_FLAGS = " -g -O2" \
            " -Wall -Wextra" \
            " -Isrc -rdynamic -fomit-frame-pointer" \
            " -lm -lrt"
GPP_FLAGS = " -g -O2" \
            " -Wall -Wextra" \
            " -std=c++11" \
            " -Isrc -rdynamic -fomit-frame-pointer"