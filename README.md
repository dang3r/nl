# Newslister

> A library and set of scripts for scraping and analyzing Google News search results.


# Getting Started

Install the python3 package.

```shell
git clone git@github.com:dang3r/nl.git
make install
make build
```

Run tests.

```shell
make test
```

# Usage

Newslister provides scripts for downloading Google News search results, and
aggregating them.

Downloader.py downloads search results given a configuration file.

```shell
$ nl-downloader -h
usage: nl-downloader [-h] --config CONFIG [--output-dir OUTPUT_DIR]

Download Google News search results for a set of queries

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG, -c CONFIG
                        Location of configuration file
  --output-dir OUTPUT_DIR, -o OUTPUT_DIR
                        Output directory for scraping results

Example : nl-downloader --config=config_foo.yml --output-dir=runs
```

Importer.py aggregates search results from a directory of Google News search
results.

```shell
$ nl-importer -h
usage: nl-importer [-h] --run-dir RUN_DIR [--csv CSV]

Create an aggregation spreadsheet of Google News search results

optional arguments:
  -h, --help            show this help message and exit
  --run-dir RUN_DIR, -r RUN_DIR
                        Import directory to read Google results from
  --csv CSV, -c CSV     Csv file to output the spreadsheet to
```

# Future Work

- Add other proxy providers like Google Cloud, Azure, DigitalOcean, Linode and
  free proxies (https://free-proxy-list.net/)
- Testing
- A script for merging the results of multiple spreadsheets


## Licensing

TBD.
