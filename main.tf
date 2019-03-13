######################################################################
# Lambda
######################################################################
resource "aws_lambda_function" "main" {
  function_name    = "${var.app_name}"
  filename         = "${data.archive_file.zip.output_path}"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"

  role = "${aws_iam_role.main.arn}"

  handler = "app.lambda_handler"
  runtime = "python3.7"

  environment {
    variables = {
      NAME = "${var.app_name}"
    }
  }
}

data "archive_file" "zip" {
  type        = "zip"
  source_dir  = "${path.module}/sam-app/.aws-sam/build/HelloWorldFunction/"
  output_path = "${var.app_name}.zip"
}

######################################################################
# Lambda IAM
######################################################################
resource "aws_iam_role" "main" {
  name               = "${var.app_name}"
  assume_role_policy = "${data.aws_iam_policy_document.main.json}"
}

data "aws_iam_policy_document" "main" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "logs" {
  role   = "${aws_iam_role.main.id}"
  policy = "${data.aws_iam_policy_document.logs.json}"
}

data "aws_iam_policy_document" "logs" {
  statement {
    actions   = ["logs:*"]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

######################################################################
# CloudWatch Events
######################################################################
resource "aws_cloudwatch_event_rule" "main" {
  name_prefix         = "${var.app_name}"
  schedule_expression = "${var.cloudwatch_schedule}"
}

resource "aws_cloudwatch_event_target" "main" {
  rule  = "${aws_cloudwatch_event_rule.main.name}"
  arn   = "${aws_lambda_function.main.arn}"
  input = "{\"event_input\":\"${var.app_name}\"}"
}

resource "aws_lambda_permission" "main" {
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.main.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.main.arn}"
}
