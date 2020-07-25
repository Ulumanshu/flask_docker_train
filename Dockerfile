# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM 'ubuntu'

LABEL maintainer "SDA train"

USER root


RUN apt-get update && apt-get upgrade -y

ENV SHELL /bin/bash


RUN apt-get update && apt-get -yq dist-upgrade && \
apt-get install -yq python3 python3-pip libcairo2-dev pkg-config python3-dev mariadb-client cron rsync && \
apt-get clean && rm -rf /var/lib/apt/lists/*


COPY requirements.txt /flaski/
RUN pip3 install -r /flaski/requirements.txt

COPY LICENSE.md README.md config.py flaski.py MANIFEST.in requirements.txt setup.py .flaskenv /flaski/
COPY pyflaski /flaski/pyflaski
COPY services /flaski/services
COPY utils /flaski/utils
COPY flaski /flaski/flaski
COPY data /flaski/data
COPY .git /flaski/.git

# Jupyter port
EXPOSE 8888
# Flask
EXPOSE 8000

# Setup default user, when enter docker container
USER flaski:flaski
WORKDIR /flaski

ENTRYPOINT /flaski/services/server/docker-entrypoint.sh