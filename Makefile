.PHONY: start
start:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose stop

.PHONY: build
build:
	docker-compose build

.PHONY: seelogs
seelogs:
	docker logs -f python_template_web

.PHONY: tests
tests:
	docker-compose run --rm python_template_web pytest tests

.PHONY: jupyter
jupyter:
	docker run --rm -p 8888:8888 -e JUPYTER_ENABLE_LAB=yes \
	    --name python_template_jupyter \
	    -v "$(shell pwd)/notebooks":/home/jovyan/work \
	    -v "$(shell pwd)":/home/jovyan/app \
	    jupyter/datascience-notebook
s