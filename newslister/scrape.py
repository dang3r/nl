import requests

HEADERS = {
    'accept-language': 'en-US,en;q=0.9',
    'cache-control': 'no-cache',
    'pragma': 'no-cache',
    'upgrade-insecure-requests': '1',
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36'
}

def get(url, proxy_url):
    """Retrieve a given url using a proxy"""
    resp = requests.get(url, headers=HEADERS, proxies={'https': proxy_url}, timeout=5)
    resp.raise_for_status()
    return resp
