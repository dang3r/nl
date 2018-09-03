from setuptools import setup

def readme():
    with open('README.md', 'r') as f:
        return f.read()


scripts = [F'bin/nl-{script}' for script in ['downloader', 'importer', 'killer', 'tf']]
setup(name='newslister',
    version='0.0.1',
    description='Library and utilities for scraping and aggregating Google News results',
    long_description=readme(),
    classifiers=[
        'Development Status :: 3 - Alpha',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3',
        'Topic :: Scraping :: Google News',
    ],
    keywords='scraping googlenews aws proxy docker',
    url='http://github.com/dang3r/newslister',
    author='Daniel Cardoza',
    author_email='dan@danielcardoza.com',
    license='MIT',
    scripts=scripts,
    install_requires=[
        'bs4',
        'requests',
        'boto3'
    ],
    packages=['newslister', 'newslister.proxy', 'newslister.proxy.terraform'],
    package_data={'newslister': ['proxy/terraform/*.tf']},
    include_package_data=True,
    zip_safe=False)
