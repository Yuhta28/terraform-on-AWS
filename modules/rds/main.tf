resource "aws_db_subnet_group" "terraform-db-subnet" {
  name        = var.db_subnet_group_name
  subnet_ids  = var.db_subnet_group_ids
  description = var.db_subnet_group_description

  tags = {
    Name      = var.db_subnet_group_name
    Terraform = "True"
  }
}

resource "aws_security_group" "terraform-ec2-to-db" {
  name        = "${var.Tag_Name}-ec2-to-db"
  description = "Security group for ${var.Tag_Name}-db connected ec2"
  vpc_id      = var.terraform-vpc-id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = var.ec2_to_db_security_groups_id
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name      = "${var.Tag_Name}-ec2-to-db"
    Terraform = "True"
  }
}

#resource "aws_rds_cluster" "terraform-aurora-cluster" {
#  cluster_identifier = var.db_cluster_name
#  engine = "aurora-mysql"
#  db_subnet_group_name = aws_db_subnet_group.terraform-db-subnet.name
#  snapshot_identifier = "terraform-staging-snapshot"
#  skip_final_snapshot  = true
#  vpc_security_group_ids = [aws_security_group.terraform-ec2-to-db.id]
#  tags = {
#    Terraform = "True"
#  }
#}
#
#resource "aws_rds_cluster_instance" "terraform-aurora-cluster-instance" {
#  identifier = "${var.db_cluster_name}-instance"
#  cluster_identifier = aws_rds_cluster.terraform-aurora-cluster.id
#  instance_class = var.db_cluster_instance
#  db_subnet_group_name = aws_db_subnet_group.terraform-db-subnet.name
#  engine = aws_rds_cluster.terraform-aurora-cluster.engine
#  tags = {
#    Terraform = "True"
#  }
#}