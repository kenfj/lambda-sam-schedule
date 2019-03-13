variable "app_name" {
  default     = "lambda_schedule_test"
  description = "the app name"
}

variable "cloudwatch_schedule" {
  default     = "rate(5 minutes)"
  description = "CloudWatch Events Schedule expression"
}
