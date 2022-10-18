resource "aws_cloudwatch_log_group" "content_type_check_lambda_lg" {
  name = "/aws/lambda/${var.prefix_name}-content-type-check-lambda-lg"
}