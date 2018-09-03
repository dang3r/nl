import logging
import time
import traceback

import requests

from . import scrape

class Worker:
    def __init__(self, job_queue, proxy_pool, output_dir, limiter):
        self.job_queue = job_queue
        self.proxy_pool = proxy_pool
        self.output_dir = output_dir
        self.limiter = limiter

    def work(self):
        proxy = self.proxy_pool.get()
        logging.info('Worker thread started with proxy %s', proxy.url())

        while True:
            try:
                item = self.job_queue.get()
                if not item:
                    logging.info('Worker stopping because of out of work!')
                    break

                url = item.url()
                self.limiter.increment(url)
                logging.info(f'Downloading {url}')
                resp = scrape.get(url, proxy.url())
                item.process(resp, self.job_queue, self.output_dir)
                
                time.sleep(0.5)
                self.job_queue.task_done()
            except requests.exceptions.RequestException as err:
                self.job_queue.task_done()

                # If we have no reached the limit for a given url, try again.
                if not self.limiter.done(url):
                    logging.info('Putting %s back in the job queue', url)
                    self.job_queue.put(item)
                logging.info('Error getting %s with limit %s : %s ', str(item), self.limiter.get(url), err)
                self.proxy_pool.replace(proxy)
                proxy = self.proxy_pool.get()
            except Exception as err:
                self.job_queue.task_done()
                self.proxy_pool.put(proxy)
                logging.info('Unrecoverable Exception occurred! %s', err)
                traceback.print_exc()
                break