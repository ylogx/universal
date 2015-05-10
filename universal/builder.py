#!/usr/bin/env python3
#
#   universal.py - A tool to quickly compile and run different
#   source files using same command
#   This file is a part of Universal Competitive Programming Suite.
#
#   Copyright (c) 2011-2015 Shubham Chaudhary <me@shubhamchaudhary.in>
#   Copyright (c) 2015 Harsimran <harsimran_hs4@yahoo.co.in>
#
#   Universal is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Universal is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Universal.  If not, see <http://www.gnu.org/licenses/>.
#

from __future__ import print_function

import os
from universal.compiler.compiler import Compiler

from universal.config import EXECUTABLE_GCC
from universal.config import EXECUTABLE_GPP
from universal.config import EXECUTABLE_JAVA
from universal.config import EXECUTABLE_JAVAC
from universal.config import EXECUTABLE_PYTHON
from universal.config import GCC_FLAGS
from universal.config import GPP_FLAGS
from universal.pretty_printer import RESET, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE
from universal.util import get_file_tuple
from universal.util import perform_system_command


def compile_files(args, mem_test=False):
    ''' Copiles the files and runs memory tests
        if needed.
        PARAM args: list of files passed as CMD args
                    to be compiled.
        PARAM mem_test: Weither to perform memory test ?
    '''
    for filename in args:
        if not os.path.isfile(filename):
            print('The file doesn\'t exits')
            return
        build_and_run_file(filename)
        print("")


def build_and_run_file(filename):
    ''' Builds and runs the filename specified
        according to the extension
        PARAM filename: name of file to build and run
    '''
    (directory, name, extension) = get_file_tuple(filename)
    if extension == 'c':
        print(" = = = = = = ", YELLOW, "GCC: Compiling " + filename + " file", \
              RESET, " = = = = = =\n")
        compiler = Compiler(filename)
        out = compiler.compile()
        if out != 0:
            print('Error while compiling. Code:', out, 'Please retry.')
            return out
        print("")

        out = compiler.run()
        return out

    elif extension == 'cpp':
        print(" = = = = = = ", YELLOW, "GPP: Compiling " + filename + " file", \
              RESET, " = = = = = =\n")
        compiler = Compiler(filename)
        out = compiler.compile()
        if out != 0:
            print('Error while compiling. Code:', out, 'Please retry.')
            return out
        print("")

        out = compiler.run()
        return out

    elif extension == 'py':
        print(" = = = = = = ", YELLOW, "PYTHON: Executing " + filename + " file", \
              RESET, " = = = = = =\n")
        command_run = EXECUTABLE_PYTHON + " " + filename
        test_file = directory + "/" + name + ".input"
        if os.path.exists(test_file):
            command_run += " < " + test_file
        return perform_system_command(command_run)
    elif extension == 'java':
        command = EXECUTABLE_JAVAC + ' ' + filename
        perform_system_command(command)
        command_run = EXECUTABLE_JAVA + ' ' + name
        test_file = directory + "/" + name + ".input"
        if os.path.exists(test_file):
            command_run += " < " + test_file
        return perform_system_command(command_run)
    else:
        print("Language yet not supported")
        return -1


def memory_test(filename):
    ''' make sure filename.test exits and call
        for valgrind(choose to perform memory test)
        PARAM filename: name  of file to run test on
    '''
    (directory, name, extension) = get_file_tuple(filename)
    # if not c or cpp files, no mem test to run
    if extension != 'c' and extension != 'cpp':
        return
    test_file = name + ".test"
    print("Test file: " + test_file)
    # print(len(args), args)
    if not os.path.isfile(test_file):
        print("Test file not found")
        return
    valgrind_test(test_file)


def valgrind_test(filename):
    ''' Runs memory test using valgrind
        on the file.
        PARAM filename: filename to run test for
    '''
    print("Valgrind test results")
    ##TODO##
