resource "aws_sqs_queue" "queue" {
  name = "${var.name}-queue"
}

resource "aws_sqs_queue" "dlq" {
  name = "${var.name}-dlq"
}

resource "aws_sqs_queue_policy" "queue" {
  queue_url = aws_sqs_queue.queue.id
  policy    = data.aws_iam_policy_document.queue.json
}

data "aws_iam_policy_document" "queue" {
  statement {
    sid     = "${var.name}-events-policy"
    actions = ["sqs:SendMessage"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [
      aws_sqs_queue.queue.arn,
      aws_sqs_queue.dlq.arn
    ]
  }
}
