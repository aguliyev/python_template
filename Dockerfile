FROM python:3.8.1-alpine3.11 as python_template_prepack

ARG PIP_PARAMS
ARG APPUSER

RUN apk update && \
    apk add build-base libpq postgresql-dev libxml2-dev libxslt-dev musl-dev libbz2 bzip2-dev xz-dev

RUN adduser -D ${APPUSER}

RUN mkdir -p /opt/pycharm && \
    chown ${APPUSER} /opt/pycharm

USER ${APPUSER}
WORKDIR /home/${APPUSER}/app
ENV PATH $PATH:/home/${APPUSER}/.local/bin

COPY requirements.txt ./
RUN echo "Running pip install with params: ${PIP_PARAMS}" && \
    pip install ${PIP_PARAMS} -r requirements.txt

COPY requirements1.txt ./
RUN echo "Running pip install for new/volatile modules with params: ${PIP_PARAMS}" && \
    pip install ${PIP_PARAMS} -r requirements1.txt


FROM python_template_prepack
COPY . .

ENTRYPOINT ["entrypoints/base.sh"]
