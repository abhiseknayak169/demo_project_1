set -e

#Variables
ECR_REPO_URI = "047719639376.dkr.ecr.us-east-1.amazonaws.com/enterprise-mlops-app:latest"
CONTAINER_NAME = "enterprise-mlops-app"

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 047719639376.dkr.ecr.us-east-1.amazonaws.com

docker pull $ECR_REPO_URI 

if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
fi

docker run -d --name $CONTAINER_NAME -p 8002:8002 $ECR_REPO_URI