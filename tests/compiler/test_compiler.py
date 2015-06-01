#!/usr/bin/env python

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

from universal.compiler.compiler import Compiler


class TestCompiler(unittest.TestCase):
    def setUp(self):
        self.filename_c = 'foobar.c'
        self.filename_cpp = 'foobar.cpp'
        self.filename_py = 'foobar.py'

    @patch('universal.compiler.compiler.Gcc.compile')
    def test_c_compiler_selected_for_c_file(self, mock_gcc_compile):
        self.compiler = Compiler(self.filename_c)

        self.compiler.compile()

        mock_gcc_compile.assert_called_once_with()

    @patch('universal.compiler.compiler.Gcc.run')
    def test_c_compiler_used_to_run_executable_for_c_file(self, mock_gcc_run):
        self.compiler = Compiler(self.filename_c)

        self.compiler.run()

        mock_gcc_run.assert_called_once_with()

    @patch('universal.compiler.compiler.Gpp.compile')
    def test_cpp_compiler_selected_for_cpp_file(self, mock_gpp_compile):
        self.compiler = Compiler(self.filename_cpp)
        self.compiler.compile()

        mock_gpp_compile.assert_called_once_with()

    @patch('universal.compiler.compiler.Gpp.run')
    def test_cpp_compiler_used_to_run_executable_for_cpp_file(self,
                                                              mock_gpp_run):
        self.compiler = Compiler(self.filename_cpp)
        self.compiler.run()

        mock_gpp_run.assert_called_once_with()

    @patch('universal.compiler.compiler.Python.compile')
    def test_python_compiler_selected_for_py_file(self, mock_py_compile):
        self.compiler = Compiler(self.filename_py)
        self.compiler.compile()

        mock_py_compile.assert_called_once_with()

    @patch('universal.compiler.compiler.Python.run')
    def test_python_compiler_used_to_run_executable_for_py_file(self,
                                                                mock_py_run):
        self.compiler = Compiler(self.filename_py)
        self.compiler.run()

        mock_py_run.assert_called_once_with()


if __name__ == '__main__':
    unittest.main()
