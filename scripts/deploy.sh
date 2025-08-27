#!/bin/bash
# deploy.sh - Terraform deploy script with environment support

set -e  # Exit if any command fails

if [ -z "$1" ]; then
  echo "Usage: $0 <environment>"
  echo "Example: $0 dev"
  exit 1
fi

ENV="$1"

# Load variables from tfvars
TFVARS_FILE="./env/${ENV}.tfvars"
if [ ! -f "$TFVARS_FILE" ]; then
  echo "Error: tfvars file '$TFVARS_FILE' not found."
  exit 1
fi

# Extract backend variables from tfvars
BACKEND_RG=$(grep '^backend_rg_name' "$TFVARS_FILE" | awk -F'=' '{print $2}' | tr -d ' "')
BACKEND_SA=$(grep '^backend_storage_account_name' "$TFVARS_FILE" | awk -F'=' '{print $2}' | tr -d ' "')
BACKEND_CONTAINER=$(grep '^backend_container_name' "$TFVARS_FILE" | awk -F'=' '{print $2}' | tr -d ' "')

# Initialize Terraform with backend config
terraform init \
  -backend-config="resource_group_name=${BACKEND_RG}" \
  -backend-config="storage_account_name=${BACKEND_SA}" \
  -backend-config="container_name=${BACKEND_CONTAINER}" \
  -backend-config="key=${ENV}-terraform.tfstate" -reconfigure

# Apply Terraform with the chosen environment
terraform apply -var-file="${TFVARS_FILE}"