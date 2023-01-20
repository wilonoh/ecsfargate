# private subnets
resource "aws_subnet" "e-learning-priv-sub1" {
  vpc_id     = aws_vpc.e-learning.id
  cidr_block = var.e-learning-priv-sub1_cidr_block
availability_zone = var.e-learning-priv-sub1_availability_zone
  tags = {
    Name = "e-learning-priv-sub1-${terraform.workspace}"
  }
}

resource "aws_subnet" "e-learning-priv-sub2" {
  vpc_id     = aws_vpc.e-learning.id
  cidr_block = var.e-learning-priv-sub2_cidr_block
availability_zone = var.e-learning-priv-sub2_availability_zone
  tags = {
    Name = "e-learning-priv-sub2-${terraform.workspace}"
  }
}

# public subnet
resource "aws_subnet" "e-learning-pub-sub1" {
  vpc_id            = aws_vpc.e-learning.id
  cidr_block        = var.e-learning-pub-sub1_cidr_block
  availability_zone = var.e-learning-pub-sub1_availability_zone
  tags = {
    Name            = "e-learning-pub-sub1-${terraform.workspace}"
  }
}

resource "aws_subnet" "e-learning-pub-sub2" {
  vpc_id     = aws_vpc.e-learning.id
  cidr_block = var.e-learning-pub-sub2_cidr_block
  availability_zone = var.e-learning-pub-sub2_availability_zone
  tags = {
    Name = "e-learning-pub-sub2-${terraform.workspace}"
  }
}