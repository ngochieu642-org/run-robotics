FROM python:3.7-bullseye

RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v25.0/protoc-25.0-linux-x86_64.zip \
    && unzip -o protoc-25.0-linux-x86_64.zip -d /usr/local bin/protoc \
    && unzip -o protoc-25.0-linux-x86_64.zip -d /usr/local 'include/*'

RUN apt update  \
    && apt install -y vim \
    && rm -rf /var/lib/apt/lists/*

RUN addgroup --system robotics-group && adduser --ingroup robotics-group robotics
USER robotics:robotics-group

# tensor2robot
WORKDIR /home/robotics/app
RUN mkdir -p tensor2robot-py/src \
    && git clone -b  hieu/test-docker https://github.com/ngochieu642/tensor2robot.git tensor2robot-py/src/tensor2robot

WORKDIR /home/robotics/app/tensor2robot-py/src/tensor2robot/proto
# Generate t2r_p2b.py
RUN protoc -I=./ --python_out=`pwd` t2r.proto

WORKDIR /home/robotics/app
RUN mv /home/robotics/app/tensor2robot-py/src/tensor2robot/pyproject.toml /home/robotics/app/tensor2robot-py/pyproject.toml

WORKDIR /home/robotics/app/tensor2robot-py
RUN pip install .

WORKDIR /home/robotics/app
RUN git clone -b robotics_transformer https://github.com/ngochieu642/tf-agents.git

WORKDIR /home/robotics/app/tf-agents
RUN pip install .

# robotics_transformer
WORKDIR /home/robotics/app
RUN git clone -b  hieu/test-docker https://github.com/ngochieu642/robotics_transformer.git
