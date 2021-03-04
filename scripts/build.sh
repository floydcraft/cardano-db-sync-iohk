#!/bin/bash
set -e
set -u
set -o pipefail

if [[ ("$1" == "dev") || ("$1" == "slim") ]]; then
  IMAGE="cardano-node-iohk-$1"
else
  printf "please select an option (cardano node): dev or slim"
  exit 1
fi

docker build \
    --tag "floydcraft/$IMAGE:latest" \
    "$IMAGE"