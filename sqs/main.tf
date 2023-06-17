provider "aws" {
  region = "us-east-2"
}

resource "aws_sqs_queue" "ship_request_dlq" {
  name = "ship_request_dlq"
  max_message_size = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  
}

resource "aws_sqs_queue" "ship_request_q" {
  name = "ship_request_q"
  max_message_size = 2048
  message_retention_seconds = 86400
  visibility_timeout_seconds = 30
  redrive_policy = jsonencode({
    "deadLetterTargetArn" = aws_sqs_queue.ship_request_dlq.arn,
    "maxReceiveCount" = 3
  })
}