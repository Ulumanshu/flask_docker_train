# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM 'ubuntu'

LABEL maintainer "SDA train"

USER root

RUN apt-get update && apt-get upgrade -yq
RUN apt-get install -yq \
    libmysqlclient-dev\
    curl \
    git \   
    python3.8 \
    python3-pip
ENV SHELL /bin/bash
RUN mkdir /flask_docker/
COPY . /flask_docker/
WORKDIR /flask_docker/
RUN pip3 install -r requirements.txt

# Flask
EXPOSE 5000
ENTRYPOINT python3 app.py
