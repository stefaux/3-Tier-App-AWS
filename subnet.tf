resource "aws_subnet" "mihai-public-subnet" {
  vpc_id     = aws_vpc.mihai-vpc.id
  cidr_block = var.cidr[count.index]
  availability_zone = var.az[count.index]
  count = 2

  tags = {
    Name = "public-sub"
  }
}

resource "aws_subnet" "mihai-private-subnet" {
  vpc_id     = aws_vpc.mihai-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-3a"

  tags = {
    Name = "private-sub3"
  }
}

data "aws_subnets" "sid" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.mihai-vpc.id]
  }

  tags = {
    Tier = "Public"
  }
}