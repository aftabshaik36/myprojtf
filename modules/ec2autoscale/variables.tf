variable "ami_id" {
  default = "ami-013f17f36f8b1fefb"
}

variable "instance_type" {
  default = "t2.small"
}

variable "public_key_path" {
  default = "../ec2/tf-key.pem"
}

variable "key_name" {
  default = "tf-key"
}

variable "ec2-temp" {
  default = "tf-ec2template"
}

variable "sg_id" {
  default = ["sg-0c38ab6c2f50bf34f"]
}

variable "asg" {
  default = "tf-asg"
}

variable "target-group" {
  default = "albtg"
}

variable "subnet_id" {
  default = ["subnet-0466781a5c51166b6", "subnet-0e7e8a15d3d1d2791"]
}

variable "vpc_id" {
  default = "vpc-0c026c331e6ff4704"
}

variable "elb" {
  default = "appelb"
}
