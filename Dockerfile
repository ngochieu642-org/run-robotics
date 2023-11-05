FROM python:3.7-bullseye
WORKDIR /app
COPY robotics_transformer ./robotics_transformer

RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v25.0/protoc-25.0-linux-x86_64.zip \
    && unzip -o protoc-25.0-linux-x86_64.zip -d /usr/local bin/protoc \
    && unzip -o protoc-25.0-linux-x86_64.zip -d /usr/local 'include/*'

RUN apt update  \
    && apt install -y vim \
    && rm -rf /var/lib/apt/lists/*

COPY tensor2robot ./tensor2robot-py/src/tensor2robot

WORKDIR /app/tensor2robot-py/src/tensor2robot/proto
# Generate t2r_p2b.py
RUN protoc -I=./ --python_out=`pwd` t2r.proto

WORKDIR /app
RUN mv /app/tensor2robot-py/src/tensor2robot/pyproject.toml /app/tensor2robot-py/pyproject.toml

WORKDIR /app/tensor2robot-py
RUN pip install .

WORKDIR /app
RUN git clone -b robotics_transformer https://github.com/ngochieu642/tf-agents.git

WORKDIR /app/tf-agents
RUN pip install .
