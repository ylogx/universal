Universal Competitive Programming Suite
=======================================

[![Join the chat at https://gitter.im/shubhamchaudhary/universal](https://badges.gitter.im/shubhamchaudhary/universal.svg)](https://gitter.im/shubhamchaudhary/universal?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![PyPI Version](https://img.shields.io/pypi/v/Universal.svg)](https://pypi.python.org/pypi/Universal) [![PyPI Monthly Downloads](https://img.shields.io/pypi/dm/Universal.svg)](https://pypi.python.org/pypi/Universal) [![PyPI License](https://img.shields.io/pypi/l/Universal.svg)](https://pypi.python.org/pypi/Universal) [![GitHub tag](https://img.shields.io/github/tag/shubhamchaudhary/universal.svg)](https://github.com/shubhamchaudhary/universal/releases) [![GitHub release](https://img.shields.io/github/release/shubhamchaudhary/universal.svg)](https://github.com/shubhamchaudhary/universal/releases/latest)

[![Build Status Travis-CI](https://travis-ci.org/shubhamchaudhary/universal.svg)](https://travis-ci.org/shubhamchaudhary/universal) [![Coverage Status](https://coveralls.io/repos/shubhamchaudhary/universal/badge.svg?branch=master)](https://coveralls.io/r/shubhamchaudhary/universal?branch=master) [![Circle CI](https://circleci.com/gh/shubhamchaudhary/universal.svg?style=svg)](https://circleci.com/gh/shubhamchaudhary/universal) [![Build Status Snap-CI](https://snap-ci.com/shubhamchaudhary/universal/branch/master/build_image)](https://snap-ci.com/shubhamchaudhary/universal/branch/master) [![Requirements Status](https://requires.io/github/shubhamchaudhary/universal/requirements.svg?branch=master)](https://requires.io/github/shubhamchaudhary/universal/requirements/?branch=master)

[![GitHub issues](https://img.shields.io/github/issues/shubhamchaudhary/universal.svg?style=plastic)](https://github.com/shubhamchaudhary/universal/issues) [![Stories in Ready](https://badge.waffle.io/shubhamchaudhary/universal.png?label=ready&title=Ready)](https://waffle.io/shubhamchaudhary/universal)

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

  * It will compile your _batman.c_ (with a lot of awesome gcc commandline options & flags already set).  
  * After compiling it will create an executable named _batman.out_  
  * Give you instructions to copy-paste for editing or executing.
  * You may also use `u batman.out` to execute the executable just created.  
  
__Universal way:__  
`u b<tab>`  

With universal installed you just need to type __3__ keystrokes to compile and execute any type of source code.  
  
Best part you don't need to remember anything, not even the name of compiler. Forget the command name & its syntax and all those stupid, long but helpful command line options which are different for each compiler.  

You can use the __same__ command/syntax `u filename.extension` to build & run __any__ source code. Yes _any_ type of source file. Universal will either run it or tell you how to install its compiler.  Universal supports a large variety of languages including c, c++, java, python and many more.  
  
  
__Installation:__  
To install type

```
pip3 install universal
```
  
After completing installation you can type command name `universal --help` or `universal -h` or the easiest and fastest version of command `u -h` and just hit enter to get usage instruction and help.  
  
  
List of command line options:  

  * `u --help`     or `u -h` - get help  
  * `u --update`   or `u -u` - update software to the latest developement version with many bug fixes
  * `u --download` or `u -d` - download latest source code in a .zip file
  * `u --problem`  or `u -p` - Report problems, bugs, issues etc.
  * `u <filename>.c t`        - Perform a memory test while running the executable
  
To get latest version of Universal type `u -u` or do `pip install --upgrade universal` 

It is recommended that you update the software after every few weeks.  
  
Find us:
  * [PyPi](https://pypi.python.org/pypi/Universal)   
  * [Ohloh](https://www.ohloh.net/p/UniversalCompiler)  
  * [LaunchPad](https://launchpad.net/universalcompiler)  

  
[![wercker status](https://app.wercker.com/status/b72e37a06749fd7aab9512499ed15481/m "wercker status")](https://app.wercker.com/project/bykey/b72e37a06749fd7aab9512499ed15481)


