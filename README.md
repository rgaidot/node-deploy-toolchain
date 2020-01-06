# node-deploy-toolchain

A toolchain to build, test and deploy javascript applications. node-deploy-toolchain use [Vault](https://www.vaultproject.io) to set environment variables.
This image is available on [Docker Hub](https://hub.docker.com/r/rgaidot/node-deploy-toolchain)

## Pre-requisites

- [Docker](https://www.docker.com)
- [AWS Developer account](https://console.aws.amazon.com/)
- [Vault](https://www.vaultproject.io)
- [kubernetes](https://kubernetes.io/) ([kompose](https://github.com/kubernetes/kompose) and [kops](https://github.com/kubernetes/kops))

## How to use

### Build docker images

```
docker build --squash . -t node-deploy-toolchain
```

### Push your docker image on your AWS ECR

```
docker tag node-deploy-toolchain ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/node-deploy-toolchain
docker push ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/node-deploy-toolchain
```

### Usage

_You need VAULT_TOKEN and VAULT_URL_

#### On your CLI

```
docker run -ti -e VAULT_TOKEN=<VAULT_TOKEN> -e VAULT_URL=<VAULT_URL> ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/node-deploy-toolchain aws s3 ls
```

#### With Dockerfile

```
FROM ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com/node-deploy-toolchain

ARG VAULT_TOKEN
ARG VAULT_URL

WORKDIR /app
COPY . /app

RUN npm run test
```
