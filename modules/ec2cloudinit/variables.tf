variable "name" {
  default = "Cloudinit"
}

variable "ami" {
  default = "ami-0742b4e673072066f"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "tf-key"
}

variable "subnet_id" {
  default = "subnet-0466781a5c51166b6"
}

variable "sg_id" {
  default = ["sg-0c38ab6c2f50bf34f"]
}
