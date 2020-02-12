FROM python:3.8.1-alpine3.11 as python_template_prepack

ARG PIP_PARAMS

WORKDIR /app
RUN apk update && \
    apk add build-base libpq postgresql-dev libxml2-dev libxslt-dev musl-dev libbz2 bzip2-dev xz-dev

COPY requirements.txt ./

RUN pip install ${PIP_PARAMS} -r requirements.txt


FROM python_template_prepack
COPY . .
