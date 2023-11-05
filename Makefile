build:
	docker compose up --build -d

up:
	docker compose up -d

down:
	docker compose down

download-protobuf:
	curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v25.0/protoc-25.0-linux-x86_64.zip
