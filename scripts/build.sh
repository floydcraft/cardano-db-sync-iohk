#!/bin/bash
#set -e
#set -u
#set -o pipefail

IMAGE_TAG=9.0.0

if [[ ("$1" == "dev") || ("$1" == "slim") ]]; then
  if [[ "$1" == "dev" ]]; then
    BASE_IMAGE="haskell"
    BASE_IMAGE_TAG="latest"
  else
    BASE_IMAGE="cardano-db-sync-iohk-dev"
    BASE_IMAGE_TAG=$IMAGE_TAG
  fi

  IMAGE="cardano-db-sync-iohk-$1"
else
  printf "please select an option (cardano-db-sync-iohk): dev or slim"
  exit 1
fi

if [[ "$2" == "pull" ]]; then
  docker pull "floydcraft/$BASE_IMAGE:$BASE_IMAGE_TAG"
fi

docker build \
    --tag "floydcraft/$IMAGE:$IMAGE_TAG" \
    "$1"