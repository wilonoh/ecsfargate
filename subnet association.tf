
resource "aws_route_table_association" "e-learning-priv1-asso" {
  subnet_id      = aws_subnet.e-learning-priv-sub1.id
  route_table_id = aws_route_table.e-learning-priv-rt.id
}

resource "aws_route_table_association" "e-learning-priv2-asso" {
  subnet_id      = aws_subnet.e-learning-priv-sub2.id
  route_table_id = aws_route_table.e-learning-priv-rt.id
}

resource "aws_route_table_association" "e-learning-pub1-asso" {
  subnet_id      = aws_subnet.e-learning-pub-sub1.id
  route_table_id = aws_route_table.e-learning-pub-rt.id
}

resource "aws_route_table_association" "e-learning-pub2-asso" {
  subnet_id      = aws_subnet.e-learning-pub-sub2.id
  route_table_id = aws_route_table.e-learning-pub-rt.id
}





















