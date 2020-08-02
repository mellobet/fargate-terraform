# Remote Backend may requiere these IAM permissions:
# read the doc about this regard.


# resource "aws_iam_role" "remote-terraform-state-role" {
#     name = "remote-terraform-state-role"

#     assume_role_policy = <<-EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": "s3:ListBucket",
#             "Resource": "arn:aws:s3:::${var.remote_state_s3_bucket}"
#         },
#         {
#             "Effect": "Allow",
#             "Action": ["s3:GetObject", "s3:PutObject"],
#             "Resource": "arn:aws:s3:::${var.remote_state_s3_bucket}/${var.remote_state_s3_key}"
#         }
#     ]
# }
# EOF
# }