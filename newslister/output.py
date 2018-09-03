import os

def query_dir_encode(terms):
    return '_'.join(terms)

def query_dir_decode(directory):
    return directory.split('_')

def init_output_dir(root_dir, queries, article_dir='articles', gnews_dir='gnews'):
    os.makedirs(os.path.join(root_dir, article_dir), exist_ok=True)
    for query in queries:
        query_dir = query_dir_encode(query)
        os.makedirs(os.path.join(root_dir, gnews_dir, query_dir), exist_ok=True)
