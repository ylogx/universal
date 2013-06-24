#  chaudhary.sh
#
#  Copyright (c) 2011-2013 Shubham Chaudhary <shubhamchaudhary92@gmail.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  

##this script compiles .c & .cpp files
function usage {
    echo #newline
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo "    #######################################################"
    echo "    #        - - - Universal Compiler Usage - - -     (c) #" 
    echo "    #                                                     #"
    echo "    # USAGE:  chaudhary.sh <filename> <test option>       #" 
    echo "    # For Full Help:  \`chaudhary.sh help\`                 #"
    echo "    #                                                     #"
    echo "    #######################################################"
    echo "    # Program: Universal Compiler - Programming made easy #"
    echo "    # Author : Shubham Chaudhary                          #"
    echo "    #######################################################"
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo    #newline
}
function helpFun {
    echo #newline
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo "    #######################################################"
    echo "    #        + + + Universal Compiler Help + + +      (c) #" 
    echo "    #                                                     #"
    echo "    # Aliases: 'universal' and 'chaudhary.sh' and 'c'     #"
    echo "    # That means you may also use:                        #"
    echo "    #         \`universal help\` \`c help\`                   #"
    echo "    #                                                     #"
    echo "    # USAGE:  chaudhary.sh <filename>                     #"
    echo "    #         chaudhary.sh <filename> <test option>       #" 
    echo "    # e.g      'chaudhary.sh hello.cpp'                   #"
    echo "    #          'chaudhary.sh HelloWorld.java'             #"
    echo "    # Automated Testing options: t, t1, t2, t3            #"
    echo "    # For Full Help:  'chaudhary.sh help'                 #"
    echo "    #                                                     #"
    echo "    # Compaitable with '.c' '.cpp' '.py' '.java' files    #"
    echo "    #                                                     #"
    echo "    # Update Version: See README.md to get download link  #"
    echo "    #                                                     #"
    echo "    #######################################################"
    echo "    # Program: Universal Compiler - Reducing headaches    #"
    echo "    # Author : Shubham Chaudhary                          #"
    echo "    #######################################################"
    #echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    echo    #newline
}
#clear
echo    #newline
if test "$1" == "help"
then
    helpFun
    exit 0
