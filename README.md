# python_template

Template for dockerized python project - web, jupyter.

# make commands

[Makefile](Makefile)

    make prepack
    
    make build
    
    make start
    
    make startprod

    make test

    make stop
        
    make seelogs
    
    make jupyter

    make shell

# prepack and build

- It is optional; Is it just a way of "storing cache in the repo" instead of relying on local cache.
- `make prepack` is creating a docker image for "prepack" stage of [Dockerfile](Dockerfile), and pushes it into the repo.
- You build from this "prepack" image by having `FROM_PREPACK=_from_prepack` in .env file (see [.env.prod.sample](.env.prod.sample) ) or system environment (it is empty by default).
    - In this case, [Dockerfile_from_prepack](Dockerfile_from_prepack) is used instead of the main [Dockerfile](Dockerfile).
- The docker repo for the image is defined by `PREPACK_IMAGE` env var.

# Environment configs and secrets

- [etc/env/](etc/env/)

    environment variables which can be commited to repo.
    
    path to this file is specified in `ENV_FILE`

- [etc/secrets/](etc/secrets/)

    environment variables which can **NOT** be commited to repo. 
    
    We may commit secrets for dev and test only to the repo;
    
    but for other environments (prod, stage), you have those files somewhere on the server but not in the repo.
    
    path to this file is specified in `SECRETS_FILE`

## Run in different environments

- Variables used as configs for [docker-compose.yml](docker-compose.yml) are in

    [.env](.env) 

- System env vars take precedence over vars in [.env](.env) file. (So, you can avoid putting secrets into the file)

- We load `.env.<env-name>` files as system env vars.
    See [Makefile](Makefile) command `make test`

    For production - that is a file somewhere on the server, not in this repo (if you decide to include secrets into this file).
    See [Makefile](Makefile) command `make startprod`

- Those `.env.<env-name>` files also contain paths to the files which will be passed as container environment (vars `ENV_FILE, SECRETS_FILE`).

    E.g. see [.env.test](.env.test), [.env.prod.sample](.env.prod.sample)

- For production, secrets for container (specified by `SECRETS_FILE`) will be a file somewhere on the server, not in the repo.

# Entrypoints

Per-environment entrypoint scripts:

- [entrypoints/](entrypoints/)

Notice: [entrypoints/test.sh](entrypoints/test.sh) is running tests.

## Running or skipping setup in entrypoint

You may want to setup/bootstrap app on each startup - like DB migrations, data seeding etc.

Per-environment setup scripts:

- [entrypoints/setups/](entrypoints/setups/)

In some cases, you want to skip that slow step, and have lean entrypoint.

That is controlled by var `DO_SETUP`.
It is in [.env](.env), and may be overloaded by system env var when needed. E.g. run as:

        env DO_SETUP=0 make start
        
and yes, you can specify this var in `.env` file for each environment (e.g. [.env.test](.env.test)).

## Run entrypoint in different ways

You can modify behavior of entrypoint (or setup) script when running it, by passing var `ENTRYPOINT_MODE` when running:

        env ENTRYPOINT_MODE=lights_off make start
        
        env ENTRYPOINT_MODE=integration make test

This var is passed down to container, and can be checked inside the script.

# More

See [doc/](doc/)

# Jupyter

- Run command in [Makefile](Makefile)

        make jupyter

- [notebooks/](notebooks/)

# Web

- http://localhost:5000/
