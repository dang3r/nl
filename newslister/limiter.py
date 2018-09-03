import threading

class Limiter:
    '''A limit keeps track of the count of certain keys
    If a key's count exceeds the limit, it is considered done.
    '''
    def __init__(self, limit=2):
        self.d = dict()
        self.limit = limit
        self.lock = threading.Lock()

    def get(self, url):
        return self.d.get(url, 0)

    def increment(self, url):
        with self.lock:
            if url in self.d:
                self.d[url] += 1
            else:
                self.d[url] = 1

    def done(self, url):
        return self.d.get(url, 0) >= self.limit
