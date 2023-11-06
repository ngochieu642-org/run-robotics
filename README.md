# How to run

- build

```bash
make build
```

- Build without cache
```bash
docker compose build --no-cache
```

- create the container
```bash
make up
 ```

- The command to run in `robotics_transformer`
```bash
make exec
robotics@4eeae5ba51ca:~/app$ python -m robotics_transformer.tokenizers.action_tokenizer_test
 ```
