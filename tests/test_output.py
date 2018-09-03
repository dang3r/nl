from newslister import output

def test_encode():
    assert output.query_dir_encode(['foo', 'bar']) == 'foo_bar'

def test_decode():
    assert output.query_dir_decode('foo_bar') == ['foo', 'bar']