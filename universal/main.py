#!/usr/bin/env python3
#
#   universal.py - A tool to quickly compile and run different
#   source files using same command
#   This file is a part of Universal Competitive Programming Suite.
#
#   Copyright (c) 2011-2015 Shubham Chaudhary <me@shubhamchaudhary.in>
#   Copyright (c) 2015 Harsimran <harsimran_hs4@yahoo.co.in>
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

from __future__ import print_function
import sys
import time
from argparse import ArgumentParser

from universal import __version__
from universal.builder import compile_files
from universal.util import update
from universal.util import problem


def print_version():
    print('Universal version %s' % __version__)
    print('Copyright (c) 2011-2015 by Shubham Chaudhary.')
    print('License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>')
    print('This is free software: you are free to change and redistribute it.')
    print('There is NO WARRANTY, to the extent permitted by law.')


def parse_known_args():
    """ Parse command line arguments
    """
    parser = ArgumentParser()
    parser.add_argument("-l", "--loop", type=int, help="Loop every X seconds")
    parser.add_argument('-V', '--version',
                        action='store_true',
                        dest='version',
                        help='Print the version number and exit')
    parser.add_argument("-u", "--update",
                        action='store_true',
                        dest="update",
                        help="Update the software from online repo")
    parser.add_argument("-p", "--problem",
                        action='store_true',
                        dest="problem",
                        help="Report a problem")
    parser.add_argument("-m", "--memory",
                        action='store_true',
                        dest="memory",
                        help="Run memory tests")
    args, otherthings = parser.parse_known_args()
    return args, otherthings, parser


def loop_and_compile(wait_duration_in_sec, otherthings, memory):
    if wait_duration_in_sec < 1:
        print(
            'Invalid Argument: Loop wait time should be greater than 1 second')
        return
    print('Looping every %d seconds.' % wait_duration_in_sec)
    print('Use Ctrl-C to stop.')
    while True:
        compile_files(otherthings, memory)
        time.sleep(wait_duration_in_sec)


def main():
    args, otherthings, parser = parse_known_args()

    if args.version:
        print_version()
        return 0

    if len(otherthings) > 0:
        if args.loop is not None:
            loop_and_compile(args.loop, otherthings, args.memory)
        else:
            compile_files(otherthings, args.memory)
    elif args.update:
        return update()
    elif args.problem:
        return problem()
    else:
        parser.print_usage()
        print('No filename passed')


if __name__ == '__main__':
    sys.exit(main())
