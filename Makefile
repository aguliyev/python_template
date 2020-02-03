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
