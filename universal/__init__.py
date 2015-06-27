"""
Universal Competitive Programming Suite

@author Shubham Chaudhary
@email me@shubhamchaudhary.in
"""
from pkg_resources import get_distribution, DistributionNotFound


__title__ = 'Universal'
__author__ = 'Shubham Chaudhary'
__license__ = 'GPLv3+'
__copyright__ = 'Copyright 2014-2015 Shubham Chaudhary'
try:
    __version__ = get_distribution('universal').version
except DistributionNotFound:
    __version__ = '0.0.0'
