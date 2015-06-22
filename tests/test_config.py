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

from universal.config import get_gcc_flags, FLAG_GCC, DEFAULT_GCC_FLAGS
from universal.config import get_gpp_flags, FLAG_GPP, DEFAULT_GPP_FLAGS
from universal.config import get_flag_value


class TestGetters(unittest.TestCase):
    @patch('universal.config.get_flag_value')
    def test_should_get_gcc_flags(self, mock_get_gcc):
        get_gcc_flags()
        mock_get_gcc.assert_called_once_with(FLAG_GCC, DEFAULT_GCC_FLAGS)

    @patch('universal.config.get_flag_value')
    def test_should_get_gpp_flags(self, mock_get_flag):
        get_gpp_flags()
        mock_get_flag.assert_called_once_with(FLAG_GPP, DEFAULT_GPP_FLAGS)

    def test_should_return_fallback_value_if_not_in_config(self):
        hopefully_unknown_key = 'cow-goes-moo-what-does-the-fox-say'
        fallback = 'ting-ding-ding-ding-ding-duding'
        output = get_flag_value(hopefully_unknown_key, fallback)
        self.assertEqual(output, fallback)


if __name__ == '__main__':
    unittest.main()
