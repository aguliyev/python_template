.PHONY: prepack
prepack:
	@echo "Building prepack.."
	@export $(shell cat .env | grep "#" -v) && env $(shell cat ./.env | grep "#" -v) docker build --target python_template_prepack -t $$PREPACK_IMAGE --build-arg PIP_PARAMS="$$PIP_PARAMS" --build-arg APPUSER=$$APPUSER .
	@export $(shell cat .env | grep "#" -v) && echo "Push prepack to $$PREPACK_IMAGE"
	@export $(shell cat .env | grep "#" -v) && docker push $$PREPACK_IMAGE

.PHONY: build
build:
	docker-compose build

.PHONY: publish
publish:
	@export $(shell cat .env | grep "#" -v) && docker push $$IMAGE

.PHONY: start
start:
	docker-compose up -d python_template_redis python_template_postgres
	docker-compose up -d python_template_web python_template_nginx

.PHONY: test
startprod:
	@echo "System env vars take precedence over vars in .env file. Additionally, loading .env.prod as system env vars."
	@env $(shell cat .env .env.prod | grep "#" -v) docker-compose up -d python_template_web

.PHONY: test
test:
	@env $(shell cat .env .env.test | grep "#" -v) docker-compose up -d python_template_redis python_template_postgres
	@env $(shell cat .env .env.test | grep "#" -v) docker-compose up python_template_web

.PHONY: test
testshell:
	@env $(shell cat .env .env.test | grep "#" -v) DO_SETUP=0 ENTRYPOINT_MODE=shellrun docker-compose run --rm python_template_web sh

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
	docker-compose exec python_template_web sh

.PHONY: shellrun
shellrun:
	@env DO_SETUP=0 ENTRYPOINT_MODE=shellrun docker-compose run --rm python_template_web sh

.PHONY: dbbackup
dbbackup:
	docker exec -it marketsage_postgres bash -c "pg_dump --clean --username=\$$POSTGRES_USER --compress=9 --file=/mnt/backups/dump_\$$POSTGRES_DB\_`date +%Y-%m-%d_%H_%M_%S`.sql.gz \$$POSTGRES_DB"

.PHONY: dbbackuprestore
dbbackuprestore:
	echo "TODO"
