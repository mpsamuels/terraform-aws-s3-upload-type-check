resource "random_uuid" "lambda_src_hash" {
  keepers = {
    for filename in setunion(
      fileset("${path.module}/templates/", "lambda.tpl")
    ) :
    filename => filemd5("${path.module}/templates/${filename}")
  }
}

data "archive_file" "source" {
  type        = "zip"
  output_path = "${path.root}/lambda/content-type-check-app-${random_uuid.lambda_src_hash.result}.zip"
  source {
    content  = templatefile("${path.module}/templates/lambda.tpl", { image_state_machine = var.image_state_machine, video_state_machine = var.video_state_machine, bucket = var.upload_bucket_name, region = data.aws_region.current.name })
    filename = "app.js"
  }
}

resource "aws_lambda_function" "lambda" {
  filename      = "${path.root}/lambda/content-type-check-app-${random_uuid.lambda_src_hash.result}.zip"
  function_name = "${var.prefix_name}-type-check-lambda"
  role          = aws_iam_role.content_type_check_lambda_role.arn
  handler       = "app.handler"
  runtime       = "nodejs16.x"
  depends_on = [
    data.archive_file.source
  ]
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.on_s3_upload.arn
}