#!/usr/bin/env python

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

from universal.main import main


class TestMain(unittest.TestCase):
    def setUp(self):
        self.filename_c = 'foobar.c'
        self.argv_backup = sys.argv

    def tearDown(self):
        sys.argv = self.argv_backup

    @patch('universal.main.compile_files')
    def test_should_compile_files_if_available(self, mock_compile_files):
        sys.argv = ['dummy', self.filename_c]
        main()
        mock_compile_files.assert_called_once_with([self.filename_c], False)

    @patch('universal.main.ArgumentParser.print_usage')
    def test_should_show_usage_if_no_correct_argument(self, mock_argparser):
        sys.argv = ['dummy']
        main()
        mock_argparser.assert_called_once_with()

    @patch('universal.main.update')
    def test_should_update_with_short_flag(self, mock_update):
        sys.argv = ['dummy', '-u']
        main()
        mock_update.assert_called_once_with()

    @patch('universal.main.update')
    def test_should_update_with_long_flag(self, mock_update):
        sys.argv = ['dummy', '--update']
        main()
        mock_update.assert_called_once_with()

    @patch('universal.main.problem')
    def test_should_call_problem_with_short_flag(self, mock_problem):
        sys.argv = ['dummy', '-p']
        main()
        mock_problem.assert_called_once_with()

    @patch('universal.main.problem')
    def test_should_call_problem_with_long_flag(self, mock_problem):
        sys.argv = ['dummy', '--problem']
        main()
        mock_problem.assert_called_once_with()

class AnyStringContaining(str):
    def __eq__(self, other):
        return self in other

if __name__ == '__main__':
    unittest.main()
