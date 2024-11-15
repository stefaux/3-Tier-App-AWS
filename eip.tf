resource "aws_eip" "mihai-eip" {
  //instance = aws_instance.web.id
  vpc      = true
}