variable "vpc-name" {
  default = "demo-vpc"
}

variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "pub-subnet" {
  default = "tf-pubsubnet"
}

variable "pub-cidr" {
  default = "10.0.1.0/24"
}

variable "pub1-subnet" {
  default = "tf-pub1subnet"
}

variable "pub1-cidr" {
  default = "10.0.2.0/24"
}

variable "az1" {
  default = "us-east-1b"
}

variable "az" {
  default = "us-east-1a"
}

variable "internet-gateway" {
  default = "demo-igw"
}

variable "igw-cidr" {
  default = "0.0.0.0/0"
}

variable "pubroute" {
  default = "tf-pubroute"
}

variable "pub1route" {
  default = "tf-pub1route"
}

variable "sg" {
  default = "demo-sg"
}

variable "inbound-cidr" {
  default = ["103.159.249.245/32"]
}

variable "inbound1-cidr" {
  default = ["0.0.0.0/0"]
}

variable "outbound-cidr" {
  default = ["0.0.0.0/0"]
}
