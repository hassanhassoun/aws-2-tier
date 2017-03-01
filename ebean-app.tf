resource "aws_elastic_beanstalk_application" "appname" {
  name = "${var.app_name}"
  description = "${var.app_name}"
}
