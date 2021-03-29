#!/bin/bash
#set -e
#set -u
#set -o pipefail

IMAGE_TAG=9.0.0

if [[ ("$1" == "dev") || ("$1" == "slim") ]]; then
  IMAGE="cardano-db-sync-iohk-$1"
else
  printf "please select an option (cardano-db-sync): dev or slim"
  exit 1
fi

docker stop "$IMAGE"
docker rm "$IMAGE"