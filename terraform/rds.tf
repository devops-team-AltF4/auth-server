# 6-1.  RDS DB subnet group
resource "aws_db_subnet_group" "terraform_db_subnet" {
  name       = "terraform_db_subnet"
  subnet_ids = aws_subnet.private.*.id

  tags = {
    Name = "Dev DB subnet group"
  }
}

# 6-2. RDS 생성
resource "aws_db_instance" "project4-db-dev" {
  identifier           = "project4-db-dev"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.28"
  instance_class       = "db.t2.micro"
  name                 = ""
  username             = "admin"
  password             = "12345678"
  parameter_group_name = "default.mysql8.0"
  availability_zone    = "ap-northeast-2b"
  skip_final_snapshot  = true
  publicly_accessible  = true
  db_subnet_group_name = aws_db_subnet_group.terraform_db_subnet.id
  port = 3306
  vpc_security_group_ids = [aws_security_group.load_balancer_security_group.id]
}