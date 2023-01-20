
resource "aws_route_table" "e-learning-priv-rt" {
  vpc_id = aws_vpc.e-learning.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.e-learning-ngw.id
  }

  tags = {
    Name = "e-learning-priv-rt-${terraform.workspace}"
  }
}


resource "aws_route_table" "e-learning-pub-rt" {
  vpc_id = aws_vpc.e-learning.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.e-learning-igw.id
  }

  tags = {
    Name = "e-learning-pub-rt-${terraform.workspace}"
  }
}