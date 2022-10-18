variable "prefix_name" {
  type        = string
  description = "String to prefix to resources names"
}

variable "image_state_machine" {
  type        = string
  description = "State machine to send image Rekognition processing requests to"
}

variable "video_state_machine" {
  type        = string
  description = "State machine to send video Rekognition processing requests to"
}

variable "upload_bucket_name" {
  type        = string
  description = "Name of S3 bucket Rekognition should read files from"
}
