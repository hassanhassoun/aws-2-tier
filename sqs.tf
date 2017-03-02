resource "aws_sqs_queue" "dead-queue" {
  name = "dead-work-q"
  delay_seconds = 90
  max_message_size = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

resource "aws_sqs_queue" "queue" {
  name = "work-q"
  delay_seconds = 90
  max_message_size = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.dead-queue.arn}\",\"maxReceiveCount\":4}"
}
