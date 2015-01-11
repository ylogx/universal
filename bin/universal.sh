#!/usr/bin/env bash
#
#   universal.sh - A tool to quickly compile and run different
#   source files using same command
#   This file is a part of Universal Competitive Programming Suite.
#
#   Copyright (c) 2011-2015 Shubham Chaudhary <me@shubhamchaudhary.in>
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

##this script compiles .c & .cpp files
function usage {
    echo #newline
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo "    #######################################################"
    echo "    #           - - - Universal Usage - - -           (c) #"
    echo "    #                                                     #"
    echo "    # USAGE:  universal.sh <filename> <test option>       #"
    echo "    # Compaitable with '.c' '.cpp' '.py' '.java' files    #"
    echo "    #                                                     #"
    echo "    # For Full Help:  \`universal.sh help\`                 #"
    echo "    #                                                     #"
    echo "    #######################################################"
    echo "    # Program: Universal Competitive Programming Suite    #"
    echo "    #######################################################"
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo    #newline
}
function helpFun {
    echo #newline
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo "    #######################################################"
    echo "    #            + + + Universal Help + + +           (c) #"
    echo "    #                                                     #"
    echo "    # Aliases: 'universal' and 'universal.sh' and 'c'     #"
    echo "    # That means you may also use:                        #"
    echo "    #         \`universal help\` \`c help\`                   #"
    echo "    #                                                     #"
    echo "    # USAGE:  universal.sh <filename>                     #"
    echo "    #         universal.sh <filename> <test option>       #"
    echo "    # e.g      'universal.sh hello.cpp'                   #"
    echo "    #          'universal.sh HelloWorld.java'             #"
    echo "    # Automated Testing options: t, t1, t2, t3            #"
    echo "    # For Full Help:  'universal.sh help'                 #"
    echo "    #                                                     #"
    echo "    # Compaitable with '.c' '.cpp' '.py' '.java' files    #"
    echo "    #                                                     #"
    echo "    # Update Version: \`universal.sh update\`               #"
    echo "    #              Or see README.md to get download link  #"
    echo "    #                                                     #"
    echo "    #######################################################"
    echo "    # Program: Universal Competitive Programming Suite    #"
    echo "    #######################################################"
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo    #newline
}
############ Do automated testing by taking inputs from $filename.test file for C & C++ ##################
function memoryTest {
    if test $compiled == true ; then
        echo #newline
        if test -f $filename.test; then
            echo " * * * Valgrind Test: $filename.test found * * *"
            if test "$2" == "t" ; then
                time cat $filename.test | valgrind ./$filename.out
                code=$?
            elif  test "$2" == "t1" ; then
                time cat $filename.test | valgrind --leak-check=full ./$filename.out
                code=$?
            elif test "$2" == "t2" ; then
                time cat $filename.test | valgrind --leak-check=full -v ./$filename.out
                code=$?
            elif test "$2" == "t3" ; then
                time cat $filename.test | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$filename.out
                code=$?
            else    #No test arguments
                #echo    #newline
                echo "= = = For Copy/Paste = = = "
                echo "time cat $filename.test | valgrind ./$filename.out"                                                                 #[ t  ]"
                #echo "time cat $filename.test | valgrind --leak-check=full ./$filename.out                                               #[ t1 ]"
                #echo "time cat $filename.test | valgrind --leak-check=full -v ./$filename.out                                            #[ t2 ]"
                #echo "time cat $filename.test | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$filename.out   #[ t3 ]"
                code="Not performed"
            fi
            echo #newline
            echo "The test exited with exit code: $code"
        fi
        echo    #newline
    fi
}

############# Check Command Line Arguments ###############
#clear
echo    #newline
if test "$1" == "help"
then
    helpFun
    exit 0
elif test "$1" == "download"
then
    wget -c ./ https://github.com/shubhamchaudhary/universal/archive/master.zip # || echo "Download Failed, Check your connection and try again"
    echo "Extract master.zip files and follow further instructions available in README.md"
    exit 0
elif test "$1" == "update"
then
    #if -n command -v wget >/dev/null 2>&1    #because in bash 0 is success
    #then
    #    echo "wget not found. Use \nsudo apt-get install wget"
    #    exit 1;
    #fi
    echo "It'll be best if you perform this in an empty folder as your current directory"
    command -v wget >/dev/null 2>&1 || { echo >&2 "Hey I need wget but it's not installed.";
                                               echo "Copy/Paste ===> sudo apt-get install wget unzip"; echo "Aborting :("; echo; exit 1; }
    command -v unzip >/dev/null 2>&1 || { echo >&2 "Hey I require zip tools but they are not installed.";
                                               echo "Copy/Paste ===> sudo apt-get install unzip"; echo "Aborting :("; echo; exit 1; }
    cd /tmp;
    wget -c ./ https://github.com/shubhamchaudhary/universal/archive/master.zip || echo "Download Failed, Check your internet connection and try again";
    unzip master.zip ;      # create a folder universal-master in the /tmp folder 
    cd universal-master/
    ./install
    cd ../
    rm -rf ./universal-master master.zip
    cd - ;
