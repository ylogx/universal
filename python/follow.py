#!/usr/bin/env python3
#
#   follow.py - watch for change and run when written to
#   This file is a part of Universal Competitive Programming Suite.
#
#   Copyright (c) 2014-2015 Shubham Chaudhary <me@shubhamchaudhary.in>
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


import argparse
import fnmatch
import os
import os.path
import pyinotify
import re
import subprocess
import sys

class PatternAction(argparse.Action):
    def __call__(self, parser, namespace, values, option_string=None):
        setattr(namespace, self.dest, fnmatch.translate(values))

class Options:
    __slots__=["directory", "regex", "script"]

class Reload (Exception):
    pass

class Process(pyinotify.ProcessEvent):
    def __init__(self,  options):
        self.regex = re.compile(options.regex)
        self.script = options.script

    def process_IN_CREATE(self, event):
        target = os.path.join(event.path, event.name)
        if os.path.isdir(target):
            raise Reload()

    def process_IN_DELETE(self, event):
        raise Reload()

    def process_IN_CLOSE_WRITE(self, event):
        target = os.path.join(event.path, event.name)
        if self.regex.match(target):
            args = self.script.replace('$f', target).split()
            #os.system("clear")
            sys.stdout.write("executing script: " + " ".join(args) + "\n")
            subprocess.call(args)
            sys.stdout.write("------------------------\n")

def main():
    parser = argparse.ArgumentParser(description='Launch a script if specified files change.')
    parser.add_argument('directory', help='the directory which is recursively monitored')

    group = parser.add_mutually_exclusive_group()
    group.add_argument('-r', '--regex', required=False, default=".*", help='files only trigger the reaction if their name matches this regular expression')
    group.add_argument('-p', '--pattern', required=False, dest="regex", action=PatternAction, help='files only trigger the reaction if their name matches this shell pattern')

    parser.add_argument("script", help="the script that is executed upon reaction")

    options = Options()
    args = parser.parse_args(namespace=options)

    while True:
        wm = pyinotify.WatchManager()
        process = Process(options)
        notifier = pyinotify.Notifier(wm, process)
        mask = pyinotify.IN_DELETE | pyinotify.IN_CREATE | pyinotify.IN_CLOSE_WRITE
        wdd = wm.add_watch(options.directory, mask, rec=True)
        try:
            while True:
                notifier.process_events()
                if notifier.check_events():
                    notifier.read_events()
        except Reload:
            pass
        except KeyboardInterrupt:
            notifier.stop()
            break
    return 0

if __name__ == '__main__':
    sys.exit(main())
