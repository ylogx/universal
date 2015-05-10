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
        self.compiler = Compiler(self.filename_c)

    @patch('universal.compiler.compiler.Gcc.compile')
    def test_c_compiler_selected_for_c_file(self, mock_gcc_compile):
        self.compiler.compile()

        mock_gcc_compile.assert_called_once_with()

    @patch('universal.compiler.compiler.Gcc.run')
    def test_c_compiler_used_to_run_executable_for_c_file(self, mock_gcc_run):
        self.compiler.run()

        mock_gcc_run.assert_called_once_with()

if __name__ == '__main__':
    unittest.main()
