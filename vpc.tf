resource "aws_vpc" "mihai-vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "Mihai-VPC"
  }
}