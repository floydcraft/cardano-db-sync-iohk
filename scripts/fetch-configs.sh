#!/bin/bash
set -e
set -u
set -o pipefail

cd dev/files/config

curl -L -o testnet/db-sync-config.json https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/testnet-db-sync-config.json

curl -L -o mainnet/db-sync-config.json https://hydra.iohk.io/job/Cardano/cardano-node/cardano-deployment/latest-finished/download/1/mainnet-db-sync-config.json