#!/bin/bash
set -e
set -x

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

BUCKET_NAME="ecs-project-terraform-state-0"
DYNAMODB_TABLE="ecs-project-terraform-locks"
REGION="eu-west-2"

log "Starting bootstrap"


log "Creating S3 bucket"
if aws s3api head-bucket --bucket $BUCKET_NAME 2>/dev/null; then
    log "Bucket already exists, skipping"
else
    aws s3api create-bucket \
      --bucket $BUCKET_NAME \
      --region $REGION \
      --create-bucket-configuration LocationConstraint=$REGION

    log "Enabling versioning"
aws s3api put-bucket-versioning \
  --bucket $BUCKET_NAME \
  --versioning-configuration Status=Enabled

  log "Enabling encryption"
aws s3api put-bucket-encryption \
  --bucket $BUCKET_NAME \
  --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
fi



if aws dynamodb describe-table --table-name $DYNAMODB_TABLE --region $REGION > /dev/null 2>&1; then
    log "DynamoDB table already exists, skipping"
else
    aws dynamodb create-table \
      --table-name $DYNAMODB_TABLE \
      --attribute-definitions AttributeName=LockID,AttributeType=S \
      --key-schema AttributeName=LockID,KeyType=HASH \
      --billing-mode PAY_PER_REQUEST \
      --region $REGION
fi

log "Bootstrap complete"