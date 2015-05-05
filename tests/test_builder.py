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

from universal.builder import build_and_run_file
from universal.builder import compile_files
from universal.config import EXECUTABLE_GCC
from universal.config import EXECUTABLE_GPP
from universal.config import EXECUTABLE_PYTHON
from universal.config import EXECUTABLE_JAVA
from universal.config import EXECUTABLE_JAVAC


@patch('universal.builder.perform_system_command')
class TestCompilerFunctionsThatCallSystemCommand(unittest.TestCase):
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

    def test_gpp_system_command_sent_for_cpp_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_cpp)

        sys_cmd_mock.assert_called_once_with(AnyStringContaining(EXECUTABLE_GPP))

    def test_python_system_command_sent_for_py_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_py)

        sys_cmd_mock.assert_called_once_with(AnyStringContaining(EXECUTABLE_PYTHON))

    def test_both_java_system_commands_sent_for_java_file(self, sys_cmd_mock):
        build_and_run_file(self.filename_java)

        call_order = [
            call(AnyStringContaining(EXECUTABLE_JAVAC)),
            call(AnyStringContaining(EXECUTABLE_JAVA))
        ]
        sys_cmd_mock.assert_has_calls(call_order, any_order=False)
        self.assertEqual(sys_cmd_mock.call_count, 2)


class TestCompileFilesFunction(unittest.TestCase):
    def setUp(self):
        self.filename_c = 'foobar.c'
        self.filename_cpp = 'foobar.cpp'
        self.filename_py = 'foobar.py'
        self.filename_java = 'foobar.java'
        self.filename_list = [self.filename_c, self.filename_cpp, self.filename_py, self.filename_java]

    @patch('universal.builder.build_and_run_file')
    @patch('os.path.isfile')
    def test_build_and_run_called_for_all_args(self, mock_isfile, mock_build_run):
        mock_isfile.return_value = True

        compile_files(self.filename_list, mem_test=False)

        self.assertEqual(mock_build_run.call_count, len(self.filename_list))
        mock_build_run.assert_has_calls([call(file) for file in self.filename_list])

    @patch('universal.builder.build_and_run_file')
    @patch('os.path.isfile')
    def test_build_and_run_shows_error_when_no_file(self, mock_isfile, mock_build_run):
        mock_isfile.return_value = False

        compile_files(self.filename_list, mem_test=False)

        self.assertFalse(mock_build_run.called)
        self.assertEqual(mock_build_run.call_count, 0)


class AnyStringContaining(str):
    def __eq__(self, other):
        return self in other

if __name__ == '__main__':
    unittest.main()
