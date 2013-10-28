#!/bin/bash

set -e

mkdir ./log

echo "Caught deploy" >> log/deploy.log

rev=$(git rev-parse HEAD)

serf event deploy-web:$rev >> log/deploy.log 2>&1
