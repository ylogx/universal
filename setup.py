from distutils.core import setup

add_keywords = dict(
    entry_points = {
        'console_scripts': ['universal = universal.universal:main'],
    },
)

setup(
        name='Universal',
        description='Universal Competitive Programming Suite helps you work'
                    ' faster in programming competitions',
        version='1.9.9',
        packages=['universal'],
        license='GPLv3+',
        author='Shubham Chaudhary',
        author_email='me@shubhamchaudhary.in',
        url='https://github.com/shubhamchaudhary/universal',
        long_description=open('README.txt').read(),
        **add_keywords
)

