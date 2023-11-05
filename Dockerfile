FROM python:3.7-bullseye
WORKDIR /app
COPY robotics_transformer ./robotics_transformer

RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v25.0/protoc-25.0-linux-x86_64.zip \
    && unzip -o protoc-25.0-linux-x86_64.zip -d /usr/local bin/protoc \
    && unzip -o protoc-25.0-linux-x86_64.zip -d /usr/local 'include/*'

COPY tensor2robot ./tensor2robot-py/src/tensor2robot

RUN mv /app/tensor2robot-py/src/tensor2robot/pyproject.toml /app/tensor2robot-py/pyproject.toml

WORKDIR /app/tensor2robot-py
RUN pip install .
