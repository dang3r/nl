import time

def retry(func, tries=5, delay=2):
    """Retry a function for a certain number of tries with delays"""
    for _ in range(tries - 1):
        try:
            ret = func()
            return ret
        except Exception:
            time.sleep(delay)
    return func()
