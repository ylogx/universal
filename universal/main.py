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

import sys
from argparse import ArgumentParser

from universal.compiler import compile_files
from universal.util import update
from universal.util import problem

def main():
    # Parse command line arguments
    parser = ArgumentParser()
    parser.add_argument("-u", "--update", action='store_true', dest="update",
                        help="Update the software from online repo")
    parser.add_argument("-p", "--problem", action='store_true', dest="problem",
                        help="Report a problem")
    parser.add_argument("-m", "--memory", action='store_true', dest="memory",
                        help="Run memory tests")
    args, otherthings = parser.parse_known_args()

    if len(otherthings) > 0:
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
