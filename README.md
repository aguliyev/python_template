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

environment variables which can **NOT** be commited to repo. We may commit secrets for dev and test to the repo;
 for other environments, you have those files on the server but not in the repo.

# run in different environments

- [.env](.env) 

    has variables used as configs for [docker-compose.yml](docker-compose.yml).

- System env vars take precedence over vars in [.env](.env) file.

- We load `.env.<env-name>` files as system env vars. For production - that is a file on the server, not in this repo.

    See [Makefile](Makefile) command `make startprod`

- Those `.env.<env-name>` files also have paths to the files which will be passed as container environment.

    E.g. see [.env.test](.env.test)

- For production, secrets for container will be file on the server, not in this repo.

# entrypoints

Per environment:

- [entrypoints/](entrypoints/)

Notice: [entrypoints/test.sh](entrypoints/test.sh) is running tests.

# More

See [doc/](doc/)

# Jupyter

- Run command in [Makefile](Makefile)
- [notebooks/](notebooks/)

# Web

- http://localhost:5000/
