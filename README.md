# safe-hive

## Prerequisites

* `fish`
* [`nvidia-container-toolkit`](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)


## Getting started

> Add the `$PWD/bin` to your `PATH` in your zsh/fish/... config first!

> Make sure you have `fish` installed!

First, take a look at [`bin/hive`](bin/hive) and edit the `NAME` to yours ;)

Building and running the `hive` for the first time:
```sh
hive build
hive bash 
# Creating new container: benedikt-agent-home-bkantz-agents
# bkantz@f29f7c373688:~/agents$ 
```

## Running the agents

```sh
hive claude
#OR
hive pi
#OR 
hive hermes
```

Feel free to adapt the [`Dockerfile`](Dockerfile.base) to your liking; and note that the `hive` system *will* get GPU access by default!


## Docker Compose for local inference

You can also use the `docker-compose.yml` to run local LLMs. Download their GGUF's (or change them) first (assuming you have the [huggingface CLI installed](https://huggingface.co/docs/huggingface_hub/guides/cli)):
```sh
hf download hf://unsloth/Qwen3.8-27B-GGUF/Qwen3.8-27B-UD-Q4_K_S.gguf --local-dir ./models/gguf      
hf download hf://LiquidAI/LFM2.5-24B-A2B-GGUF/LFM2.5-24B-A2B-QAD-Q4_0.gguf
UID="$(id -u)" GID="$(id -g)" docker compose up -d
```
### Accessing the models in `PI`

Create and add this to `.pi/agent/models`:
```json
{
    "providers": {
        "cpu-models": {
            "baseUrl": "http://localhost:8999/v1",
            "api": "openai-completions",
        },
        "gpu-models": {
            "baseUrl": "http://localhost:8998/v1",
            "api": "openai-completions",
        }
    }
}
```