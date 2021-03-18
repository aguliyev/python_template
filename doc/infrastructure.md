# infrastructure

- [Overview](#overview)
- [Make commands](#make-commands)
- [Build and publish docker image](#build-and-publish-docker-image)
    - [Prepack](#prepack)
- [Environment configs passed to container](#environment-configs-passed-to-container)
    - [Non-secrets](#non-secrets)
    - [Secrets](#secrets)
    - [Run in different environments](#run-in-different-environments)
    - [Nginx conf](#nginx-conf)
- [Entrypoint](#entrypoint)
    - [Setup scripts](#setup-scripts)
    - [Run entrypoint in different ways](#run-entrypoint-in-different-ways)
- [Shell](#shell)
- [Starting shortcuts](#starting-shortcuts)
- [More](#more)
- [Jupyter](#jupyter)
- [Web](#web)
- [Nginx](#nginx)
- [DB](#db)


## Overview

Template used: https://github.com/aguliyev/python_template 

# make commands

[Makefile](/Makefile)

    make prepack
    
    make build
    
    make publish
    
    make start
    
    make startprod

    make test

    make stop
        
    make seelogs
    
    make jupyter

    make shell
    
    make shellrun

    make dbbackup

    make dbbackuprestore

# Build and publish docker image

    make build publish

The image name and repo is specified in `IMAGE` var in [.env](/.env) file or system environment.

## prepack

It is optional; just a way of "storing cache in the repo" instead of relying on local cache.

Create an intermediate docker image ("prepack" stage) according to the stage build in [Dockerfile](Dockerfile), and push it into the repo:

    make prepack

- The docker repo for the image is defined by `PREPACK_IMAGE` var in [.env](.env) file or system environment.

To build using this "prepack" image:

- `FROM_PREPACK=_from_prepack` in env file (see example in [.env.prod](.env.prod) ) or in system environment.
    - In this case, [Dockerfile_from_prepack](Dockerfile_from_prepack) is used instead of the main [Dockerfile](Dockerfile).

# Environment configs passed to container

### non-secrets

- [etc/env/](/etc/env/) a file per environment

    - environment variables which can be commited to repo.
    
### secrets

- [etc/secrets/](/etc/secrets/) a file per environment

    - Environment variables which can **NOT** be commited to repo.
    - You may commit secrets for **dev** and **test** only to the repo.
    - For other environments (prod, stage), you have those files somewhere on the server but not in the repo.
    - Path to the secrets file is specified in `SECRETS_FILE` var in [.env](/.env) file or system environment.

## Run in different environments

- Variables used as configs for [docker-compose.yml](/docker-compose.yml) and [Makefile](/Makefile) come from (in this order):
    - system environment variables.
    - `.env.<env-name>` file is loaded to system environment by certain [Makefile](/Makefile) shortcut commands (`test`, `startprod`).
    - [.env](/.env) file (defaults)
- Variable `SECRETS_FILE` is a path to the file which will be passed as additional container environment.
    - See [#secrets](#secrets)
- Values present in the environment at runtime always override those defined inside the .env file.
    Similarly, values passed via command-line arguments take precedence as well.
    - So, you can avoid putting secrets into the file.
    - In Kubernetes, it will be all in your environment variables, and you can use file for local dev/test only.
- If you want to pass environment variable to container - include its name in [docker-compose.yml](/docker-compose.yml) `environment:` section.

### nginx conf

- [etc/nginx/](/etc/nginx/) a dir/file per environment. Correct ports there, if you wish to access thru nginx

# Entrypoint

- [entrypoints/base.sh](/entrypoints/base.sh)
- You can have also per-environment entrypoint scripts, and `default` script; see [entrypoints/](/entrypoints/).
    - E.g.: [entrypoints/test.sh](/entrypoints/test.sh) is running tests.

## Setup scripts

You may want to setup/bootstrap app on each startup - like DB migrations, data seeding etc.

- [entrypoints/setups/base.sh](/entrypoints/setups/base.sh)
- You can have also per-environment setup entrypoint scripts, just add them to [entrypoints/setups/](/entrypoints/setups/)

### Running or skipping setup in entrypoint 

- In some cases, you want to skip that slow step, and have lean entrypoint.
- That is controlled by var `DO_SETUP` in [.env](/.env) file or system environment.
- E.g.:

        env DO_SETUP=0 make start
        
## Run entrypoint in different ways

You can modify behavior of entrypoint (or setup) script when running it, by passing var `ENTRYPOINT_MODE` when running:

        env ENTRYPOINT_MODE=lights_off make start
        
        env ENTRYPOINT_MODE=integration make test

This var is passed down to container, and can be checked inside the script.

# Shell

Shell into running container:

    make shell

Run container console (without standard entrypoint):

    make shellrun

# Starting shortcuts

Start with dependencies:

    make start

Load [.env.prod](/.env.prod) and start without dependencies:

    make startprod

Load [.env.test](/.env.test) and start with dependencies (the entrypoint runs tests):

    make test

# More

See [doc/](/doc/)

# Jupyter

- Run command in [Makefile](/Makefile)

        make jupyter

    It will print the Jupyter access token.

- [notebooks/](/notebooks/)

# Web

- http://localhost:5000/
- http://localhost:8081/web/

# Nginx

- We run nginx, which can be optionally used and expanded.
- Just update configs in [etc/nginx/](/etc/nginx/)

# DB

    make dbbackup

    make dbbackuprestore
