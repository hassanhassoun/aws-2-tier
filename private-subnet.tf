/* Private subnet */
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "${var.region}a"
  map_public_ip_on_launch = false
  #Will add NAT once Internet access from the private subnet is required
  #depends_on = Add NAT id here
  tags { 
    Name = "private" 
  }
}
