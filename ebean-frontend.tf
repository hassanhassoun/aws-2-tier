resource "aws_elastic_beanstalk_environment" "frontend" {
  name = "${var.app_name}-front"
  application = "${aws_elastic_beanstalk_application.appname.name}"
  solution_stack_name = "${var.stackname}"
  setting {
    namespace = "aws:ec2:vpc"
    name = "VPCId"
    value = "${aws_vpc.default.id}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "true"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "Subnets"
    value = "${aws_subnet.public.id}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "${aws_iam_role.aws-elasticbeanstalk-ec2-role.name}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "${aws_iam_role.aws-elasticbeanstalk-service-role.name}"
  }

}
