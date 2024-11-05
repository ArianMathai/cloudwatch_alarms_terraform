resource "aws_cloudwatch_metric_alarm" "threshold" {
  alarm_name  = "${var.prefix}-threshold"
  namespace   = var.prefix
  metric_name = "bank_sum.value"

  comparison_operator = "GreaterThanThreshold"
  threshold           = var.threshold
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Maximum"

  alarm_description = "This alarm goes off as soon as the total amount of money in the bank exceeds an amount "
  alarm_actions     = [aws_sns_topic.user_updates.arn]
}

resource "aws_cloudwatch_metric_alarm" "account_count_over_2m" {
  alarm_name          = "${var.prefix}-account_count_over_2m"
  namespace           = var.prefix
  metric_name         = "account_count_over_2m.value"

  comparison_operator = "GreaterThanThreshold"
  threshold           = 0  # Trigger alarm if any account has more than 2,000,000
  evaluation_periods  = "2"
  period              = "60"
  statistic           = "Maximum"

  alarm_description   = "This alarm goes off if any account has more than 2,000,000."
  alarm_actions       = [aws_sns_topic.user_updates.arn]
}

resource "aws_sns_topic" "user_updates" {
  name = "${var.prefix}-alarm-topic"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}


