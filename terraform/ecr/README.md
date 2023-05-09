# Testing Sysdig Secure Cloud Connector

Two services have been enabled for container scanning ECS and ECR.

## How to test ECR scanning is being performed

### Login to ECR

```sh
export aws_account_id=
export region=

aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${aws_account_id}.dkr.ecr.${region}.amazonaws.com
```

### Pull down a container and publish it to ECR

```sh
export aws_account_id=
export region=
export image_id=
export image_name=node
export image_tag=20-bullseye-slim

docker pull ${image_name}:${image_tag}
docker tag ${image_id} ${aws_account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:${image_tag}
docker push ${aws_account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:${image_tag}
```