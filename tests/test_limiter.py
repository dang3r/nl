from newslister import limiter

def test_basic():
    l = limiter.Limiter()

    assert l.get('foo') == 0
    l.increment('foo')
    assert l.get('foo') == 1
    l.increment('foo')
    assert l.done('foo')

def test_not_done():
    assert not limiter.Limiter().done('foo')
