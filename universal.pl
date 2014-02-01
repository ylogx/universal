#!/usr/bin/perl -w
#  universal.pl
#
#  Copyright (c) 2011-2014 Shubham Chaudhary <shubham.chaudhary@kdemail.net>
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

use strict;
use warnings;

sub doSystemCommand {
    my $systemCommand = $_[0];
    my $message = $_[1];

    #print LOG "$0: Executing [$systemCommand] \n";
    my $returnCode = system( $systemCommand );

    if ( $returnCode != 0 ) {
        #print "Error Code: $returnCode\n";
        print defined $message ? $message : "Error Code: $returnCode\nFailed executing [ $systemCommand ]\n";
    }
    return $returnCode;
}

sub usage {
    print "\n"; #newline
    #print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print "    #######################################################\n";
    print "    #        - - - Universal Compiler Usage - - -     (c) #\n";
    print "    # USAGE:  universal <filename>                        #\n";
    print "    # Compaitable with '.c' '.cpp' '.py' '.java' files    #\n";
    print "    # For Full Help:  \`universal --help\` or \`u -h\`        #\n";
#    print "    #                                                     #\n";
#    print "    #######################################################\n";
#    print "    # Program: Universal Compiler - Programming made easy #\n";
#    print "    # Author : Shubham Chaudhary                          #\n";
    print "    #######################################################\n";
#    print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
#    print "\n";  #newline
}

sub helpFun {
    print "\n"; #newline
    #print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print "    #######################################################\n";
    print "    #        + + + Universal Compiler Help + + +      (c) #\n";
    print "    #                                                     #\n";
    print "    # Aliases: 'universal' and 'u' and 'c'                #\n";
    print "    # That means you may also use:                        #\n";
    print "    #          \`u --help\` \`universal --help\`              #\n";
    print "    #                                                     #\n";
    print "    # USAGE:  universal <filename>                        #\n";
    print "    #         universal <filename> <test option>          #\n";
    print "    # e.g      'universal hello.cpp'                      #\n";
    print "    #          'universal HelloWorld.java'                #\n";
    print "    # Automated Testing options: t, t1, t2, t3            #\n";
    print "    # For this full help:  'universal -h'                 #\n";
    print "    #                                                     #\n";
    print "    # Compaitable with '.c' '.cpp' '.py' '.java' files    #\n";
    print "    #                                                     #\n";
    print "    # Update Version: \`universal -u\`                      #\n";
    print "    #              Or see README.md to get download link  #\n";
    print "    #                                                     #\n";
    print "    #######################################################\n";
    print "    # Program: Universal Compiler - Reducing headaches    #\n";
    print "    # Author : Shubham Chaudhary                          #\n";
    print "    #######################################################\n";
    #print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print "\n";   #newline
}

##### Variables ####
our $compiled = 0;

############ Do automated testing by taking inputs from $filename.test file for C & C++ ##################
sub memoryTest {
    my $filename = $_[0];
    my $code;
    my $testname = $filename.'.test';
    my $outname = $filename.'.out';
    #$compiled = $_[1];     #WTF
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
                print "= = = For Copy/Paste = = = \n";
                print "time cat $testname | valgrind ./$outname\n";                                                                 #[ t  ]";
                #print "time cat $filename.test | valgrind --leak-check=full ./$filename.out                                               #[ t1 ]";
                #print "time cat $filename.test | valgrind --leak-check=full -v ./$filename.out                                            #[ t2 ]";
                #print "time cat $filename.test | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$filename.out   #[ t3 ]";
                $code="Not performed";
            }
            print "\n"; #newline
            print "The test exited with exit code: $code\n";
        }
        print "\n";    #newline
    }
}

##### Variables ##### define above memoryTest ^

# ######################## MAIN #################################

