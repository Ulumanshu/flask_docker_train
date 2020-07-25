# Copyright (c) Bioinformatics Core Facility of the Max Planck Institute for Biology of Ageing.
# Distributed under the terms of the Modified BSD License.

FROM 'ubuntu'

LABEL maintainer "SDA train"

USER root

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
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
CMD ["python3", "app.py"]
