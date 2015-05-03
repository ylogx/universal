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
    from mock import call

from universal.util import get_file_tuple
from universal.util import perform_system_command
from universal.util import update
from universal.util import problem

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

    @patch('universal.util.perform_system_command')
    def test_update(self, mock_sys_cmd):
        update()

        mock_sys_cmd.assert_called_once_with('pip install --upgrade universal')

    @patch('universal.util.perform_system_command')
    def test_problem(self, mock_sys_cmd):
        problem()

        mock_sys_cmd.assert_called_once_with("xdg-open 'https://github.com/shubhamchaudhary/universal/issues'")

if __name__ == '__main__':
    unittest.main()
