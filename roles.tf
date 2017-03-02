resource "aws_iam_role" "aws-elasticbeanstalk-ec2-role" {
    name = "aws-elasticbeanstalk-ec2-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "sqs-ses-ro" {
  name = "sqs-ses-ro"
  description = "Allow SQS send message and SES sendEmail"
  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Sid" : "SesAccess",
       "Effect": "Allow",
       "Action":   [ "ses:SendEmail" ],
       "Resource": [ "*" ]
     },
     {
       "Sid": "QueueAccess",
       "Action": [
         "sqs:SendMessage"
       ],
       "Effect": "Allow",
       "Resource": "*"
     },
     {
       "Sid": "MetricsAccess",
       "Action": [
         "cloudwatch:PutMetricData"
       ],
       "Effect": "Allow",
       "Resource": "*"
     }
   ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2-attach" {
    role = "${aws_iam_role.aws-elasticbeanstalk-ec2-role.name}"
    policy_arn = "${aws_iam_policy.sqs-ses-ro.arn}"
}


resource "aws_iam_role" "aws-elasticbeanstalk-service-role" {
    name = "aws-elasticbeanstalk-service-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
           "sts:ExternalId": "elasticbeanstalk"
        }
      },
      "Principal": {
        "Service": "elasticbeanstalk.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy" "sqs-ses-rw" {
  name = "sqs-ses-rw"
  description = "Allow SQS message processing and SES sendEmail"
  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
    {
      "Sid" : "SesAccess",
      "Effect": "Allow",
      "Action":   [ "ses:SendEmail" ],
      "Resource": [ "*" ]
    },
    {
      "Sid": "QueueAccess",
      "Action": [
        "sqs:ChangeMessageVisibility",
        "sqs:DeleteMessage",
        "sqs:ReceiveMessage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Sid": "MetricsAccess",
      "Action": [
        "cloudwatch:PutMetricData"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "service-attach" {
    role = "${aws_iam_role.aws-elasticbeanstalk-service-role.name}"
    policy_arn = "${aws_iam_policy.sqs-ses-rw.arn}"
}
