install:
	pip3 install -r requirements.txt

build:
	pip3 install .

lint:
	pylint --disable=R,C newslister/ bin/* tests/

test:
	pytest tests

clean:
	rm -rf build dist newslister.egg-info

.PHONY: build kill