fi
nameLen=${#1}
compiled=true
#echo " * * * Compiling $filename * * *"

################# Testing different files ######################

##########     C      ##################

if test "${1:nameLen-2}" == '.c' ;  then
#if [["${1:nameLen-2}"=="*.c"]] ; then
    if test -n `command -v gcc >/dev/null 2>&1` ;
    then
        echo >&2 "Hey I require gcc but it's not installed.";
        echo "Copy/Paste ===> sudo apt-get install gcc"; 
        echo "Aborting :("; 
        echo;
        exit 1
    fi
    filename=${1:0:nameLen-2}     #striping last 2 char i.e. '.c'
    echo " = = = = = = GCC: Compiling $filename .c file = = = = = ="
    echo "gcc -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1"
    echo    #newline
    gcc -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1
    #gcc -Werror -pedantic-errors -std=c99 -O2 -fomit-frame-pointer -o prog prog.c #C99 strict (gcc-4.3.2)
    #echo ".c file found"

################### C++ ###############################

elif test "${1:nameLen-4}" == '.cpp' ; then #first arg: crop till nameLen-4
#elif [["${1:nameLen-4}"=="*.cpp"]] ; then
    command -v gcc432 >/dev/null 2>&1 || { echo >&2 "Hey I require g++ but it's not installed.";
                                             echo "Copy/Paste ===> sudo apt-get install g++"; echo "Aborting :("; echo; exit 1; }
    filename=${1:0:nameLen-4}     #striping last 2 char i.e. '.c' i.e keep from 0 till nameLen -4
    echo " - - - - - - G++: Compiling $filename .cpp file - - - - - -"
    echo "g++ -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1" 
    echo    #newline
    g++ -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1
    #echo ".cpp file found"

################ PYTHON #################################

elif test "${1:nameLen-3}" == '.py' ; then
    command -v gcc432 >/dev/null 2>&1 || { echo >&2 "Hey I require python but it's not installed.";
                                             echo "Copy/Paste ===> sudo apt-get install python"; echo "Aborting :("; echo; exit 1; }
    if test -n `command -v g++ >/dev/null 2>&1` ;
    then
        echo >&2 "I require g++ but it's not installed. Aborting."
        echo >&2 "Copy/Paste ===> 'sudo apt-get install g++'"
        exit 1
    fi
    filename=${1:0:nameLen-3}
    echo " ^ ^ ^ ^ ^ ^ ^ PYTHON: Running $filename .py file ^ ^ ^ ^ ^ ^ ^"
    echo "python $1"
    echo    #newline
    python $1

############### JAVA #########################

elif test "${1:nameLen-5}" == '.java'
then
#    command -v javac >/dev/null 2>&1 || { echo >&2 "Hey I require javac but it's not installed.";
#                                             echo "Copy/Paste ===> sudo apt-get install javac"; echo "Aborting :("; echo; exit 1; }
#    command -v java >/dev/null 2>&1 || { echo >&2 "Hey I require java but it's not installed.";
#                                             echo "Copy/Paste ===> sudo apt-get install java"; echo "Aborting :("; echo; exit 1; }
    command -v java >/dev/null 2>&1 && command -v javac >/dev/null 2>&1 || { echo >&2 "Hey I require both java and javac but it's not installed.";
                                             echo "Copy/Paste ===> sudo apt-get install java javac"; echo "Aborting :("; echo; exit 1; }
    filename=${1:0:nameLen-5}   #stripping '.java'
    echo " + + + + + + JAVA: Compiling $filename .java file + + + + + "
    echo    #newline
    echo "Performing 'javac $1'"
    javac $1
    if [ $? -ne 0 ] ; then
        compiled=false
    else
        echo    #newline
        echo " + + + + + + 'java $filename' OUTPUT follows: "
        java $filename
    fi

################## NO FILE NAME ##################
elif test "$1" == '' ; then #No file name->goto help
    compiled=false
############## Unknow file format ################
else 
    echo    #newline
    echo "NOTICE: Unknown File format \"$1\""
    compiled=false
fi
############# end of filetype if #####################

if [ $? -ne 0 ]    #previous command gcc g++ javac python
then
    echo    #newline
    echo "Sorry, The process of compilation failed."
    echo "For Copy/Paste ===> gedit $1"
    compiled=false
fi

############ Do automated testing by taking inputs from $filename.test file ##################

if test $compiled == true ; then
    echo    #newline
    if test -f $filename.test && test "$2" == "t" ; then
        echo " * * * Valgrind Test: $filename.test found * * *"
        time cat $filename.test | valgrind ./$filename.out
    elif test -f $filename.test && test "$2" == "t1" ; then
        echo " * * * Valgrind Test: $filename.test found * * *"
        time cat $filename.test | valgrind --leak-check=full ./$filename.out
    elif test -f $filename.test && test "$2" == "t2" ; then
        echo " * * * Valgrind Test: $filename.test found * * *"
        time cat $filename.test | valgrind --leak-check=full -v ./$filename.out
    elif test -f $filename.test && test "$2" == "t3" ; then
        echo " * * * Valgrind Test: $filename.test found * * *"
        time cat $filename.test | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$filename.out
    #else    #No test arguments
        #echo    #newline
        #echo "= = = For Copy/Paste = = = "
        #echo "time cat $filename.test | valgrind ./$filename.out                                                                 #[ t  ]"
        #echo "time cat $filename.test | valgrind --leak-check=full ./$filename.out                                               #[ t1 ]"
        #echo "time cat $filename.test | valgrind --leak-check=full -v ./$filename.out                                            #[ t2 ]"
        #echo "time cat $filename.test | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$filename.out   #[ t3 ]"
    fi
    echo    #newline
else    #Show Usage & Help
    usage
fi
