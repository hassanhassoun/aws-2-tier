/* Default security group */
resource "aws_security_group" "default" {
  name = "internal"
  description = "Default security group to allow internal VPC traffic"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "internal-traffic"
  }
}

/* Security group for my IP address */
resource "aws_security_group" "myaccess" {
  name = "myaccess"
  description = "Security group to allow unrestricted access from My IP address"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["${var.myip}/32"]
  }

  tags { 
    Name = "open-access"
  }
}
