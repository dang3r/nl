import os
from pathlib import Path
from urllib.parse import urldefrag

from bs4 import BeautifulSoup

from .output import query_dir_decode


class GoogleSearchResult:
    def __init__(self, url, title, search_terms, page):
        self.url = url
        self.title = title
        self.search_terms = search_terms
        self.page = page

    def __repr__(self):
        return F'{self.title}, {self.url}'

    def defrag_url(self):
        return urldefrag(self.url)[0]

class Row:
    def __init__(self, result):
        self.url = result.url
        self.title = result.title
        self.search_terms = set([self._keywords(result.search_terms)])
        self.alternate_urls = set()

    def add_alternate_result(self, result):
        if result.url != self.url:
            self.alternate_urls.add(result.url)
        self.search_terms.add(self._keywords(result.search_terms))

    def fields(self):
        return [
            self.title,
            self.url,
            ';'.join(self.search_terms),
            len(self.search_terms),
            len(self.alternate_urls),
            ';'.join(self.alternate_urls)
        ]

    def _keywords(self, terms):
        return ' '.join(sorted(terms))


class RowCollection:
    HEADERS = ['Title', 'Url', 'Keywords', 'Number of Searches',
            'Number of Alternate Urls',
            'Alternate Urls']

    def __init__(self):
        self.url_to_row = {}

    def add_result(self, result):
        url_key = result.defrag_url()
        if url_key in self.url_to_row:
            self.url_to_row[url_key].add_alternate_result(result)
        else:
            self.url_to_row[url_key] = Row(result)

    def __len__(self):
        return len(self.url_to_row)

    def __getitem__(self, position):
        return list(self.url_to_row.values())[position]


def results_from_file(filename):
    '''Retrieve results from a file for a webpage'''
    with open(filename, 'r') as page:
        text = page.read()
    print(filename)
    results = results_from_text(text)
    return results


def results_from_text(text):
    '''Extract google news article urls and titles from html'''
    results = []
    soup = BeautifulSoup(text, 'html.parser')
    for div in soup.find_all('div', class_='g'):
        anchors = div.select('h3 > a')
        if anchors:
            anchor = anchors[0]
            url = anchor['href']
            title = anchor.text
            results.append((url, title))
    for div in soup.find_all('div', class_='card-section'):
        anchors = div.select('a')
        if anchors:
            anchor = anchors[0]
            url = anchor['href']
            title = anchor.text
            results.append((url, title))

    return results

def import_results(run_dir):
    '''Import scraping results from a directory'''
    results = []
    gnews_dir = os.path.join(run_dir, 'gnews')
    for root, _, files in os.walk(gnews_dir):
        if root == gnews_dir:
            continue
        query_dir = Path(root).parts[-1]
        terms = query_dir_decode(query_dir)
        for f in files:
            file_name = '/'.join([root, f])
            entries = results_from_file(file_name)
            for url, title in entries:
                results.append(GoogleSearchResult(url, title, terms, f[:-5]))
    return results
