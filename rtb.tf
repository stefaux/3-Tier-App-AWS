resource "aws_route_table" "mihai-public-rtb" {
  vpc_id = aws_vpc.mihai-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mihai-igw.id
  }

  tags = {
    Name = "Mihai-Public-RTB"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mihai-public-subnet[count.index].id
  route_table_id = aws_route_table.mihai-public-rtb.id
  count = 2
}
/*
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.rtb.id
}
*/
//Adding NAT Gateway into the default main route table
resource "aws_default_route_table" "dfltrtb" {
  default_route_table_id = aws_vpc.mihai-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mihai-nat-gw.id
  }

  tags = {
    Name = "dfltrtb"
  }
}