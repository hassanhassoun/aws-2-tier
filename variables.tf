variable "access_key" { 
  description = "AWS access key"
}

variable "secret_key" { 
  description = "AWS secret access key"
}

variable "pubkey"     { 
  description = "Path to public key used to launch EC2 instances"
  default     = "~/.ssh/id_rsa.pub"
}

variable "region"     { 
  default     = "ca-central-1" 
}

variable "myip"     { 
  description = "Replace with your public IP address"
  default     = "192.168.0.10"
}

variable "vpc_name" {
  description = "VPC name to launch environment"
  default     = "beanstalk"
}

variable "app_name" {
  description = "Name of Elastic Bean Application"
  default     = "appname"
}

variable "environment"     { 
  default     = "dev" 
}

variable "client_name"     { 
  default     = "clientname" 
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "172.40.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "172.40.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "172.40.2.0/24"
}

variable "stackname" {
  description = "ebeanstalk stack name"
  default     = "64bit Amazon Linux 2016.09 v2.3.1 running Ruby 2.3 (Puma)"
}
