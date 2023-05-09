
module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus = false

  attach_sqs_policy = true
  
  sqs_target_arns = [
    aws_sqs_queue.queue.arn,
    aws_sqs_queue.dlq.arn
  ]

  rules = {
    events = {
      description   = "Capture all created service events",
      event_pattern = jsonencode({ "source" : ["aws.ecr","aws.ecs"] })
    }
  }

  targets = {
    events = [
      {
        name            = "${var.name}-service"
        arn             = aws_sqs_queue.queue.arn
        dead_letter_arn = aws_sqs_queue.dlq.arn
      }
    ]
  }
}