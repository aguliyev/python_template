.PHONY: build
build:
	docker-compose build

.PHONY: start
start:
	docker-compose up -d python_template_web

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
	docker-compose run --env-file etc/env/test.env --env-file etc/secrets/test.env --rm python_template_web pytest tests

.PHONY: jupyter
jupyter:
	docker-compose up -d python_template_jupyter
	sleep 4
	docker logs --tail 8 python_template_jupyter
