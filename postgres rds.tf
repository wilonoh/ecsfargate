
# postgresql db instance
resource "aws_db_instance" "e-learning-postgresql" {
identifier             = var.identifier
allocated_storage      = var.allocated_storage
storage_type           = var.storage_type
engine                 = "postgres"
engine_version         = var.engine_version
instance_class         = var.instance_class
db_name                = var.db_name
port                   = "5432"
username               = var.username
password               = var.password
db_subnet_group_name   = aws_db_subnet_group.db-subnet-group.name
vpc_security_group_ids = [aws_security_group.postgresql-rds-sg.id]
apply_immediately      = var.apply_immediately
skip_final_snapshot    = var.skip_final_snapshot
}



# db subnet group
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.e-learning-priv-sub2.id, aws_subnet.e-learning-priv-sub1.id]

  tags = {
    Name = "db-subnet-group-${terraform.workspace}"
  }
}

resource "aws_security_group" "postgresql-rds-sg" {
  name        = "postgresql-rds-sg"
  description = "Allows traffic only on port 5432 with ecs cluster"
  vpc_id      = aws_vpc.e-learning.id

  ingress {
    description     = "ecs security group to db"
    from_port       = var.db_ingress_from_port
    to_port         = var.db_ingress_to_port
    protocol        = var.db_ingress_protocol
    security_groups = [aws_security_group.e-learning-ecs-sg.id]
    
  }


  egress {
    from_port   = var.db_egress_from_port
    to_port     = var.db_egress_to_port
    protocol    = var.db_egress_protocol
    cidr_blocks = var.db_egress_cidr_block
  }

  tags = {
    Name = "db-instance-sec-group-${terraform.workspace}"
  }
  
}