sub main {

    # ############# Check options supplied as Command Line Arguments ###############
    if ( !defined @ARGV ) {     #No command line argument
        usage();
        exit (-1);
    }
    #doSystemCommand("clear", " ");
    if ( $ARGV[0] eq "--help" || $ARGV[0] eq "-h" || $ARGV[0] eq "help" ) {
        print "\n";   #newline
        helpFun();
        exit (0);
    } elsif ($ARGV[0] eq "--download" || $ARGV[0] eq "download" || $ARGV[0] eq "-d" ) {
        my $command = "wget -c --report-speed=bits https://github.com/shubhamchaudhary/universal/archive/master.zip";
        my $errorMessage = "Download Failed, Check your connection and try again\n";
        my $theReturn = doSystemCommand($command,$errorMessage);
        $theReturn or print "Extract master.zip files and follow further instructions available in README.md\n";
        exit($theReturn);
    } elsif ($ARGV[0] eq "--update" || $ARGV[0] eq "-u" || $ARGV[0] eq "update" ){
        #if -n command -v wget >/dev/null 2>&1    #because in bash 0 is success
        #then
        #    echo "wget not found. Use \nsudo apt-get install wget"
        #    exit 1;
        #fi
        print "It'll be best if you perform this in an empty folder as your current directory";
        my $result = doSystemCommand("command -v wget >/dev/null 2>&1");
        if ($result) {
            print "Hey I need wget and zip tools but it's not installed.";
            print "Copy/Paste ===> sudo apt-get install wget unzip";
            print "Aborting :(";
            exit $result;
        }
        $result = doSystemCommand("command -v unzip >/dev/null 2>&1");
        if ($result) {
            print "Hey I require zip tools but they are not installed.";
            print "Copy/Paste ===> sudo apt-get install unzip"; 
            print "Aborting :(";
            exit 1;
        }
        #cd /tmp;
        chdir "/tmp";

        print "It'll be best if you perform this in an empty folder as your current directory\n";
        #my $data = get("https://github.com/shubhamchaudhary/universal/archive/master.zip");
        #print "Retrived ".length($data)." bytes\n";

        #use Cwd;
        #my $return_dir = getcwd();
        chdir "/tmp";
        print "Downloading in temoprary directory . . .\n";
        #wget -c ./ https://github.com/shubhamchaudhary/universal/archive/master.zip || echo "Download Failed, Check your internet connection and try again";
        my $return = doSystemCommand("wget -c https://github.com/shubhamchaudhary/universal/archive/master.zip", "Download Failed, Check your internet connection and try again");
        #$return or print "Download file from: https://github.com/shubhamchaudhary/universal/archive/master.zip\nExtract master.zip files and run ./install\nFor detailed instructions see README.md\n";
        #$result or exit($result);

        print "Unzipping\n";
        #unzip master.zip ;      # create a folder universal-master in the /tmp folder 
        $return = doSystemCommand("unzip master.zip", "Unzipping failed\n") ;      # create a folder universal-master in the /tmp folder 
        if($return && -e "/tmp/universal-master" ) {
            print "Manually run: \n";
            print "cd /tmp/universal-master; && ./install;\n";
            exit($result);
        }

        #cd universal-master/
        chdir("universal-master/");

        #./install
        print "Installing\n";
        $return = doSystemCommand("./install");

        #cd ../
        #rm -rf ./universal-master master.zip
        print "Deleting\n";
        chdir "/tmp";
        $return = doSystemCommand("rm -ivrf ./universal-master master.zip");

        #cd -;
        #chdir($return_dir);
        exit($return);
    } elsif ($ARGV[0] eq "--problem" || $ARGV[0] eq "problem" || $ARGV[0] eq "-p" ) {
        print "Thanks in advance for taking the time out\n";
        print "Click on the green New Issue button on right side\n";
        print "Opening the browser: \n";
        my $return = doSystemCommand("xdg-open \"https://github.com/shubhamchaudhary/universal/issues\"", " ");
        #my $return = `xdg-open "https://github.com/shubhamchaudhary/universal/issues/new"`;
        exit($return);
    }

    ### So it's not a command line option, now check file and filetypes.
    if ( not -r $ARGV[0] ) {
        print "Oh man, I think I'm getting old\n";
        print "I can't read $ARGV[0]\n";

    }elsif ( not -e $ARGV[0] ) {
        print "Come on! Are you kidding me? \n";
        print "\"One does not simply compile $ARGV[0]\".\n";
        print "It doesn't exist\n";
        print "Copy/Paste this to edit ==> vi $ARGV[0]\n";
        exit(-1);
    }elsif ( -z $ARGV[0] ) {
        print "Hey, Look I'm doing your dirty work for you, but come on\n";
        print "What is the point of compiling when the size of file is zero\n";
        print "Copy/Paste this to edit ==> vi $ARGV[0]\n";
    }elsif ( -d $ARGV[0] ) {
        print "Hey, how do you expect me to compile $ARGV[0] directory\n";
        print "You may use a Makefile to compile entire directory\n";
        #Want to learn how?
    }elsif ( -B $ARGV[0] ) {
        print "Dear, $ARGV[0] is a binary file";
        #my $size = -s $ARGV[0]; #my $time = -M $ARGV[0]; #print " which is $size bits long and is $time days old";
        if (-x $ARGV[0] ){
            print "\n"; print "Now since this file is an executable file, I can run it for you\n";
            print "But I care about you and your system. Executable files may contain virus/side-effects, so I need to make sure\n";
            print "Are you sure you want me to execute `./$ARGV[0]`? <Ctrl+c to cancel>: "; #XXX: dangerous to use Ctrl-c
            #TODO: Read input
            #loop
            if(doSystemCommand("sleep 2", "\n\nI didn't do it !\n") == 0){
                print "\n\nOutput of `./$ARGV[0]` starts : \n";
                print "---------------------------------------> \n";
                my $out = doSystemCommand("./$ARGV[0]", " ");
                print "\n---------------------------------------> \n";
                print "End of Output\n";
                return $out;
            }
        } else {
            print "\n"; print "and one more thing, this binary file is not executable. \n";
            print "If you want to execute it, set the exectable bit using ==> chmod +x $ARGV[0]\n";
        }
        exit (-1);
    }


    ################# Testing different files ######################
    my @filesplits = split('\.', $ARGV[0]);
    my $extension = $filesplits[-1];
    #my $dotPos = rindex($ARGV[0], '.');

    ##########     C      ##################
    #if test "${1:nameLen-2}" == '.c' ;  then
    if ( $extension eq 'c' ) {
        my $out = doSystemCommand("command -v gcc >/dev/null 2>&1"," ");    #because in bash 0 is success
        if ($out) {
            print "Hey I require gcc but it's not installed.\n";
            print "Copy/Paste ===> sudo apt-get install gcc\n"; 
            print "Aborting :(\n";
            exit 3;
        }
        #$ARGV[0](0,-2); 
        my $filename= $filesplits[0];      #striping last 2 char i.e. '.c'
        print " = = = = = = GCC: Compiling $filename .c file = = = = = =\n";
        print "gcc -g -O2 -std=gnu99 -static -Wall -Wextra -Isrc -rdynamic -fomit-frame-pointer -o -o $filename.out $ARGV[0] -lm -lrt\n";    #-g to make gdb compaitable
        print "Error(if any):\n";   #newline
        my $result = doSystemCommand("gcc -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $ARGV[0] -lm -lrt", " ");
        print "gcc exited with $result\n";

        memoryTest($filename,$result);  #XXX
        if($result == 0){
            print "For Copy/Paste ===> ./$filename.out\n";
        }
        #gcc -Werror -pedantic-errors -std=c99 -O2 -fomit-frame-pointer -o prog prog.c #C99 strict (gcc-4.3.2)
        #print ".c file found";
        $compiled = !$result;      #1 $result;
    }

    ################### C++ #######################

    elsif ( $extension eq 'cpp' ) {
        my $out = doSystemCommand("command -v gcc >/dev/null 2>&1"," ");    #because in bash 0 is success
        if ($out) {  #because in bash 0 is success
            print "Hey I require g++ but it's not installed.\n";
            print "Copy/Paste ===> sudo apt-get install g++\n"; 
            print "Aborting :(\n";
            exit 3;
        }
        #$filename= $ARGV[1](0,-4);
        my $filename= $filesplits[0];
        print " - - - - - - G++: Compiling $filename .cpp file - - - - - -\n";
        print "g++ -g -O2 -std=gnu++0x -static -Wall -Wextra -Isrc -rdynamic -fomit-frame-pointer -o $filename.out $ARGV[0]\n";
        print "Error(if any):\n";
        my $result = doSystemCommand("g++ -g -O2 -Wall -Wextra -Isrc -rdynamic -O2 -fomit-frame-pointer -o $filename.out $ARGV[0]\n", " ");
        print "g++ exited with $result\n";
        memoryTest($filename,$result);
        if($result == 0) {
            print "For Copy/Paste ===> ./$filename.out\n";
        }
        $compiled = !$result;      #1 $result;
    }

    ################ PYTHON #################################

    #elsif test "${1:nameLen-3}" == '.py' ; then
    elsif ( $extension eq 'py' ) {
        my $out = doSystemCommand("command -v python >/dev/null 2>&1", " ");
        if ( $out ) {   #because in bash 0 is success
            print "Hey I require Python but it's not installed.\n";
            print "Copy/Paste ===> sudo apt-get install Python\n"; 
            print "Aborting :(\n";
            exit 3;
        }
        my $filename = $filesplits[0]; #$filename = $ARGV[1](0,-3);
        print " ^ ^ ^ ^ ^ ^ ^ PYTHON: Running $filename .py file ^ ^ ^ ^ ^ ^ ^\n";
        print "`python $ARGV[0]` output:\n";
        my $result = doSystemCommand("python $ARGV[0]", " ");
        #print "python exited with $result\n";
        #memoryTest($filename,$result);
        #doSystemCommand("command python $ARGV[0]", " ") || $compiled=0;
        $compiled = !$result;# ? 0 : 1;
    }

    ############### JAVA #########################

    elsif ( $extension eq 'java' ) {
        my $out = doSystemCommand("command -v java >/dev/null 2>&1 && command -v javac >/dev/null 2>&1", " ");    #because in bash 0 is success
        if ( $out ) {
            print "Hey I require java and javac but it's not installed.\n";
            print "Copy/Paste ===> sudo apt-get install openjdk-7-jdk\n"; 
            #print "Optional: sudo apt-get install openjdk-7-jdk openjdk-7-doc openjdk-7-source\n";
            print "Aborting :(\n";
            exit 3;
        }
        my $filename= $filesplits[0];  #$ARGV[1](0,-5);
        print " + + + + + + JAVA: Compiling $filename .java file + + + + + \n";
        print "Performing `javac $ARGV[0]`\n";
        my $result = doSystemCommand("javac $ARGV[0]"," ");
        if ( $result == 0 ) {
            print "\n + + + + + + `java $filename` OUTPUT follows: \n";
            $result = doSystemCommand("java $filename"," ");
        }
        $compiled = !$result;
    }
   ############## Unknow file format ################
    else {
        print "NOTICE: Unknown File format \"$ARGV[0]\"\n";
        doSystemCommand("file $ARGV[0]", " ");
        usage();
        $compiled= 0; #false;
    }
    ############# end of filetype if #####################
    #if [ $? -ne 0 ]    #previous command gcc g++ javac python
    if ( $compiled == 0 ) {
        print "\n";   #newline
        print "Ouch, The process of compilation failed.\n";
        print "For Copy/Paste ===> vi $ARGV[0]\n";
        #my $compiled=false;
    }
} #end of main function
exit(main(@ARGV));
