from distutils.core import setup

add_keywords = dict(
    entry_points = {
        'console_scripts': ['universal = universal.universal:main'],
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
        version='2.0.0',
        packages=['universal'],
        license='GPLv3+',
        author='Shubham Chaudhary',
        author_email='me@shubhamchaudhary.in',
        url='https://github.com/shubhamchaudhary/universal',
        long_description=long_description,
        install_requires=requires,
        **add_keywords
)

