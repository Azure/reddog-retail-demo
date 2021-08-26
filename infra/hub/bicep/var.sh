#! /bin/bash

# Set Variables
export ARM_DEPLOYMENT_NAME="reddogbicep"
export SUBSCRIPTION_ID="$(cat config.json | jq -r '.subscription_id')"
export TENANT_ID="$(cat config.json | jq -r '.tenant_id')"

export PREFIX="$(cat config.json | jq -r '.rgNamePrefix')"

export ADMIN_USER_NAME="$(cat config.json | jq -r '.admin_user_name')"

export SSH_KEY_PATH="./ssh_keys"
export SSH_KEY_NAME=$PREFIX"_id_rsa"

export SQL_ADMIN_USER_NAME="$(cat config.json | jq -r '.sql_admin_user_name')"
export SQL_ADMIN_PASSWD="$(cat config.json | jq -r '.sql_admin_passwd')"

export HUBNAME="$(cat infra.json|jq -r '.hub.hubName')"

export RG_LOCATION="$(cat infra.json|jq -r '.hub.location')"
export RG_NAME=reddog-$PREFIX-$HUBNAME-$RG_LOCATION

#Generate ssh-key pair
echo "Creating ssh key directory..."
mkdir $SSH_KEY_PATH

echo "Generating ssh key..."
ssh-keygen -f $SSH_KEY_PATH/$SSH_KEY_NAME -N ''
chmod 400 $SSH_KEY_PATH/$SSH_KEY_NAME
export SSH_PRIV_KEY="$(cat $SSH_KEY_PATH/$SSH_KEY_NAME)"
export SSH_PUB_KEY="$(cat $SSH_KEY_PATH/$SSH_KEY_NAME.pub)"

# Get the current user Object ID
export CURRENT_USER_ID=$(az ad signed-in-user show -o json | jq -r .objectId)

# Set the Subscriptoin
az account set --subscription $SUBSCRIPTION_ID