elif test "$1" == "problem"
then
    echo "Thanks in advance for taking the time out"
    echo "Click on the green New Issue button on right side"
    echo "Opening the browser: "
    xdg-open "https://github.com/shubhamchaudhary/universal/issues"
    #xdg-open "https://github.com/shubhamchaudhary/universal/issues/new"
    exit 0
fi
##### Variables ####
nameLen=${#1}
compiled=true

######################## MAIN #################################

function main {
    ################# Testing different files ######################
    ##########     C      ##################
    if test "${1:nameLen-2}" == '.c' ;  then
    #if [["${1:nameLen-2}"=="*.c"]] ; then
    #    command -v gcc >/dev/null 2>&1 || { echo >&2 "Hey I require gcc but it's not installed.";
    #                                             echo "Copy/Paste ===> sudo apt-get install gcc"; echo "Aborting :("; echo; exit 1; }
        if -n command -v gcc >/dev/null 2>&1    #because in bash 0 is success
        then
            echo >&2 "Hey I require gcc but it's not installed.";
            echo "Copy/Paste ===> sudo apt-get install gcc"; 
            echo "Aborting :("; 
            echo;
            exit 1
        fi
        filename=${1:0:nameLen-2}     #striping last 2 char i.e. '.c'
        echo " = = = = = = GCC: Compiling $filename .c file = = = = = ="
        echo "gcc -g -O2 -std=gnu99 -static -Wall -Wextra -Isrc -rdynamic -fomit-frame-pointer -o $filename.out $1 -lm -lrt"    #-g to make gdb compaitable
        echo "Error(if any):"   #newline
        command gcc -g -O2 -std=gnu99 -Wall -Wextra -Isrc -rdynamic -fomit-frame-pointer -o $filename.out $1 -lm -lrt || compiled=false;
        echo "gcc exited with $?"
        memoryTest $1 $2 $3
        $compiled && echo "For Copy/Paste ===> ./$filename.out"
        #gcc -Werror -pedantic-errors -std=c99 -O2 -fomit-frame-pointer -o prog prog.c #C99 strict (gcc-4.3.2)
        #echo ".c file found"
    
    ################### C++ #######################
    
    elif test "${1:nameLen-4}" == '.cpp' ; then #first arg: crop till nameLen-4
    #elif [["${1:nameLen-4}"=="*.cpp"]] ; then
        command -v g++ >/dev/null 2>&1 || { echo >&2 "Hey I require g++ but it's not installed.";
                                                 echo "Copy/Paste ===> sudo apt-get install g++"; echo "Aborting :("; echo; exit 1; }
        filename=${1:0:nameLen-4}     #striping last 2 char i.e. '.c' i.e keep from 0 till nameLen -4
        echo " - - - - - - G++: Compiling $filename .cpp file - - - - - -"
        echo "g++ -g -O2 -std=gnu++0x -static -Wall -Wextra -Isrc -rdynamic -fomit-frame-pointer -o $filename.out $1" 
        echo "Error(if any):"   #newline
        command g++ -g -O2 -std=gnu++0x -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1 || compiled=false
        memoryTest $1 $2 $3
        $compiled && echo "For Copy/Paste ===> ./$filename.out"
        #echo ".cpp file found"
    
    ################ PYTHON #################################
    
    elif test "${1:nameLen-3}" == '.py' ; then
        command -v python >/dev/null 2>&1 || { echo >&2 "Hey I require python but it's not installed.";
                                                 echo "Copy/Paste ===> sudo apt-get install python"; echo "Aborting :("; echo; exit 1; }
        filename=${1:0:nameLen-3}
        echo " ^ ^ ^ ^ ^ ^ ^ PYTHON: Running $filename .py file ^ ^ ^ ^ ^ ^ ^"
        echo "python $1"
        echo    #newline
        command python $1 || compiled=false
    
    ############### JAVA #########################
    
    elif test "${1:nameLen-5}" == '.java'
    then
        command -v java >/dev/null 2>&1 && command -v javac >/dev/null 2>&1 || { echo >&2 "Hey I require both java and javac but it's not installed.";
                                                 echo "Copy/Paste ===> sudo apt-get install java javac"; echo "Aborting :("; echo; exit 1; }
        filename=${1:0:nameLen-5}   #stripping '.java'
        echo " + + + + + + JAVA: Compiling $filename .java file + + + + + "
        echo    #newline
        echo "Performing 'javac $1'"
        command javac $1 || compiled=false
        if [ $? -ne 0 ] ; then
            compiled=false
        else
            echo    #newline
            echo " + + + + + + \`java $filename\` OUTPUT follows: "
            command java $filename || compiled=false
        fi
    ############## Unknow file format ################
    else 
        echo    #newline
        echo "NOTICE: Unknown File format \"$1\""
        usage
        compiled=false
    fi
    ############# end of filetype if #####################
    #if [ $? -ne 0 ]    #previous command gcc g++ javac python
    if test $compiled == false
    then
        echo    #newline
        echo "Ouch, The process of compilation failed."
        echo "For Copy/Paste ===> vi $1"
        compiled=false
    fi
} #end of main function
#if test $compiled == true ; then
#else    #Show Usage & Help
    #usage
#fi
main $1 $2 $3
