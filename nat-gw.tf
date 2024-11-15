resource "aws_nat_gateway" "mihai-nat-gw" {
  allocation_id = aws_eip.mihai-eip.id
  subnet_id     = aws_subnet.mihai-public-subnet[0].id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.mihai-igw]
}