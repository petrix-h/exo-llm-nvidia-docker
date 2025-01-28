# exo-llm-nvidia-docker
Testing running Exo LLM cluster in docker containers

# Create the image
```
docker build -t exo-test-nvidia .
```

## Run exo interactively (to monitor/debug)

```
docker run --gpus all -it -p 52415:52415 exo-test-nvidia /bin/bash
```

```
cd exo
```

```
exo
```

## Run container non-interactive (can't see status of cluster)

```
docker run --gpus all -p 52415:52415 exo-test-nvidia
```
