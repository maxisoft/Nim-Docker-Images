# Nim-Docker-Images
Docker image with recent [Nim](https://nim-lang.org/) included

## TLDR
```sh
docker run -it --rm ghcr.io/maxisoft/nim-docker-images/nim
```

## Technical descriptions
We use [github actions](https://github.com/maxisoft/Nim-Docker-Images/blob/main/.github/workflows/docker.yml) and [github packages](https://github.com/maxisoft?tab=packages&repo_name=Nim-Docker-Images) to build and deploy a multi arch docker image.  
Currently the supported arch are `armv7`, `arm64` and `x64`.

### Image creation steps
- use [\_/Alpine](https://hub.docker.com/_/alpine) as base
- install several packages such as dependencies (sqlite, ssl, ect...) and compilers/interpreters (gcc, g++, nodejs)
- clone official [Nim](https://github.com/nim-lang/Nim) repo and checkout a specific tag
- compile and install nim into `/nim`

### How to add and use the latest Nim version
- Fork the repo
- **Enable** the github actions in your own forked repo
- Edit the [github actions file](https://github.com/maxisoft/Nim-Docker-Images/blob/8828877/.github/workflows/docker.yml#L10=) to checkout the newest version tag
- Commit and wait for the github actions to successfully build an image
- Create a pull request
