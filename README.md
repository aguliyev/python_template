# python_template

- [Infrastructure](doc/infrastructure.md)

Template for dockerized python project with environment and entrypoint management - web, jupyter, nginx.

The aim is to have:

- fully agnostic: docker-compose, dockerfile, built image. Having the same command to run everywhere, but entrypoint working differently based on passed environment.
- non-secrets consolidated in env files in repo and passed to container.
- secrets as env vars from host runtime and/or from a file (outside from repo), all passed to container.
- kubernetes ready
- unified commands, abstracting underlying details for all tasks.
- all this code clean and well-organized.
- multistage build is an option, but redundant.
