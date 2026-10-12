resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = { Name = "${var.environment}-vpc" }
}

resource "aws_subnet" "subnets" {
  count      = length(var.subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[count.index]
  tags       = { Name = "${var.environment}-subnet-${count.index + 1}" }
}

resource "aws_instance" "app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnets[0].id
  tags          = { Name = "${var.environment}-ec2" }
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags   = { Environment = var.environment }
}

output "vpc_id"      { value = aws_vpc.main.id }
output "subnet_ids"  { value = aws_subnet.subnets[*].id }
output "instance_id" { value = aws_instance.app.id }
output "bucket"      { value = aws_s3_bucket.bucket.bucket }
