#!/usr/bin/env python
#=====================
from __future__ import print_function

import sys

try:
    import unittest
    import unittest.mock
    from unittest.mock import patch
except ImportError as e:
    import mock
    from mock import patch

sys.path.append('..')      # Needed to import code

from universal.compiler import build_and_run_file

class test_util_functions(unittest.TestCase):
    def setUp(self):
        self.filename_c = 'foobar.c'
        self.filename_cpp = 'foobar.cpp'
        self.filename_py = 'foobar.py'
        self.filename_java = 'foobar.java'

    def tearDown(self):
        pass

    @patch('universal.compiler.perform_system_command')
    def test_gcc_system_command_sent_for_c_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_c)
        sys_cmd_mock.assert_called_once_with(AnyStringWith('gcc'))

    @patch('universal.compiler.perform_system_command')
    def test_gpp_system_command_sent_for_cpp_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_cpp)
        sys_cmd_mock.assert_called_once_with(AnyStringWith('g++'))

    @patch('universal.compiler.perform_system_command')
    def test_python_system_command_sent_for_py_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_py)
        sys_cmd_mock.assert_called_once_with(AnyStringWith('python'))

    @patch('universal.compiler.perform_system_command')
    def test_both_java_system_commands_sent_for_java_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_java)
        sys_cmd_mock.assert_called_with(AnyStringWith('java'))

class AnyStringWith(str):
    def __eq__(self, other):
        return self in other


unittest.main()
