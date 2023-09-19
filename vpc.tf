# main vpc
resource "aws_vpc" "wp_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    name = "wordpress vpc"
  }
}

# internet gateway
resource "aws_internet_gateway" "wp_igw" {
  vpc_id = aws_vpc.wp_vpc.id
}

# public route table 
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.wp_vpc.id
  route {
    cidr_block = "0.0.0.0/0" # all IPs will be mapped to this internet gateway
    gateway_id = aws_internet_gateway.wp_igw.id
  }
}

#  AZ 2a ----------

# public subnet in AZ 2a
resource "aws_subnet" "public_subnet_2a" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    name = "Public Subnet 2a"
  }
}

# associate route table to public subnet in az 2a
resource "aws_route_table_association" "public_subnet_2a_association" {
  subnet_id      = aws_subnet.public_subnet_2a.id
  route_table_id = aws_route_table.public_route_table.id
}

# private subnet in AZ 2a
resource "aws_subnet" "private_subnet_2a" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    name = "Private Subnet 2a"
  }
}

# creating an EIP
resource "aws_eip" "eip_2a" {}

# Create a NAT Gateway for private subnet in AZ 2a
resource "aws_nat_gateway" "wp_nat_gtw_2a" {
  allocation_id = aws_eip.eip_2a.id
  subnet_id     = aws_subnet.private_subnet_2a.id
}

# Create a default route in the private subnet's route table pointing to the NAT Gateway in AZ 2a
resource "aws_route" "private_default_route_2a" {
  route_table_id         = aws_route_table.private_route_table_2a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.wp_nat_gtw_2a.id
}

# Route table for private subnet AZ 2a
resource "aws_route_table" "private_route_table_2a" {
  vpc_id = aws_vpc.wp_vpc.id
}

# Associate private route table with private subnet
resource "aws_route_table_association" "private_subnet_2a_association" {
  subnet_id      = aws_subnet.private_subnet_2a.id
  route_table_id = aws_route_table.private_route_table_2a.id
}

# AZ 2b ----------

# public subnet in AZ 2b
resource "aws_subnet" "public_subnet_2b" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    name = "Public Subnet 2b"
  }
}

# associate route table to public subnet in az 2b
resource "aws_route_table_association" "public_subnet_2b_association" {
  subnet_id      = aws_subnet.public_subnet_2b.id
  route_table_id = aws_route_table.public_route_table.id
}

# private subnet in AZ 2b
resource "aws_subnet" "private_subnet_2b" {
  vpc_id            = aws_vpc.wp_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    name = "Private Subnet 2b"
  }
}

# creating an EIP
resource "aws_eip" "eip_2b" {}

# Create a NAT Gateway for private subnet in AZ 2b
resource "aws_nat_gateway" "wp_nat_gtw_2b" {
  allocation_id = aws_eip.eip_2b.id
  subnet_id     = aws_subnet.private_subnet_2b.id
}

# Create a default route in the private subnet's route table pointing to the NAT Gateway in AZ 2b
resource "aws_route" "private_default_route_2b" {
  route_table_id         = aws_route_table.private_route_table_2b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.wp_nat_gtw_2b.id
}

# Route table for private subnet AZ 2b
resource "aws_route_table" "private_route_table_2b" {
  vpc_id = aws_vpc.wp_vpc.id
}

# Associate private route table with private subnet
resource "aws_route_table_association" "private_subnet_2b_association" {
  subnet_id      = aws_subnet.private_subnet_2b.id
  route_table_id = aws_route_table.private_route_table_2b.id
}

