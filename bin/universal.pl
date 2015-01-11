#!/usr/bin/perl -w
#
#   universal.pl - A tool to quickly compile and run different
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

use strict;
use warnings;

use POSIX;              # for System Calls
use Term::ANSIColor;    # for colored output
use Term::ANSIColor qw(:constants);     # for color macros like BOLD RED BRIGHT_CYAN

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
    print "    #             - - - ",YELLOW,"Universal Usage",RESET," - - -     (c)     #\n";
    print "    # USAGE:  ",GREEN,"universal <filename>",RESET,"                        #\n";
    print "    # Compaitable with '.c' '.cpp' '.py' '.java' files    #\n";
    print "    # For Full Help:  \`",CYAN,"universal --help",RESET,"\` or \`",CYAN,"u -h",RESET,"\`        #\n";
#    print "    #                                                     #\n";
#    print "    #######################################################\n";
#    print "    # Program: Universal Competitive Programming Suite    #\n";
    print "    #######################################################\n";
#    print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
#    print "\n";  #newline
}

sub helpFun {
    print "\n"; #newline
    #print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print "    #######################################################\n";
    print "    #           + + + ",BRIGHT_YELLOW,"Universal Help",RESET," + + +  (c)           #\n";
    print "    #                                                     #\n";
    print "    # Aliases: '",GREEN,"universal",RESET,"' and '",GREEN,"u",RESET,"' and '",GREEN,"c",RESET,"'                #\n";
    print "    # That means you may also use:                        #\n";
    print "    #       \`u --help\`   or   \`universal --help\`          #\n";
    print "    #                                                     #\n";
    print "    # USAGE:  universal <filename>                        #\n";
    print "    #         universal <filename> <test option>          #\n";
    print "    # e.g      'universal hello.cpp'                      #\n";
    print "    #          'universal HelloWorld.java'                #\n";
    print "    # Automated Testing options: t, t1, t2, t3            #\n";
    print "    # For this full help:  'universal -h'                 #\n";
    print "    #                                                     #\n";
    #print "    # Supports with '.c' '.cpp' '.py' '.java' '.pl' '.sh' #\n";
    print "    # File Extensions: ",BOLD BLUE,"*.c .cpp .py .java .pl .sh",RESET,"         #\n";
    print "    #                                                     #\n";
    print "    # ",BOLD RED,"Update Version",RESET,": \`",MAGENTA,"universal -u",RESET,"\` i.e. \`",MAGENTA,"u -u",RESET,"\`          #\n";
    print "    #              Or see README.md to get download link  #\n";
    print "    #                                                     #\n";
    print "    #######################################################\n";
    print "    # Program: Universal Competitive Programming Suite    #\n";
    print "    #######################################################\n";
    #print "# # # # # # # # # # # # # # # # # # # # # # # # # # # #"
    print "\n";   #newline
}

##### Variables ####
our $compiled = 0;

############ Do automated testing by taking inputs from $filename.test file for C & C++ ##################
sub memoryTest {
    our @filesplits;
    my $filename = "";#$filesplits[0];
    my $result;
    my $testname = $filename.'.test';
    my $outname = $filename.'.out';
    #print "DEBUG: Compiled == ".$compiled;
    if ( $compiled == 1) {
        #print "DEBUG: testname == ".$testname;
        if ( -e $testname ) {
            print " * * * Valgrind Test: $filename.test found * * *" ;
            if ($ARGV[1] eq 't') {
                #$result doSystemCommand("time cat $testname | valgrind ./$outname");
                $result = doSystemCommand("time valgrind ./$outname < $testname");
            } elsif  ( $ARGV[1] eq 't1' ) {
                $result = doSystemCommand("time valgrind --leak-check=full ./$outname < $testname");
            } elsif  ( $ARGV[1] eq 't2' ) {
                $result = doSystemCommand("time valgrind --leak-check=full -v ./$outname < $testname");
            } elsif  ( $ARGV[1] eq 't3' ) {
                $result = doSystemCommand("time valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$outname < $testname");
            } else {    #No test arguments
                print "= = = For Copy/Paste = = = \n";
                print "time cat $testname | valgrind ./$outname\n";                                                                 #[ t  ]";
                print "time valgrind ./$outname < $testname" ;
                #print "time cat $filename.test | valgrind --leak-check=full ./$filename.out                                               #[ t1 ]";
                #print "time cat $filename.test | valgrind --leak-check=full -v ./$filename.out                                            #[ t2 ]";
                #print "time cat $filename.test | valgrind --leak-check=full --show-reachable=yes --track-origins=yes -v ./$filename.out   #[ t3 ]";
                $result="Not performed";
            }
            print "\n"; #newline
            print "The test exited with exit code: $result\n";
        }
    } #endif compiled
}

