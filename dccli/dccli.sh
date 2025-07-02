#!/bin/bash

usage() {
    echo -e "`basename \"${0}\"` <action> <compose folder>"
    echo -e "\taction: pull, down, up, down-up"
}

if [[ ${#} != 2 ]]; then
    usage
fi

DOCKER_DIR=~/docker
DOCKER_ACTION=${1}
DOCKER_COMPOSE_DIR=${2}

if [ ! -d "${DOCKER_DIR}/${DOCKER_COMPOSE_DIR}" ]; then
    echo "Compose folder not found"
fi

cd ${DOCKER_DIR}/${DOCKER_COMPOSE_DIR}

case ${DOCKER_ACTION} in
    pull)
        docker compose pull
        ;;
    down)
        docker compose down
        ;;
    up)
        docker compose up -d
        ;;
    down-up)
        docker compose down
        docker compose up -d
        ;;
    *)
        usage
        ;;
esac
