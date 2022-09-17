resource "aws_db_subnet_group" "terraform-db-subnet" {
  name        = var.db_subnet_group_name
  subnet_ids  = var.db_subnet_group_ids
  description = var.db_subnet_group_description

  tags = {
    Name = var.db_subnet_group_name
  }
}

# EC2からの通信を許可するためのRDS用のセキュリティグループ
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
    Name = "${var.Tag_Name}-ec2-to-db"
  }
}

resource "aws_rds_cluster_parameter_group" "terraform-aurora-cluster-parameter" {
  name        = var.aurora_cluster_parameter_group_name
  family      = "aurora-mysql5.7"
  description = "RDS terraform aurora cluster parameter group"
}
resource "aws_db_parameter_group" "terraform-aurora-instance-parameter-group" {
  name        = var.aurora_instance_parameter_group_name
  family      = "aurora-mysql5.7"
  description = "RDS terraform aurora instance parameter group"
}

# RDSの暗号化キーをマネージドキーから取得する
data "aws_kms_key" "rds" {
  key_id = "alias/aws/rds"
}

resource "aws_rds_cluster" "terraform-aurora-cluster" {
  cluster_identifier     = var.db_cluster_name
  engine                 = "aurora-mysql"
  db_subnet_group_name   = aws_db_subnet_group.terraform-db-subnet.name
  snapshot_identifier    = "terraform-staging-snapshot"
  skip_final_snapshot    = true
  engine_mode            = "provisioned"
  vpc_security_group_ids = [aws_security_group.terraform-ec2-to-db.id]
  kms_key_id = data.aws_kms_key.rds.arn
  enabled_cloudwatch_logs_exports = [
    "error",
    "general",
    "slowquery"
  ]
}
resource "aws_rds_cluster_instance" "terraform-aurora-cluster-instance" {
  identifier           = "${var.db_cluster_name}-instance"
  cluster_identifier   = aws_rds_cluster.terraform-aurora-cluster.id
  instance_class       = var.db_cluster_instance
  db_subnet_group_name = aws_db_subnet_group.terraform-db-subnet.name
  engine               = aws_rds_cluster.terraform-aurora-cluster.engine
  monitoring_interval  = 60
  monitoring_role_arn  = aws_iam_role.terraform-iam-role-rds-monitoring.arn
}

##########################################################################
# RDSがCloudWatchへログを送るためのIAMロールを付与
data "aws_iam_policy" "AmazonRDSEnhancedMonitoringRole" {
  name = "AmazonRDSEnhancedMonitoringRole"
}
resource "aws_iam_role" "terraform-iam-role-rds-monitoring" {
  name = "${var.Tag_Name}-rds-monitoring"
  path = "/"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "monitoring.rds.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "terraform-iam-role-attachment-rds-monitoring" {
  role       = aws_iam_role.terraform-iam-role-rds-monitoring.name
  policy_arn = data.aws_iam_policy.AmazonRDSEnhancedMonitoringRole.arn
}
##########################################################################