##### Variables ##### define above memoryTest ^

######################### MAIN #################################

sub main {

    ############## Check options supplied as Command Line Arguments ###############
    if ( !@ARGV ) {     #No command line argument
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
        print "It'll be best if you perform this in an empty folder as your current directory";
        my $result = doSystemCommand("command -v wget >/dev/null 2>&1");
        if ($result) {
            print "Hey I need wget and zip tools but it's not installed.";
            print "Copy/Paste ===> ",GREEN,"sudo apt-get install wget unzip",RESET;
            print "Aborting :(";
            exit $result;
        }
        $result = doSystemCommand("command -v unzip >/dev/null 2>&1");
        if ($result) {
            print "Hey I require zip tools but they are not installed.";
            print "Copy/Paste ===> ",GREEN,"sudo apt-get install unzip",RESET;
            print "Aborting :(";
            exit $result;
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
    if ( not -e $ARGV[0] ) {
        print "Come on! Are you kidding me? \n";
        print BLUE,"\"One does not simply compile $ARGV[0]\".\n",RESET;
        print "It doesn't exist\n";
        print "Copy/Paste this to edit ==> ",GREEN,"vi $ARGV[0]\n",RESET;
        exit(-1);
    }elsif ( not -r $ARGV[0] ) {
        print "Oh man, I think I'm getting old\n";
        print "I can't read $ARGV[0]\n";
        exit(-1);
    }elsif ( -z $ARGV[0] ) {
        print "Hey, Look I'm doing your dirty work for you, but come on\n";
        print "What is the point of compiling when the size of file is zero\n";
        print "Copy/Paste this to edit ==> ",GREEN,"vi $ARGV[0]",RESET,"\n";
    }elsif ( -d $ARGV[0] ) {
        print "Hey, how do you expect me to compile $ARGV[0] directory\n";
        print "You may use a Makefile to compile entire directory\n";
        exit(-1);
        #Want to learn how?
    }elsif ( -B $ARGV[0] ) {
        print "Dear, $ARGV[0] is a binary file";
        #my $size = -s $ARGV[0]; #my $time = -M $ARGV[0]; #print " which is $size bits long and is $time days old";
        if (-x $ARGV[0] ){
            print color("yellow");
            print "\n"; print "Now since this file is an executable file, I can run it for you\n";
            print "But I care about you and your system. Executable files may contain virus/side-effects, so I need to make sure\n"; print color("reset");
            print "Are you sure you want me to execute `./$ARGV[0]`? ",color("bold red"),"<Ctrl+c to cancel>",color("reset"),": "; #XXX: dangerous to use Ctrl-c
            #TODO: Read input #loop
            #if(doSystemCommand("sleep 2", "\n\nI didn't do it !\n") == 0){
            #if(POSIX::sleep(2) == 0){
            if(doSystemCommand("sleep 2", " ") == 0){
                print CYAN, "\n\nOutput of `./$ARGV[0]` starts : \n";
                print "---------------------------------------> \n",RESET;
                my $out = doSystemCommand("./$ARGV[0]", " ");
                print CYAN,"\n---------------------------------------> \n";
                print "End of Output\n",RESET;
                return $out;
            } else {
                print MAGENTA,"\n\nI didn't do it !\n",RESET;
            }
        } else {
            print "\n"; print "and one more thing, this binary file is not executable. \n";
            print "If you want to execute it, set the exectable bit using ==> ",GREEN,"chmod +x $ARGV[0]\n",RESET;
        }
        exit (-1);
    }


    ################# Testing different files ######################
    my @filesplits = split('\.', $ARGV[0]);
    my $extension = $filesplits[-1];
    #my $dotPos = rindex($ARGV[0], '.');

    ##########     C      ##################
    if ( $extension eq 'c' ) {
        my $out = doSystemCommand("command -v gcc >/dev/null 2>&1"," ");    #because in bash 0 is success
        if ($out) {
            print "Hey I require gcc but it's not installed.\n";
            print "Copy/Paste ===> ",GREEN,"sudo apt-get install gcc\n",RESET; 
            print "Aborting :(\n";
            exit 3;
        }

        my $filename= join(".", @filesplits[0 .. $#filesplits-1]); #$ARGV[0]; #$filesplits[0];      #striping last 2 char i.e. '.c' only
        print " = = = = = = ",YELLOW,"GCC: Compiling $filename .c file",RESET," = = = = = =\n";
        print colored("gcc -g -Og -Wall -Wextra -Isrc -rdynamic -fomit-frame-pointer -Wno-unused-variable -Wno-unused-parameter -o $filename.out $ARGV[0] -lm -lrt\n","blue");    #-g to make gdb compaitable
        print "Error(if any):\n";   #newline
        my $result = doSystemCommand("gcc -g -Og -Wall -Wextra -Isrc -rdynamic -fomit-frame-pointer -Wno-unused-variable -Wno-unused-parameter -o $filename.out $ARGV[0] -lm -lrt", " ");
        #print "gcc exited with $result\n";

        if($result == 0){
            print "For Copy/Paste ===> ",GREEN,"./$filename.out\n",RESET;
        }
        #gcc -Werror -pedantic-errors -std=c99 -O2 -fomit-frame-pointer -o prog prog.c #C99 strict (gcc-4.3.2)
        $compiled = !$result;
        memoryTest(@ARGV,@filesplits);
    }

    ################### C++ #######################
    elsif ( $extension eq 'cpp' ) {
        my $out = doSystemCommand("command -v g++ >/dev/null 2>&1"," ");    #because in bash 0 is success
        if ($out) {  #because in bash 0 is success
            print "Hey I require g++ but it's not installed.\n";
            print "Copy/Paste ===> ",GREEN,"sudo apt-get install g++\n",RESET; 
            print "Aborting :(\n";
            exit 3;
        }
        my $filename= $filesplits[0];
        print " - - - - - - ",YELLOW,"G++: Compiling $filename .cpp file",RESET," - - - - - -\n";
        print GREEN,"g++ -g -Og -Wall -Wextra -std=c++11 -Isrc -rdynamic -fomit-frame-pointer -Wno-unused-variable -Wno-unused-parameter -o $filename.out $ARGV[0]\n",RESET;
        print "Error(if any):\n";
        my $result = doSystemCommand("g++ -g -Og -Wall -Wextra -std=c++11 -Isrc -rdynamic -fomit-frame-pointer -Wno-unused-variable -Wno-unused-parameter -o $filename.out $ARGV[0]\n", " ");
        #print "g++ exited with $result\n";
        if($result == 0) {
            print "For Copy/Paste ===> ./$filename.out\n";
        }
        $compiled = !$result;      #1 $result;
        memoryTest($filename,$result);
    }

    ############### JAVA #########################
    elsif ( $extension eq 'java' ) {
        my $out = doSystemCommand("command -v java >/dev/null 2>&1 && command -v javac >/dev/null 2>&1", " ");    #because in bash 0 is success
        if ( $out ) {
            print "Hey I require java and javac but it's not installed.\n";
            print "Copy/Paste ===> ",GREEN,"sudo apt-get install openjdk-7-jdk\n",RESET; 
            #print "Optional: sudo apt-get install openjdk-7-jdk openjdk-7-doc openjdk-7-source\n";
            print "Aborting :(\n";
            exit 3;
        }
        my $filename= join(".", @filesplits[0 .. $#filesplits-1]); #$ARGV[1](0,-5); #striping last char only
        #        print " * * * * * * ",YELLOW,"JAVA: Compiling $filename .java file",RESET," * * * * * \n";
        print "Performing `",GREEN,"javac $ARGV[0]",RESET,"`\n";
        my $result = doSystemCommand("javac $ARGV[0]"," ");
        if ( $result == 0 ) {
            print "\n * * * * * * `",GREEN,"java $filename",RESET,"` OUTPUT follows: \n";
            $result = doSystemCommand("java $filename"," ");
        }
        $compiled = !$result;
    }

    ################ PYTHON #################################
    elsif ( $extension eq 'py' ) {
        my $out = doSystemCommand("command -v python >/dev/null 2>&1", " ");
        if ( $out ) {   #because in bash 0 is success
            print "Hey I require Python but it's not installed.\n";
            print "Copy/Paste ===> ",GREEN,"sudo apt-get install python\n",RESET; 
            print "Aborting :(\n";
            exit 3;
        }
        my $filename = join(".", @filesplits[0 .. $#filesplits-1]); #$filesplits[0];
        print " ^ ^ ^ ^ ^ ^ ^ ",YELLOW,"PYTHON: Running $filename .py file",RESET," ^ ^ ^ ^ ^ ^ ^\n";
        print "`",GREEN,"python $ARGV[0]",RESET,"` output:\n";
        my $result = doSystemCommand("python $ARGV[0]", " ");
        #print "python exited with $result\n";
        $compiled = !$result;
    }

    ################ PERL #################################
    elsif ( $extension eq 'pl' ) {
        my $out = doSystemCommand("command -v perl >/dev/null 2>&1", " ");
        if ( $out ) {   #because in bash 0 is success
            print "Hey I require Perl but it's not installed.\n";
            print "Copy/Paste ===> ",GREEN,"sudo apt-get install perl\n",RESET; 
            print "Aborting :(\n";
            exit 3;
        }
        my $filename = join(".", @filesplits[0 .. $#filesplits-1]);     #$filesplits[0];
        print " ^ ^ ^ ^ ^ ^ ^ ",YELLOW,"PERL: Running $filename .pl file",RESET," ^ ^ ^ ^ ^ ^ ^\n";
        print "`",GREEN,"perl $ARGV[0]",RESET,"` output:\n";
        my $result = doSystemCommand("perl $ARGV[0]", " ");
        $compiled = !$result;
    }

    ################ SHELL #################################
    elsif ( $extension eq 'sh' ) {
        my $out = doSystemCommand("command -v bash >/dev/null 2>&1", " ");
        if ( $out ) {   #because in bash 0 is success
            print "Hey I require Bash shell but it's not installed.\n";
            print "Copy/Paste ===> ",GREEN,"sudo apt-get install bash\n",RESET; 
            print "Aborting :(\n";
            exit 3;
        }
        my $filename = join(".", @filesplits[0 .. $#filesplits-1]);     #$filesplits[0];
        print " ^ ^ ^ ^ ^ ^ ^ ",YELLOW,"BASH: Running $filename .sh file",RESET," ^ ^ ^ ^ ^ ^ ^\n";
        print "`",GREEN,"bash $ARGV[0]",RESET,"` output:\n";
        my $result = doSystemCommand("bash $ARGV[0]", " ");
        $compiled = !$result;
    }


   ############## Unknow file format ################
    else {
        print "NOTICE: Unknown File format \"$ARGV[0]\"\n";
        doSystemCommand("file $ARGV[0]", " ");
        usage();
        $compiled= 0; #false;
    }
    ############# End of filetype if #####################
    if ( $compiled == 0 ) {
        print "\n";   #newline
        print "Ouch, The process of compilation failed.\n";
        print "For Copy/Paste ===> ",GREEN,"vi $ARGV[0]\n",RESET;
        #my $compiled=false;
    }
} #end of main function
exit(main(@ARGV));
