# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM 'ubuntu'

LABEL maintainer "SDA train"

USER root

RUN apt-get update && apt-get upgrade -y

ENV SHELL /bin/bash
RUN mkdir /flask_docker/
COPY . /flask_docker/
RUN pip3 install pipenv
RUN pipenv install
RUN pipenv shell


# Flask
EXPOSE 5000

WORKDIR /flask_docker/
 
ENTRYPOINT python app.py