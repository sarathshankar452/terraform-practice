
# 1. Create VPC
resource "aws_vpc" "shankar_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "shankar_vpc"
  }
}

# 2. Create Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.shankar_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

# 3. Create Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.shankar_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet"
  }
}

# 4. Create Internet Gateway
resource "aws_internet_gateway" "sara_igw" {
  vpc_id = aws_vpc.shankar_vpc.id

  tags = {
    Name = "sara_igw"
  }
}

# 5. Create Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.shankar_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sara_igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

# 6. Associate Public Route Table
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# 7. Allocate Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat_eip"
  }
}

# 8. Create NAT Gateway in Public Subnet
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "sara_nat_gateway"
  }

  depends_on = [aws_internet_gateway.sara_igw]
}

# 9. Create Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.shankar_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private_rt"
  }
}

# 10. Associate Private Route Table
resource "aws_route_table_association" "private_rta" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# 11. Security Group for Public EC2
resource "aws_security_group" "public_sg" {
  name        = "public-security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.shankar_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.36.120.50/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_sg"
  }
}

# 12. Security Group for Private EC2
resource "aws_security_group" "private_sg" {
  name        = "private-security-group"
  description = "Allow SSH from public security group"
  vpc_id      = aws_vpc.shankar_vpc.id

  ingress {
    description     = "SSH from public EC2"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_sg"
  }
}
