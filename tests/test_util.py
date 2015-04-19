#!/usr/bin/env python
#=====================
from __future__ import print_function

try:
    import unittest
    import unittest.mock
    from unittest.mock import patch
    from unittest.mock import call
except ImportError as e:
    import mock
    from mock import patch

import sys
sys.path.append('..')      # Needed to import code

from universal.util import get_file_tuple
from universal.util import perform_system_command

class test_util_functions(unittest.TestCase):
    def setUp(self):
        self.filename_c = 'foobar.c'
        self.filename_cpp = 'foobar.cpp'
        self.filename_py = 'foobar.py'
        self.filename_java = 'foobar.java'

    @patch('os.system')
    def test_perform_system_call(self, mock):
        cmd = 'universal'
        perform_system_command(cmd)
        mock.assert_called_once_with(cmd)

    def test_get_file_tuple_splits_properly(self):
        dummy_directory = "dummy_directory"
        (directory, name, extension) = get_file_tuple(dummy_directory + '/' + self.filename_cpp)
        self.assertIn(dummy_directory, directory)
        self.assertEqual(name, 'foobar')
        self.assertEqual(extension, 'cpp')

unittest.main()
