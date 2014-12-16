#!/usr/bin/env python3
#
#   universal.py - A tool to quickly compile and run different
#   source files using same command
#   Copyright (c) 2011-2014 Shubham Chaudhary <me@shubhamchaudhary.in>
#
#   This file is a part of Universal.
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

import os
import sys
from ansi import Fore, Back, Style;
from optparse import OptionParser
BLACK = '\033[30m'
RED = '\033[31m'
GREEN = '\033[32m'
YELLOW = '\033[33m'
BLUE = '\033[34m'
MAGENTA = '\033[35m'
CYAN = '\033[36m'
WHITE = '\033[37m'
RESET = '\033[39m'

def helpFun():
    print( "") #newline
    #print( "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print( "    #######################################################")
    print( "    #        + + + ",Fore.YELLOW,"Universal Compiler Help",Fore.RESET," + + +      (c) #",sep='')
    print( "    #                                                     #")
    print( "    # Aliases: '",GREEN,"universal",RESET,"' and '",GREEN,"u",RESET,"' and '",GREEN,"c",RESET,"'                #",sep='')
    print( "    # That means you may also use:                        #")
    print( "    #       `u --help`   or   `universal --help`          #")
    print( "    #                                                     #")
    print( "    # USAGE:  universal <filename>                        #")
    print( "    #         universal <filename> <test option>          #")
    print( "    # e.g      'universal hello.cpp'                      #")
    print( "    #          'universal HelloWorld.java'                #")
    print( "    # Automated Testing options: t, t1, t2, t3            #")
    print( "    # For this full help:  'universal -h'                 #")
    print( "    #                                                     #")
    #print( "    # Supports with '.c' '.cpp' '.py' '.java' '.pl' '.sh' #")
    print( "    # File Extensions: ",BLUE,"*.c .cpp .py .java .pl .sh",RESET,"         #",sep='')
    print( "    #                                                     #")
    print( "    # ",RED,"Update Version",RESET,": `",MAGENTA,"universal -u",RESET,"` i.e. `",MAGENTA,"u -u",RESET,"`          #",sep='')
    print( "    #              Or see README.md to get download link  #")
    print( "    #                                                     #")
    print( "    #######################################################")
    print( "    # Program: Universal Compiler - Reducing headaches    #")
    print( "    # Author : Shubham Chaudhary                          #")
    print( "    #######################################################")
    #print( "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print( "")   #newline

def perform_system_command(command):
    print("Doing: ",command);
    out = os.system(command);

def get_file_tuple(filename):
    directory = os.path.dirname(filename)
    basename = os.path.basename(filename)
    filename_tuple = basename.split('.')
    extension = filename_tuple[-1]
    name = '.'.join(filename_tuple[:-1])
    return (directory, name,extension)

GCC_FLAGS = " -g -O2" \
            " -Wall -Wextra" \
            " -Isrc -rdynamic -fomit-frame-pointer" \
            " -lm -lrt"
GPP_FLAGS = " -g -O2" \
            " -Wall -Wextra" \
            " -std=c++11" \
            " -Isrc -rdynamic -fomit-frame-pointer"
EXECUTABLE_GCC      = 'gcc'
EXECUTABLE_GPP      = 'g++'
EXECUTABLE_PYTHON   = 'python'


def build_file(filename):
    (directory, name,extension) = get_file_tuple(filename)
    if (extension == 'c'):
        print(" = = = = = = ",YELLOW,"GCC: Compiling "+filename+" file",RESET," = = = = = =\n");
        output_filename = directory + '/' + name + '.out'
        command = EXECUTABLE_GCC + " " + \
                    GCC_FLAGS + \
                    " -o " + output_filename + \
                    ' ' + filename
        return perform_system_command(command)
    elif (extension == 'cpp'):
        print(" = = = = = = ",YELLOW,"GPP: Compiling "+filename+" file",RESET," = = = = = =\n");
        output_filename = directory + '/' + name + '.out'
        command = EXECUTABLE_GPP + ' ' + \
                    GPP_FLAGS + \
                    ' -o ' + output_filename + \
                    ' ' + filename
        return perform_system_command(command)
    elif (extension == 'py'):
        print(" = = = = = = ",YELLOW,"GCC: Compiling $filename .c file",RESET," = = = = = =\n");
        command = EXECUTABLE_PYTHON + " " + filename
        return perform_system_command(command)
    elif (extension == 'java'):
        command = "javac " + filename
        perform_system_command(command)
        command_secondary = "java " + name
        perform_system_command(command_secondary)

def compile_files(args):
    for filename in args:
        if not os.path.isfile(filename):
            print('The file doesn\'t exits')
            return
        build_file(filename)

def main():
    # Parse command line arguments
    usage = "%prog [ -h | --help | -u | --update | -p | --problem ]";
    parser = OptionParser(usage=usage, version="%prog "+__version__ )
    parser.add_option("-u", "--update", action='store_true', dest="update",
                        help="Update the software from online repo")
    parser.add_option("-p", "--problem", action='store_true', dest="problem",
                        help="Report a problem")
    (options, args) = parser.parse_args()
    argc = len(args);

    if argc > 0:
        compile_files(args);
    if options.update:
        return update();


__version__ = '1.9.2'
if __name__ == '__main__':
    sys.exit(main());
