from newslister import search_queries

def test_basic():
    queries = search_queries(['foo'], ['bar', 'baz'])
    assert queries == [['foo', 'bar'], ['foo', 'baz']]

def test_no_common():
    queries = search_queries([], ['bar', 'baz'])
    assert queries == [['bar'], ['baz']]

def test_no_terms():
    assert search_queries([], []) == []
