#!/bin/bash
set -e
set -u
set -o pipefail

if [[ ("$1" == "dev") || ("$1" == "slim") ]]; then
  IMAGE="cardano-node-iohk-$1"
elif [[ "$1" == "db" ]]; then
  IMAGE="cardano-db-sync-iohk"
else
  printf "please select an option (cardano node): dev, slim, db"
  exit 1
fi

if [[ ("$2" == "mainnet") || ("$2" == "testnet") ]]; then
  CARDANO_NETWORK="$2"
else
  printf "please select an option (cardano network): mainnet or testnet "
  exit 1
fi

if [[ "$3" == "pull" ]]; then
  docker pull floydcraft/$IMAGE:latest
fi

printf "IMAGE=$IMAGE\nCARDANO_NETWORK=$CARDANO_NETWORK\n"

if [[ "$( docker container inspect -f '{{.State.Running}}' "$IMAGE" )" == "true" ]]; then
  printf "ACTIVE CONTAINER found for: $IMAGE\nattaching to the container\n"
  docker exec -it "$IMAGE" bash
else
  printf "NO ACTIVE CONTAINER found for: $IMAGE\ncleaning containers and creating new container via run\n"
  docker container rm "$IMAGE"
  docker run --name "$IMAGE" -it \
    -v "$PWD/storage/$CARDANO_NETWORK:/storage" \
    --env "CARDANO_NETWORK=$CARDANO_NETWORK" \
    --env "CARDANO_NODE_SOCKET_PATH=/storage/$CARDANO_NETWORK/node.socket" \
    --entrypoint bash "floydcraft/$IMAGE:latest"
fi