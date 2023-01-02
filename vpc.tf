######################
###    default VPC ###
######################


# Create a VPC
resource "aws_vpc" "vpc_1" {
  cidr_block           = "100.0.0.0/16"
  enable_dns_hostnames = true
}

################
##### IGW  #####
################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "Test IGW"
  }
}

#####################
#   NAT Gateway #
#####################

resource "aws_eip" "eip_nat" {
  vpc = true

  tags = {
    Name = "eip1"
  }
}

resource "aws_nat_gateway" "nat_1" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.web_az1.id

  tags = {
    "Name" = "nat1"
  }
}

##########################
###    Route Table  ##
##########################

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

##################################
###    Route table association  ##
#################################

resource "aws_route_table_association" "public-subnet-route-table-association" {
  subnet_id      = aws_subnet.web_az1.id
  route_table_id = aws_route_table.public-route-table.id
}


##########################
###    Route Table      ##
##########################

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_1.id
  }

  tags = {
    Name = "Private Route Table"
  }
}

##############################
#  Route Assoc. for App tier #
##############################
resource "aws_route_table_association" "nat_route_1" {
  subnet_id      = aws_subnet.db_az2.id
  route_table_id = aws_route_table.private-route-table.id
}