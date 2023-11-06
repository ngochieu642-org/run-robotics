build:
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

exec:
	docker exec -it robotics-transformer-demo bash

download-protobuf:
	curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v25.0/protoc-25.0-linux-x86_64.zip
