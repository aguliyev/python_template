.PHONY: build
build:
	docker-compose build

.PHONY: start
start:
	docker-compose up -d python_template_redis
	docker-compose up -d python_template_postgres
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
	@echo "System env vars take precedence over vars in .env file. Loading .env.test as system env vars."
	@env $(shell cat ./.env.test | grep "#" -v) docker-compose up -d python_template_redis
	@env $(shell cat ./.env.test | grep "#" -v) docker-compose up -d python_template_postgres
	@env $(shell cat ./.env.test | grep "#" -v) docker-compose up python_template_web

.PHONY: test
startprod:
	@echo "System env vars take precedence over vars in .env file. Loading /path/to/.env.prod as system env vars."
	@env $(shell cat /path/to/.env.prod | grep "#" -v) docker-compose up -d python_template_web

.PHONY: jupyter
jupyter:
	docker-compose up -d python_template_jupyter
	sleep 4
	docker logs --tail 8 python_template_jupyter
