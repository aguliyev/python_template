.PHONY: build
build:
	docker-compose build

.PHONY: start
start:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose stop

.PHONY: bashin
bashin:
	docker exec -it python_template_web bash

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
