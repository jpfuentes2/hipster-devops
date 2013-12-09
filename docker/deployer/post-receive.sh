#!/usr/bin/env bash

set -e

mkdir -p ./log

rev=$(git rev-parse HEAD)

echo "Caught deploy at $rev" >> log/deploy.log

serf event deploy:web $rev >> log/deploy.log 2>&1
