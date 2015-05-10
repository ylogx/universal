from distutils.core import setup
from setuptools import find_packages

add_keywords = dict(
    entry_points = {
        'console_scripts': ['universal = universal.main:main'],
    },
)

fhan = open('requirements.txt', 'rU')
requires = [line.strip() for line in fhan.readlines()]
fhan.close()
fhan = open('README.txt')
long_description = fhan.read()
fhan.close()

setup(
        name='Universal',
        description='Universal Competitive Programming Suite helps you work'
                    ' faster in programming competitions',
        version='2.0.1',
        packages=find_packages(exclude=["*.tests", "*.tests.*", "tests.*", "tests"]),
        license='GPLv3+',
        author='Shubham Chaudhary',
        author_email='me@shubhamchaudhary.in',
        url='https://github.com/shubhamchaudhary/universal',
        long_description=long_description,
        install_requires=requires,
        **add_keywords
)

