resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket      = var.upload_bucket_name
  eventbridge = true
}