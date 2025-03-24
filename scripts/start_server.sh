#!/bin/bash
set -e

# Define variables: update these with your actual values or set them as environment variables
AWS_REGION="us-east-1"
ACCOUNT_ID="047719639376"
REPOSITORY_NAME="enterprise-mlops-app"
CONTAINER_NAME="enterprise_mlops_app"
IMAGE_TAG="latest"  # You can update this or pass it as an argument if needed

# Construct the full ECR image URI
ECR_REPO_URI="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:$IMAGE_TAG"

# Log in to Amazon ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Pull the latest image from ECR
echo "Pulling image $ECR_REPO_URI..."
docker pull $ECR_REPO_URI

# Check if container exists and remove it if necessary
if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing existing container named '$CONTAINER_NAME'..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

# Run the container with the specified name and map port 8002
echo "Starting container $CONTAINER_NAME from image $ECR_REPO_URI..."
docker run -d --name $CONTAINER_NAME -p 8002:8002 $ECR_REPO_URI