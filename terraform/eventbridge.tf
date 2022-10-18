resource "aws_cloudwatch_event_rule" "on_s3_upload" {
  name          = "${var.prefix_name}-content-type-check-lambda-rule"
  event_pattern = templatefile("${path.module}/templates/s3_cloudwatch_event.tpl", { bucket = var.upload_bucket_name })
}

resource "aws_cloudwatch_event_target" "lambda_event_target" {
  target_id = "${var.prefix_name}-content-type-check-lambda-target"
  rule      = aws_cloudwatch_event_rule.on_s3_upload.name
  arn       = aws_lambda_function.lambda.arn
}