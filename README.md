# python_template

Template for dockerized python project - web, jupyter.

# make commands

[Makefile](Makefile)

    make build
    
    make start
    
    make stop
    
    make shell
    
    make seelogs
    
    make test
    
    make startprod
    
    make jupyter

# environment configs and secrets

- [etc/env/](etc/env/)

environment variables which can be commited to repo.

- [etc/secrets/](etc/secrets/)

environment variables which can **NOT** be commited to repo. 
We may commit secrets for dev and test to the repo; 
but for other environments, you have those files on the server but not in the repo.

# run in different environments

- Variables used as configs for [docker-compose.yml](docker-compose.yml) are in

    [.env](.env) 

- System env vars take precedence over vars in [.env](.env) file.

- We load `.env.<env-name>` files as system env vars. For production - that is a file on the server, not in this repo.

    See [Makefile](Makefile) command `make startprod`

- Those `.env.<env-name>` files also have paths to the files which will be passed as container environment (specified by `ENV_FILE, SECRETS_FILE`).

    E.g. see [.env.test](.env.test)

- For production, secrets for container (specified by `SECRETS_FILE`) will be file on the server, not in the repo.

# entrypoints

Per environment:

- [entrypoints/](entrypoints/)

Notice: [entrypoints/test.sh](entrypoints/test.sh) is running tests.

# running or skipping setup in entrypoint

You may want to set up app on each startup - like DB migrations etc.

In some cases, you want to skip that slow step, and have lean entrypoint.

That is controlled by var `DO_SETUP`. 
It is in [.env](.env), and make be overloaded by system env var when needed:

        env DO_SETUP=0 make start

# More

See [doc/](doc/)

# Jupyter

- Run command in [Makefile](Makefile)

        make jupyter

- [notebooks/](notebooks/)

# Web

- http://localhost:5000/
