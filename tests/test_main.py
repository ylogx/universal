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

    @patch('universal.main.print_version')
    def test_should_print_version_and_exit_with_short_flag(self, mock_print_version):
        sys.argv = ['dummy', '-V']
        out = main()
        mock_print_version.assert_called_once_with()
        self.assertEqual(out, 0)

    @patch('universal.main.print_version')
    def test_should_print_version_and_exit_with_long_flag(self, mock_print_version):
        sys.argv = ['dummy', '--version']
        out = main()
        mock_print_version.assert_called_once_with()
        self.assertEqual(out, 0)

    @patch('universal.main.compile_files')
    def test_should_compile_files_if_available(self, mock_compile_files):
        sys.argv = ['dummy', self.filename_c]
        main()
        mock_compile_files.assert_called_once_with([self.filename_c], False)

    @patch('universal.main.loop_and_compile')
    def test_should_loop_and_compile_files_if_loop_short_flag_set(
        self, mock_loop_and_compile
    ):
        seconds = 123
        mock_loop_and_compile.return_value = 0
        sys.argv = ['dummy', self.filename_c, '-l', str(seconds)]

        main()

        mock_loop_and_compile.assert_called_once_with(seconds,
                                                      [self.filename_c], False)

    @patch('universal.main.loop_and_compile')
    def test_should_loop_and_compile_files_if_loop_long_flag_set(
        self, mock_loop_and_compile
    ):
        seconds = 123
        mock_loop_and_compile.return_value = 0
        sys.argv = ['dummy', self.filename_c, '--loop', str(seconds)]

        main()

        mock_loop_and_compile.assert_called_once_with(seconds,
                                                      [self.filename_c], False)

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


from universal.main import loop_and_compile


class TestLoopAndCompile(unittest.TestCase):
    def setUp(self):
        self.filename_c = 'foobar.c'
        self.otherthings = [self.filename_c]
        self.memory = False

    @patch('universal.main.compile_files')
    def test_should_not_run_if_time_is_zero_seconds(self, mock_compile_files):
        seconds = 0
        loop_and_compile(seconds, self.otherthings, self.memory)
        self.assertFalse(mock_compile_files.called)

    @patch('universal.main.compile_files')
    def test_should_not_run_if_time_is_negative(self, mock_compile_files):
        seconds = -12
        loop_and_compile(seconds, self.otherthings, self.memory)
        self.assertFalse(mock_compile_files.called)

    @patch('time.sleep')
    @patch('universal.main.compile_files')
    def test_should_run_in_loop_if_wait_time_valid(self, mock_compile_files,
                                                   mock_sleep):
        seconds = 2
        mock_compile_files.return_value = 0
        mock_sleep.side_effect = [0, 0, IOError('Boom!')]

        with self.assertRaises(IOError):
            loop_and_compile(seconds, self.otherthings, self.memory)

        mock_compile_files.assert_called_with(self.otherthings, self.memory)
        mock_sleep.assert_called_with(seconds)


class AnyStringContaining(str):
    def __eq__(self, other):
        return self in other


if __name__ == '__main__':
    unittest.main()
