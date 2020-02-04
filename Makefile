.PHONY: build
build:
	docker-compose build

.PHONY: start
start:
	docker-compose up -d python_template_web

.PHONY: stop
stop:
	docker-compose stop

.PHONY: shell
shell:
	docker exec -it python_template_web sh

.PHONY: seelogs
seelogs:
	docker logs -f python_template_web

.PHONY: test
test:
	@env $(shell cat ./.env.test | grep "#" -v) docker-compose run --rm python_template_web pytest tests -vv

.PHONY: jupyter
jupyter:
	docker-compose up -d python_template_jupyter
	sleep 4
	docker logs --tail 8 python_template_jupyter
