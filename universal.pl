#!/usr/bin/perl -w
#  chaudhary.pl
#
#  Copyright (c) 2011-2013 Shubham Chaudhary <shubham.chaudhary@kdemail.net>
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

#use strict;
use warnings;

##this script compiles .c & .cpp files
sub usage {
    print "\n"; #newline
    #print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print "    #######################################################\n";
    print "    #        - - - Universal Compiler Usage - - -     (c) #\n"; 
    print "    #                                                     #\n";
    print "    # USAGE:  chaudhary.sh <filename> <test option>       #\n"; 
    print "    # Compaitable with '.c' '.cpp' '.py' '.java' files    #\n";
    print "    #                                                     #\n";
    print "    # For Full Help:  \`chaudhary.sh help\`                 #\n";
    print "    #                                                     #\n";
    print "    #######################################################\n";
    print "    # Program: Universal Compiler - Programming made easy #\n";
    print "    # Author : Shubham Chaudhary                          #\n";
    print "    #######################################################\n";
    #print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print "\n";  #newline
}
sub helpFun {
    print "\n"; #newline
    #print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print "    #######################################################\n";
    print "    #        + + + Universal Compiler Help + + +      (c) #\n"; 
    print "    #                                                     #\n";
    print "    # Aliases: 'universal' and 'chaudhary.sh' and 'c'     #\n";
    print "    # That means you may also use:                        #\n";
    print "    #         \`universal help\` \`c help\`                   #\n";
    print "    #                                                     #\n";
    print "    # USAGE:  chaudhary.sh <filename>                     #\n";
    print "    #         chaudhary.sh <filename> <test option>       #\n"; 
    print "    # e.g      'chaudhary.sh hello.cpp'                   #\n";
    print "    #          'chaudhary.sh HelloWorld.java'             #\n";
    print "    # Automated Testing options: t, t1, t2, t3            #\n";
    print "    # For Full Help:  'chaudhary.sh help'                 #\n";
    print "    #                                                     #\n";
    print "    # Compaitable with '.c' '.cpp' '.py' '.java' files    #\n";
    print "    #                                                     #\n";
    print "    # Update Version: \`chaudhary.sh download\`             #\n";
    print "    #              Or see README.md to get download link  #\n";
    print "    #                                                     #\n";
    print "    #######################################################\n";
    print "    # Program: Universal Compiler - Reducing headaches    #\n";
    print "    # Author : Shubham Chaudhary                          #\n";
    print "    #######################################################\n";
    #print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print "\n";   #newline
}
#print "Called print: \n";
#usage();
#print "Called helpFun: \n";
#helpFun();
############ Do automated testing by taking inputs from $filename.test file for C & C++ ##################
sub memoryTest {
    my $filename = $_[0];
    my $compiled = $_[1];
    my $code;
    my $testname = $filename.'.test';
    my $outname = $filename.'.out';
    if ( $compiled == 1) {
        print "\n";
        if ( -e $testname ) {
            print " * * * Valgrind Test: $filename.test found * * *" ;
            if ($ARGV[2] eq 't') {
                $code = `time cat $testname | valgrind ./$outname`;
            } elsif  ( $ARGV[2] eq 't1' ) {
                $code = `time cat $testname | valgrind --leak-check=full ./$outname`;
            } elsif  ( $ARGV[2] eq 't2' ) {
                $code = `time cat $testname | valgrind --leak-check=full -v ./$outname`;
            } elsif  ( $ARGV[2] eq 't3' ) {
                $code = `time cat $testname | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$outname`;
            } else {    #No test arguments
                #print    #newline
                print "= = = For Copy/Paste = = = ";
                print "time cat $testname | valgrind ./$outname";                                                                 #[ t  ]";
                #print "time cat $filename.test | valgrind --leak-check=full ./$filename.out                                               #[ t1 ]";
                #print "time cat $filename.test | valgrind --leak-check=full -v ./$filename.out                                            #[ t2 ]";
                #print "time cat $filename.test | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$filename.out   #[ t3 ]";
                $code="Not performed";
            }
            print "\n"; #newline
            print "The test exited with exit code: $code";
        }
        print "\n";    #newline
    }
}
#memoryTest('alpha',1);
# 
# ############# Check Command Line Arguments ###############
# #clear
print "\n";   #newline
if (not defined $ARGV[0] ) {
    if ( $ARGV[0] eq "help" ) {
        helpFun();
        exit 0;
    } elsif ($ARGV[0] eq "download") {
        my $return = `wget -c ./ https://github.com/shubhamchaudhary/universal/archive/master.zip`; # || print "Download Failed, Check your connection and try again"
        print "Extract master.zip files and follow further instructions available in README.md";
        exit 0;
    } elsif ($ARGV[0] eq "problem") {
        +elif test "$1" == "problem"
        +then
        print "Thanks in advance for taking the time out"
        print "Click on the green New Issue button on right side"
        print "Opening the browser: "
        my $return = `xdg-open "https://github.com/shubhamchaudhary/juk/issues"`;
        #my $return = `xdg-open "https://github.com/shubhamchaudhary/juk/issues/new"`;
        exit 0;
    }

}
##### Variables ####
#nameLen=${#1}
#compiled=true
# 
# ######################## MAIN #################################
# 
sub main {
    ################# Testing different files ######################
    $dotpos = rindex($ARGV[1], '.');
    @filesplits = split('.', $ARGV[1]);
    $extension = $filesplits[-1];
    ##########     C      ##################
    #if test "${1:nameLen-2}" == '.c' ;  then
    if ( $extension == 'c' ) {
    #if [["${1:nameLen-2}"=="*.c"]] ; then
    #    command -v gcc >/dev/null 2>&1 || { print >&2 "Hey I require gcc but it's not installed.";
    #                                             print "Copy/Paste ===> sudo apt-get install gcc"; print "Aborting :("; print; exit 1; }
        if (not $out = `command -v gcc >/dev/null 2>&1`)    #because in bash 0 is success
        {
            print "Hey I require gcc but it's not installed.\n";
            print "Copy/Paste ===> sudo apt-get install gcc\n"; 
            die("Aborting :(\n"); 
        }
        #filename=${1:0:nameLen-2}     #striping last 2 char i.e. '.c'
        $filename= $ARGV[1](0,-2);
        print " = = = = = = GCC: Compiling $filename .c file = = = = = =\n";
        print "gcc -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1\n";    #-g to make gdb compaitable
        print "Error(if any):\n";   #newline
        my $result = `gcc -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1`;
        print "gcc exited with $result";
        memoryTest($filename,$result);
        if(not $result){ 
            print "For Copy/Paste ===> ./$filename.out";
        }
        #gcc -Werror -pedantic-errors -std=c99 -O2 -fomit-frame-pointer -o prog prog.c #C99 strict (gcc-4.3.2)
        #print ".c file found"
    }
    
    ################### C++ #######################
    
    #elsif test "${1:nameLen-4}" == '.cpp' ; then #first arg: crop till nameLen-4
    #elsif [["${1:nameLen-4}"=="*.cpp"]] ; then
    elsif ( $extension == 'cpp' ) {
        #command -v g++ >/dev/null 2>&1 || { print >&2 "Hey I require g++ but it's not installed."; print; exit 1; }
        if (not $out = `command -v g++ >/dev/null 2>&1`)    #because in bash 0 is success
        {
            print "Hey I require g++ but it's not installed.\n";
            print "Copy/Paste ===> sudo apt-get install g++\n"; 
            die("Aborting :(\n"); 
        }
        #filename=${1:0:nameLen-4}     #striping last 2 char i.e. '.c' i.e keep from 0 till nameLen -4
        $filename= $ARGV[1](0,-4);
        print " - - - - - - G++: Compiling $filename .cpp file - - - - - -"
        print "g++ -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1" 
        print "Error(if any):"   #newline
        my $result = `g++ -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $1`;
        #memoryTest $1 $2 $3
        print "g++ exited with $result";
        memoryTest($filename,$result);
        if(not $result) {
            print "For Copy/Paste ===> ./$filename.out"
        }
        #print ".cpp file found"
    }
    
    ################ PYTHON #################################
    
    #elsif test "${1:nameLen-3}" == '.py' ; then
    elsif ( $extension == 'py' ) {
        #command -v  >/dev/null 2>&1 || { print >&2 "Hey I require python but it's not installed."; exit 1; }
        if (not $out = `command -v python >/dev/null 2>&1`)    #because in bash 0 is success
        {
            print "Hey I require Python but it's not installed.\n";
            print "Copy/Paste ===> sudo apt-get install Python\n"; 
            die("Aborting :(\n"); 
        }
        #filename=${1:0:nameLen-3}
        $filename= $ARGV[1](0,-3);
        print " ^ ^ ^ ^ ^ ^ ^ PYTHON: Running $filename .py file ^ ^ ^ ^ ^ ^ ^"
        print "python $1"
        print    #newline
        my $result = `python $1`;
        #memoryTest $1 $2 $3
        print "python exited with $result";
        #memoryTest($filename,$result);
        #if(not $result) {
        #    print "For Copy/Paste ===> ./$filename.out"
        #}
        #command python $1 || compiled=false
    }
    
    ############### JAVA #########################
    
    #elsif test "${1:nameLen-5}" == '.java'
    elsif ( $extension == 'java' ) {
        #command -v java >/dev/null 2>&1 && command -v javac >/dev/null 2>&1 || { print >&2 "Hey I require both java and javac but it's not installed.";
        #print "Copy/Paste ===> sudo apt-get install java javac"; print "Aborting :("; print; exit 1; }
        if (not $out = `command -v java >/dev/null 2>&1 && command -v javac >/dev/null 2>&1`)    #because in bash 0 is success
        {
            print "Hey I require java and javac but it's not installed.\n";
            print "Copy/Paste ===> sudo apt-get install java javac\n"; 
            die("Aborting :(\n"); 
        }
        #filename=${1:0:nameLen-5}   #stripping '.java'
        $filename= $ARGV[1](0,-5);
        print " + + + + + + JAVA: Compiling $filename .java file + + + + + "
        print    #newline
        print "Performing 'javac $ARGV[1]'"
        $compiled = `javac $ARGV[1]`;
        #if [ $? -ne 0 ] ; then
        #if (!( $compiled eq 0 )) {
        if ( $compiled == false ) {
            compiled=false
        } else {
            print    #newline
            print " + + + + + + \`java $filename\` OUTPUT follows: "
            $compiled = `java $filename`;
        }
    }
    ############## Unknow file format ################
    else {  # $dotpos == -1
        print    #newline
        print "NOTICE: Unknown File format \"$1\""
        usage();
        $compiled=false
    }
    ############# end of filetype if #####################
    #if [ $? -ne 0 ]    #previous command gcc g++ javac python
    if ( $compiled == false ) {
        print    #newline
        print "Ouch, The process of compilation failed."
        print "For Copy/Paste ===> vi $1"
        $compiled=false
    }
} #end of main function
# #if test $compiled == true ; then
# #else    #Show Usage & Help
#     #usage
# #fi
# main $1 $2 $3
