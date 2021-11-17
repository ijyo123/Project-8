#Create VPC
resource "aws_vpc" "project8VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "project8VPC"
  }
}
#Create Public Subnet1
resource "aws_subnet" "project8-publicsubnet1" {
  vpc_id     = aws_vpc.project8VPC.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch= true

  tags = {
    Name = "project8-publicsubnet1"
  }
}

#Create Public Subnet2
resource "aws_subnet" "project8-publicsubnet2" {
  vpc_id     = aws_vpc.project8VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "project8-publicsubnet2"
  }
}

#Create Private Subnets
resource "aws_subnet" "project8-privatesubnet1" {
  vpc_id     = aws_vpc.project8VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "project8-privatesubnet1"
  }
}

resource "aws_subnet" "project8-privatesubnet2" {
  vpc_id     = aws_vpc.project8VPC.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "project8-privatesubnet2"
  }
}

#Create Route Table for Public Routes
resource "aws_route_table" "project8-publicroutetable" {
  vpc_id = aws_vpc.project8VPC.id


  tags = {
    Name = "project8-publicroutetable"
  }
}

#Create Route Table for Private Routes
resource "aws_route_table" "project8-privateroutetable" {
  vpc_id = aws_vpc.project8VPC.id

  tags = {
    Name = "project8-privateroutetable"
  }
}

#Create RTA for Public Subnet1
resource "aws_route_table_association" "publicp8-rta1" {
  subnet_id      = aws_subnet.project8-publicsubnet1.id
  route_table_id = aws_route_table.project8-publicroutetable.id
}

#Create RTA for Public Subnet2
resource "aws_route_table_association" "publicp8-rta2" {
  subnet_id      = aws_subnet.project8-publicsubnet2.id
  route_table_id = aws_route_table.project8-publicroutetable.id
}

#Create RTA for Private Subnet1
resource "aws_route_table_association" "privatep8-rta1" {
  subnet_id      = aws_subnet.project8-privatesubnet1.id
  route_table_id = aws_route_table.project8-privateroutetable.id
}

#Create RTA for Private Subnet2
resource "aws_route_table_association" "privatep8-rta2" {
  subnet_id      = aws_subnet.project8-privatesubnet2.id
  route_table_id = aws_route_table.project8-privateroutetable.id
}
#Create IGW
resource "aws_internet_gateway" "Project8-igw" {
  vpc_id = aws_vpc.project8VPC.id

  tags = {
    Name = "Project8-igw"
  }
}

#Create Route for IGW
resource "aws_route" "publicp8-igw-route" {
  route_table_id            = aws_route_table.project8-publicroutetable.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                =aws_internet_gateway.Project8-igw.id
}
