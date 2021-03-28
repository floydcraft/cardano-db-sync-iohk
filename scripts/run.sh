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

if [[ "$2" == "pull" ]]; then
  docker pull "floydcraft/$IMAGE:$IMAGE_TAG"
fi

if [[ "$( docker container inspect -f '{{.State.Running}}' "$IMAGE" )" == "true" ]]; then
  printf "ACTIVE CONTAINER found for: $IMAGE\nattaching to the container\n"
  docker exec -it "$IMAGE" /bin/bash
else
  printf "NO ACTIVE CONTAINER found for: $IMAGE\ncleaning containers and creating new container via run\n"
  docker rm "$IMAGE"
  docker run --name "$IMAGE" -d -it  \
    --entrypoint /bin/bash \
    "floydcraft/$IMAGE:$IMAGE_TAG"
#  docker exec -it "$IMAGE" /bin/bash
fi


#  docker container rm "$IMAGE"
#  cardano-node run --config "/config/$CARDANO_NETWORK/config.json" \
#  --topology "/config/topology.json" \
#  --database-path "/storage/$CARDANO_NETWORK/db" \
#  --host-addr "0.0.0.0" \
#  --port 3001 \
#  --socket-path "/storage/$CARDANO_NETWORK/node.socket"
#  docker run --name "$IMAGE" -it \
#    -v "$PWD/storage/$CARDANO_NETWORK:/storage" \
#    --env "CARDANO_NETWORK=$CARDANO_NETWORK" \
#    --env "CARDANO_NODE_SOCKET_PATH=/storage/$CARDANO_NETWORK/node.socket" \
#    --entrypoint bash "floydcraft/$IMAGE:latest"
