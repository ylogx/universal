#!/usr/bin/env python
#=====================
from __future__ import print_function

import sys

try:
    import unittest
    import unittest.mock
    from unittest.mock import patch
    from unittest.mock import call
except ImportError as e:
    import mock
    from mock import patch
    from mock import call

from universal.compiler import build_and_run_file
from universal.compiler import compile_files
from universal.config import EXECUTABLE_GCC
from universal.config import EXECUTABLE_GPP
from universal.config import EXECUTABLE_PYTHON
from universal.config import EXECUTABLE_JAVA
from universal.config import EXECUTABLE_JAVAC


@patch('universal.compiler.perform_system_command')
class test_compiler_functions_that_call_system_command(unittest.TestCase):
    def setUp(self):
        self.filename_c = 'foobar.c'
        self.filename_cpp = 'foobar.cpp'
        self.filename_py = 'foobar.py'
        self.filename_java = 'foobar.java'

    def tearDown(self):
        pass

    def test_gcc_system_command_sent_for_c_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_c)
        sys_cmd_mock.assert_called_once_with(AnyStringContaining(EXECUTABLE_GCC))
        self.assertEqual(sys_cmd_mock.call_count, 1)

    def test_gpp_system_command_sent_for_cpp_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_cpp)
        sys_cmd_mock.assert_called_once_with(AnyStringContaining(EXECUTABLE_GPP))
        self.assertEqual(sys_cmd_mock.call_count, 1)

    def test_python_system_command_sent_for_py_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_py)
        sys_cmd_mock.assert_called_once_with(AnyStringContaining(EXECUTABLE_PYTHON))
        self.assertEqual(sys_cmd_mock.call_count, 1)

    def test_both_java_system_commands_sent_for_java_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_java)
        call_order = [
            call(AnyStringContaining(EXECUTABLE_JAVAC)),
            call(AnyStringContaining(EXECUTABLE_JAVA))
        ]
        sys_cmd_mock.assert_has_calls(call_order, any_order=False)
        self.assertEqual(sys_cmd_mock.call_count, 2)


class test_compile_files_function(unittest.TestCase):
    def setUp(self):
        self.filename_c = 'foobar.c'
        self.filename_cpp = 'foobar.cpp'
        self.filename_py = 'foobar.py'
        self.filename_java = 'foobar.java'
        self.filename_list = [self.filename_c, self.filename_cpp, self.filename_py, self.filename_java]

    @patch('universal.compiler.build_and_run_file')
    @patch('os.path.isfile')
    def test_build_and_run_called_for_all_args(self, mock, mock_isfile):
        mock_isfile.return_value = True
        compile_files(self.filename_list, mem_test=False)
        self.assertEqual(mock.call_count, len(self.filename_list))


class AnyStringContaining(str):
    def __eq__(self, other):
        return self in other


unittest.main()
