resource "aws_internet_gateway" "mihai-igw" {
  vpc_id = aws_vpc.mihai-vpc.id

  tags = {
    Name = "mihai-igw"
  }
}