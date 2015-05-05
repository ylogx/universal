#!/usr/bin/env python
#=====================
from __future__ import print_function

try:
    import unittest
    import unittest.mock
    from unittest.mock import patch
    from unittest.mock import call
except ImportError as e:
    import unittest2 as unittest
    import mock
    from mock import patch
    from mock import call

import os
from os import errno

from universal.util import get_file_tuple
from universal.util import perform_system_command
from universal.util import update
from universal.util import problem
from universal.util import check_exec_installed
from universal.util import is_tool

class TestUtilFunctions(unittest.TestCase):
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

    @patch('universal.util.check_exec_installed')
    @patch('universal.util.perform_system_command')
    def test_update(self, mock_sys_cmd, mock_check_exec_installed):
        update()

        mock_check_exec_installed.assert_called_once_with(['pip'])
        mock_sys_cmd.assert_called_once_with('pip install --upgrade universal')

    @patch('universal.util.perform_system_command')
    def test_problem(self, mock_sys_cmd):
        problem()

        mock_sys_cmd.assert_called_once_with("xdg-open 'https://github.com/shubhamchaudhary/universal/issues'")


@patch('universal.util.is_tool')
class TestCheckExecInstalled(unittest.TestCase):
    def setUp(self):
        self.exec_list = ['a', 'b', 'c']

    def test_check_exec_installed_returns_true_if_all_exec_installed(self, mock_is_tool):
        mock_is_tool.return_value = True

        output = check_exec_installed(self.exec_list)

        calls_for_is_tool = [call(exe) for exe in self.exec_list]
        mock_is_tool.has_calls(calls_for_is_tool)
        self.assertTrue(output)

    def test_check_exec_installed_returns_false_if_no_exec_installed(self, mock_is_tool):
        mock_is_tool.return_value = False

        output = check_exec_installed(self.exec_list)

        calls_for_is_tool = [call(exe) for exe in self.exec_list]
        mock_is_tool.has_calls(calls_for_is_tool)
        self.assertFalse(output)


@patch('subprocess.Popen')
class TestIsTool(unittest.TestCase):
    def test_is_tool_returns_true_if_installed(self, mock_popen):
        output = is_tool('a')

        args, kwargs = mock_popen.call_args
        self.assertEqual(args[0], ['a'])
        self.assertTrue(output)

    def test_is_tool_returns_false_if_exec_not_installed(self, mock_popen):
        e = OSError(errno.ENOENT, 'msg')
        mock_popen.side_effect = e

        output = is_tool('a')

        args, kwargs = mock_popen.call_args
        self.assertEqual(args[0], ['a'])
        self.assertFalse(output)

if __name__ == '__main__':
    unittest.main()
