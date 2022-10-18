
resource "aws_iam_role" "content_type_check_lambda_role" {
  name               = "${var.prefix_name}-content-type-check-lambda-role"
  assume_role_policy = file("${path.module}/templates/lambda_sts_policy.tpl")
}

resource "aws_iam_role_policy_attachment" "content_type_check_lambda_basic_policy_attachment" {
  role       = aws_iam_role.content_type_check_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_iam_role_policy" "content_type_check_lambda_state_machine_execution_policy" {
  name   = "${var.prefix_name}-state-machine-execution-policy"
  role   = aws_iam_role.content_type_check_lambda_role.id
  policy = templatefile("${path.module}/templates/state_machine_execution_policy.tpl", { image_state_machine = var.image_state_machine, video_state_machine = var.video_state_machine })
}


resource "aws_iam_role_policy" "content_type_check_lambda_s3_read_policy" {
  name   = "${var.prefix_name}-s3-read-policy"
  role   = aws_iam_role.content_type_check_lambda_role.id
  policy = templatefile("${path.module}/templates/s3_read_policy.tpl", { bucket = var.upload_bucket_name })
}