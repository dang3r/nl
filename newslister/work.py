import os
from urllib.parse import urlencode, urlparse, urlunparse, quote
import urllib

from . import parser
from .output import query_dir_encode

class GoogleNewsItem:
    '''A url for a google news page containing links to articles'''
    google_news_url = 'https://www.google.com/search'

    def __init__(self, terms, page):
        self.terms = terms
        self.page = page

    def process(self, resp, queue, output_root_dir):
        for url, _ in parser.results_from_text(resp.text):
            queue.put(BasicItem(url))

        child_dir = query_dir_encode(self.terms)
        file_name = F'{self.page}.html'
        file_path = os.path.join(output_root_dir, 'gnews', child_dir, file_name)
        with open(file_path, 'w+') as f:
            f.write(resp.text)

    def url(self):
        url_parts = list(urlparse(self.google_news_url))
        url_parts[4] = urlencode(self.params())
        return urlunparse(url_parts)

    def params(self):
        q = '+'.join(self.terms).replace(' ', '+')
        return {
            'tbm': 'nws',
            'start': self.page * 10,
            'q': q
        }

    def __repr__(self):
        encoded_params = urlencode(self.params())
        return F'{self.url()}?{encoded_params}'


class BasicItem:
    '''An item for a standalone url'''
    def __init__(self, url):
        self._url = url

    def url(self):
        return self._url

    def params(self):
        return {}

    def process(self, resp, queue, output_root_dir):
        fmt_url = quote(self._url, safe='')
        file_path = os.path.join(output_root_dir, 'articles', fmt_url)
        with open(file_path, 'w+') as f:
            f.write(resp.text)

    def __repr__(self):
        return self._url
