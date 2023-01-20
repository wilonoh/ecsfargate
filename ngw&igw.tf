# nat gateway
resource "aws_nat_gateway" "e-learning-ngw" {
  allocation_id = aws_eip.e-learning-eip.id
  subnet_id     = aws_subnet.e-learning-pub-sub1.id
  tags = {
    Name        = "gw NAT-${terraform.workspace}"
  }
   depends_on   = [aws_internet_gateway.e-learning-igw]
}

# eip
resource "aws_eip" "e-learning-eip" {
  vpc      = true
}

resource "aws_internet_gateway" "e-learning-igw" {
  vpc_id = aws_vpc.e-learning.id
  tags   = {
    Name = "e-learning-igw-${terraform.workspace}"  # i changed the Name from main to e-learning-igw
  }
}