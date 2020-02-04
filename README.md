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
    
    make jupyter

# environment configs and secrets

[etc/](etc/)

(here, we commit secrets for dev and test to the repo;
 for other environments, you definitely have files on the server but not in the repo.)

# run in different environments

- Add `.env.<env-name>` file with paths to the files which will be passed as container environment. E.g.
    [.env.test](.env.test)

- Load that `.env.<env-name>` when running `docker-compose`. E.g. 
    see [Makefile](Makefile) command `make test`

- When you need secrets for `docker-compose.yml` - have them in environment variables on the server (they override what is specified in `.env` file), so that you don't commit it to the repo.
(Here, we have commited everything to the repo for `test`; but you definitely don't want to do it for other environments).

# More

See [doc/](doc/)

# Jupyter

- Run command in [Makefile](Makefile)
- [notebooks/](notebooks/)
