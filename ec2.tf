resource "aws_instance" "web" {
  ami           = "ami-01eb696891a3b3bcf"
  instance_type = "t2.micro"
  key_name = "mihai-key"
  subnet_id = aws_subnet.mihai-public-subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  associate_public_ip_address = true
  count = 2

  tags = {
    Name = "WebServer"
  }

  provisioner "file" {
    source = "./mihai-key.pem"
    destination = "/home/ec2-user/mihai-key.pem"
  
    connection {
      type = "ssh"
      host = self.public_ip
      user = "ec2-user"
      private_key = "${file("./mihai-key.pem")}"
    }  
  }
}

resource "aws_instance" "db" {
  ami           = "ami-01eb696891a3b3bcf"
  instance_type = "t2.micro"
  key_name = "mihai-key"
  subnet_id = aws_subnet.mihai-private-subnet.id
  vpc_security_group_ids = [aws_security_group.allow_tls_db.id]

  tags = {
    Name = "DB Server"
  }
}