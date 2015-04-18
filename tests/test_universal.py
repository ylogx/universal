#!/usr/bin/env python
#=====================
from __future__ import print_function

import unittest

import sys

sys.path.append('..')      # Needed to import code

from universal.universal import get_file_tuple

class test_util_functions(unittest.TestCase):
    def setUp(self):
        self.filename_c = 'foobar.c'
        self.filename_cpp = 'foobar.cpp'
        self.filename_py = 'foobar.py'
        self.filename_java = 'foobar.java'

    def tearDown(self):
        pass

    def test_get_file_tuple_splits_properly(self):
        dummy_directory = "dummy_directory"
        (directory, name, extension) = get_file_tuple(dummy_directory + '/' + self.filename_cpp)
        self.assertIn(dummy_directory, directory)
        self.assertEqual(name, 'foobar')
        self.assertEqual(extension, 'cpp')

unittest.main()
