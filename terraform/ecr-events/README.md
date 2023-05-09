# Verify EventBridge Rule for ECR events

This project is a simple eventbridge rule which filters events with a source of `aws.ecr` Elastic Container Repository (ECR).

## Dependencies

- Terraform v1.4.4
- aws-cli 2.11.15
- git 2.39.2

## How to build the project

```sh
# Setup AWS env vars<>
export AWS_ACCESS_KEY_ID={aws-access-key}
export AWS_SECRET_ACCESS_KEY={aws-secret-key}
export AWS_DEFAULT_REGION={aws-region}

cd terraform/ecr-events
terraform init

terraform apply
```

## How to destroy the project

```sh
cd terraform/ecr-events
terraform destroy
```

## How to create an event and verify it is published to SQS

```sh
# Setup AWS env vars<>
export AWS_ACCESS_KEY_ID={aws-access-key}
export AWS_SECRET_ACCESS_KEY={aws-secret-key}
export AWS_DEFAULT_REGION={aws-region}

export aws_account_id=
export region=
export image_id=
export image_name=node
export image_tag=20-bullseye-slim

docker pull ${image_name}:${image_tag}
docker tag ${image_id} ${aws_account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:${image_tag}
docker push ${aws_account_id}.dkr.ecr.${region}.amazonaws.com/${image_name}:${image_tag}

aws sqs receive-message --queue-url https://sqs.${region}.amazonaws.com/${aws_account_id}/${queue-name} --output json
```
