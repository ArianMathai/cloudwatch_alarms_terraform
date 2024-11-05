output "alarm_arn" {
  value = aws_sns_topic.user_updates.arn
}

output "account_over_2m_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.account_count_over_2m.arn
}