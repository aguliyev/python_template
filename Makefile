.PHONY: prepack
prepack:
	@echo "Building prepack.."
	@export $(shell cat ./.env | grep "#" -v) && env $(shell cat ./.env | grep "#" -v) docker build --target python_template_prepack -t $$PREPACK_IMAGE --build-arg PIP_PARAMS="$$PIP_PARAMS" --build-arg APPUSER=$$APPUSER .
	@export $(shell cat ./.env | grep "#" -v) && echo "Push prepack to $$PREPACK_IMAGE"
	@export $(shell cat ./.env | grep "#" -v) && docker push $$PREPACK_IMAGE

.PHONY: build
build:
	docker-compose build

.PHONY: publish
publish:
	@export $(shell cat ./.env | grep "#" -v) && docker push $$IMAGE

.PHONY: start
start:
	docker-compose up -d python_template_redis python_template_postgres
	docker-compose up -d python_template_web

.PHONY: test
startprod:
	@echo "System env vars take precedence over vars in .env file. Additionally, loading /path/to/.env.prod as system env vars."
	@env $(shell cat /path/to/.env.prod | grep "#" -v) docker-compose up -d python_template_web

.PHONY: test
test:
	@echo "System env vars take precedence over vars in .env file. Loading .env.test as system env vars."
	@env $(shell cat ./.env.test | grep "#" -v) docker-compose up -d python_template_redis python_template_postgres
	@env $(shell cat ./.env.test | grep "#" -v) docker-compose up python_template_web

.PHONY: stop
stop:
	docker-compose stop

.PHONY: seelogs
seelogs:
	docker logs -f python_template_web

.PHONY: jupyter
jupyter:
	docker-compose up -d python_template_jupyter
	sleep 4
	docker logs --tail 8 python_template_jupyter

.PHONY: shell
shell:
	docker-compose exec -it python_template_web sh

.PHONY: shellrun
shellrun:
	docker-compose run --rm python_template_web sh
