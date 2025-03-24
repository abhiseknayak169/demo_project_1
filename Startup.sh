sudo yum update -y

sudo amazon-linux-extras install docker -y

sudo service docker start

sudo usermod -a -G docker ec2-user

sudo yum install -y ruby wget

cd /home/ec2-user

wget https://aws-codedeploy-us-west-2.s3.amazonaws.com/latest/install

chmod +x ./install

sudo ./install auto

sudo service codedeploy-agent start

sudo service codedeploy-agent status