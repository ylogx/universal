#!/usr/bin/env python

from __future__ import print_function
from universal.compiler.language.python import Python

try:
    import unittest
    import unittest.mock
    from unittest.mock import patch
    from unittest.mock import call
except ImportError as e:
    import mock
    from mock import patch
    from mock import call


class TestGpp(unittest.TestCase):
    def setUp(self):
        self.filename_py = 'foobar.py'
        self.compiler = Python(self.filename_py)

    @patch('universal.compiler.language.python.perform_system_command')
    def test_compile(self, mock_sys_cmd):
        self.compiler.compile()
        self.assertFalse(mock_sys_cmd.called)

    @patch('os.path.exists')
    @patch('universal.compiler.language.python.perform_system_command')
    def test_run_output_when_no_input_file_available(self, mock_sys_cmd,
                                                     mock_path_exists):
        mock_path_exists.return_value = False

        self.compiler.run()

        mock_sys_cmd.assert_called_once_with(AnyStringContaining('python'))

    @patch('os.path.exists')
    @patch('universal.compiler.language.python.perform_system_command')
    def test_run_output_when_input_file_available(self, mock_sys_cmd,
                                                  mock_path_exists):
        mock_path_exists.return_value = True

        self.compiler.run()

        mock_sys_cmd.assert_called_once_with(
            AnyStringContaining('foobar.input'))


class AnyStringContaining(str):
    def __eq__(self, other):
        return self in other


if __name__ == '__main__':
    unittest.main()
