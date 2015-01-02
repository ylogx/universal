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
import subprocess
import shutil
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
    print( "    #        + + + ",Fore.YELLOW,"Universal Compiler Help",\
            Fore.RESET," + + +      (c) #",sep='')
    print( "    #                                                     #")
    print( "    # Aliases: '",GREEN,"universal",RESET,"' and '",GREEN,"u",\
            RESET,"' and '",GREEN,"c",RESET,"'                #",sep='')
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
    print( "    # File Extensions: ",BLUE,"*.c .cpp .py .java .pl .sh",\
            RESET,"         #",sep='')
    print( "    #                                                     #")
    print( "    # ",RED,"Update Version",RESET,": `",MAGENTA,"universal -u",\
            RESET,"` i.e. `",MAGENTA,"u -u",RESET,"`          #",sep='')
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
    directory = os.path.dirname(os.path.abspath(filename))
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
EXECUTABLE_JAVAC    = 'javac'
EXECUTABLE_JAVA     = 'java'


def build_file(filename):
    (directory, name,extension) = get_file_tuple(filename)
    if (extension == 'c'):
        print(" = = = = = = ",YELLOW,"GCC: Compiling "+filename+" file",\
                RESET," = = = = = =\n");
        output_filename = directory + '/' + name + '.out'
        command = EXECUTABLE_GCC + " " + \
                    GCC_FLAGS + \
                    " -o " + output_filename + \
                    ' ' + filename
        return perform_system_command(command)
    elif (extension == 'cpp'):
        print(" = = = = = = ",YELLOW,"GPP: Compiling "+filename+" file",\
                RESET," = = = = = =\n");
        output_filename = directory + '/' + name + '.out'
        command = EXECUTABLE_GPP + ' ' + \
                    GPP_FLAGS + \
                    ' -o ' + output_filename + \
                    ' ' + filename
        return perform_system_command(command)
    elif (extension == 'py'):
        print(" = = = = = = ",YELLOW,"GCC: Compiling $filename .c file",\
                RESET," = = = = = =\n");
        command = EXECUTABLE_PYTHON + " " + filename
        return perform_system_command(command)
    elif (extension == 'java'):
        command = EXECUTABLE_JAVAC + ' ' + filename
        perform_system_command(command)
        command_secondary = EXECUTABLE_JAVA + ' '+ name
        perform_system_command(command_secondary)

def compile_files(args):
    for filename in args:
        if not os.path.isfile(filename):
            print('The file doesn\'t exits')
            return
        build_file(filename)

def check_exec_installed(args):
    ''' Check the required programs are
    installed'''

    all_installed = True
    for exe in args:
        if shutil.which(exe) == None:
            print("Executable: " + exe + " is not installed")
            all_installed = False
    return all_installed

def update():
    if not check_exec_installed(["wget", "unzip"]):
        print("please install the missing executables and retry")
        exit(1)
##    try:
##        subprocess.call(["wget", "-c", \
##            "https://github.com/shubhamchaudhary/universal/archive/master.zip"])
##    except OSError as e:
##        if e.errno == os.errno.ENOENT:
##            print("Wget is not intalled. Please install 'wget' before updating")
##            print("Aborting...")
##            exit(1);
##        else:
##            print("Some error occured...please try again.")
    subprocess.call(["wget", "-c", \
            "https://github.com/shubhamchaudhary/universal/archive/master.zip"])
    # able to successfully retrieve the file
    perform_system_command("unzip master.zip")
    os.chdir("universal-master/") # preferred way to change directory
#    perform_system_command("pwd")
    perform_system_command("sh install")
    os.chdir("../")
    perform_system_command("rm -rf ./universal-master master.zip")
#    os.chdir("-")

def problem():
    print("Thanks in advance for taking out time")
    print("Click on the green New Issue button on the right side")
    print("Opening browser")
    perform_system_command("xdg-open \
            'https://github.com/shubhamchaudhary/universal/issues'")

def main():
    # Parse command line arguments
    usage = "%prog [ -h | --help | -u | --update | -p | --problem ]";
    parser = OptionParser(usage=usage, version="%prog "+__version__ , add_help_option=False)
    parser.add_option("-u", "--update", action='store_true', dest="update",
                        help="Update the software from online repo")
    parser.add_option("-p", "--problem", action='store_true', dest="problem",
                        help="Report a problem")
    parser.add_option("-h", "--help", action='store_true', dest="help",
                        help="Report a problem")
    (options, args) = parser.parse_args()
    # print(options)
    argc = len(args);

    if argc > 0:
        compile_files(args);
    if options.update:
        return update();
    if options.problem:
        return problem()
    if options.help:
        return helpFun()


__version__ = '1.9.2'
if __name__ == '__main__':
    sys.exit(main());
