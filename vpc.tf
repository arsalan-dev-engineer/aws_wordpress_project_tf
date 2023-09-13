# main vpc
resource "aws_vpc" "wp_vpc" {
  cidr_block = "10.0.0.0/16"
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
resource "aws_route_table_association" "public_route_table_2a_association" {
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
resource "aws_route_table_association" "public_route_table_2b_association" {
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

