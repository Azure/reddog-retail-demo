#! /bin/bash

## Hub
export HUB_PATH="hub/bicep"
export BICEP_FILE="$HUB_PATH/deploy.bicep"

bash "$HUB_PATH/scripts/run.sh"

## Branch
export BRANCH_PATH="branch/bicep"
export BICEP_FILE="$BRANCH_PATH/deploy.bicep"

bash "$BRANCH_PATH/scripts/run.sh"