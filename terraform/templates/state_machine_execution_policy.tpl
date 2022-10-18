{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": 
        "states:StartExecution",
      "Effect": 
        "Allow",
      "Resource": [          
        "${video_state_machine}",
        "${image_state_machine}"
      ]
    }
  ]
}