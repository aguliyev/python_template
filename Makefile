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

.PHONY: test
test:
	env $(cat .env.test | grep "#" -v) docker-compose run --rm python_template_web pytest tests

.PHONY: jupyter
jupyter:
	docker-compose up -d python_template_jupyter
	sleep 4
	docker logs --tail 8 python_template_jupyter
