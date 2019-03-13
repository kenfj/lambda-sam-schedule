module "lambda-sam-schedule" {
  source              = "../"
  app_name            = "lambda_schedule_test"
  cloudwatch_schedule = "rate(3 minutes)"
}
