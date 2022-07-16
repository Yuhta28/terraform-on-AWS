resource "aws_vpc" "terraform-vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name      = "${var.Tag_Name}-vpc"
    Terraform = "True"
  }
}

resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id
  tags = {
    Name      = "${var.Tag_Name}-igw"
    Terraform = "True"
  }
}

resource "aws_subnet" "terraform-public-subnet" {
  for_each                = var.public-AZ
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = each.value
  availability_zone       = "ap-northeast-1${each.key}"
  map_public_ip_on_launch = true
  tags = {
    Name      = "terraform-${var.Tag_Name}-public-subnet-${each.key}"
    Terraform = "True"
  }
}

resource "aws_subnet" "terraform-private-subnet" {
  for_each          = var.private-AZ
  vpc_id            = aws_vpc.terraform-vpc.id
  cidr_block        = each.value
  availability_zone = "ap-northeast-1${each.key}"
  tags = {
    Name      = "terraform-${var.Tag_Name}-private-subnet-${each.key}"
    Terraform = "True"
  }
}

#resource "aws_eip" "terraform-nat-eip" {
#  for_each = toset(var.eip-NAT-AZ)
#  tags = {
#    Name = "${var.Tag_Name}-eip-${each.key}"
#  }
#  depends_on = [
#    aws_internet_gateway.terraform-igw
#  ]
#}
#
#resource "aws_nat_gateway" "terraform-nat" {
#  for_each  = toset(var.eip-NAT-AZ)
#  subnet_id = aws_subnet.terraform-public-subnet[each.key].id
#  depends_on = [
#    aws_internet_gateway.terraform-igw
#  ]
#  allocation_id = aws_eip.terraform-nat-eip[each.key].id
#  tags = {
#    Name      = "${var.Tag_Name}-nat-${each.key}"
#    Terraform = "True"
#  }
#}
#
resource "aws_route_table" "terraform-public-rt" {
  for_each = var.public-AZ
  vpc_id   = aws_vpc.terraform-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform-igw.id
  }
  tags = {
    Name      = "${var.Tag_Name}-public-rt-${each.key}"
    Terraform = "True"
  }
}

resource "aws_route_table_association" "terraform-public-rt-assoc" {
  for_each       = var.public-AZ
  subnet_id      = aws_subnet.terraform-public-subnet[each.key].id
  route_table_id = aws_route_table.terraform-public-rt[each.key].id
}

resource "aws_route_table" "terraform-private-rt" {
  for_each = var.private-AZ
  vpc_id   = aws_vpc.terraform-vpc.id
#  route {
#    cidr_block = "0.0.0.0/0"
#    nat_gateway_id = aws_nat_gateway.terraform-nat.id
#  }
  tags = {
    Name      = "${var.Tag_Name}-private-rt-${each.key}"
    Terraform = "True"
  }
}

resource "aws_route_table_association" "terraform-private-rt-assoc" {
  for_each       = var.public-AZ
  subnet_id      = aws_subnet.terraform-private-subnet[each.key].id
  route_table_id = aws_route_table.terraform-private-rt[each.key].id
}