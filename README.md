Universal Competitive Programming Suite
===========================================================================
A tool to quickly compile and run different source files using same command  
  
Universal allows you to __quickly__ compile, build and run files. Universal make it very easy to compile _any_ source code and create & execute corresponding files.  
  
Let us say you want to compile _batman.c_.  
  
__Normal(SLOW) way:__  
`gcc -g -O2 -std=gnu99 -static -Wall -Wextra -Isrc -rdynamic -fomit-frame-pointer -o batman.out batman.c -lm -lrt`  
That is around 114 keystrokes with these options that I use for ICPC practice. Now you need to type `./batman.out` to execute. 
  
How __Universal__ helps you in programming?  
You just need to type `u batman.c`  
Typing effort is reduces even more if you use tab for filename prediction i.e type `u` followed by space and then first word of file `b` and hit tab. Voila, hit enter.  
  
After pressing enter universal will do following things for you:  
  * It will compile your _batman.c_  (with a lot of awesome gcc commandline options & flags already set).  
  * After compiling it will create an executable named _batman.out_  
  * Give you instructions to copy-paste for editing or executing.
  * You may also use `u batman.out` to execute the executable just created.  
  
__Universal way:__  
`u b<tab>`  
With universal installed you just need to type __3__ keystrokes to compile and execute any type of source code.  
  
Best part you don't need to remember anything, not even the name of compiler. Forget the command name & its syntax and all those stupid, long but helpful command line options which are different for each compiler.  
You can use the __same__ command/syntax `u filename.extension` to build & run __any__ source code. Yes _any_ type of source file. Universal will either run it or tell you how to install its compiler.  Universal supports a large variety of languages including c, c++, java, python and many more.  
  
  
To install download the files by [clicking here](https://github.com/shubhamchaudhary/universal/archive/master.zip) and unzip & run the _install_ file:  
`./install`  
You need to run it in the source directory, the one where you unzipped. Please provide password when required. You can always type `./install --help` to get installation help directly    
  
  
After completing installation you can type command name `universal --help` or `universal -h` or the easiest and fastest version of command `u -h` and just hit enter to get usage instruction and help.  
  
  
List of command line options:  
  * `u --help`     or `u -h` - get help  
  * `u --update`   or `u -u` - update software to the latest developement version with many bug fixes
  * `u --download` or `u -d` - download latest source code in a .zip file
  * `u --problem`  or `u -p` - Report problems, bugs, issues etc.
  * `u <filename>.c t`        - Perform a memory test while running the executable
  
To get latest version of Universal type `u -u` or [Click here](https://github.com/shubhamchaudhary/universal/releases/latest)   
It is recommended that you update the software after every few weeks.  
  
Find us:
  * [LaunchPad - UniversalCompiler](https://launchpad.net/universalcompiler)  
  * [Ohloh](https://www.ohloh.net/p/UniversalCompiler)
  
  
Copyright (c) 2011-2014 Shubham Chaudhary <me@shubhamchaudhary.in>  



[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/shubhamchaudhary/universal/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

