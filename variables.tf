variable "region" {
  type    = string
  default = "us-east-1"
}

variable "floci_endpoint" {
  type    = string
  default = "http://localhost:4566"
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "subnet_cidrs" {
  type = list(string)
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_id" {
  type    = string
  default = "ami-12345678"
}

variable "bucket_name" {
  type = string
}
