######################
###    subnet      ###
######################

resource "aws_subnet" "web_az1" {
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = "100.0.1.0/24"
  map_public_ip_on_launch = true


  tags = {
    Name = "web_subnet"
  }
}

resource "aws_subnet" "db_az2" {
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  vpc_id            = aws_vpc.vpc_1.id
  cidr_block        = "100.0.5.0/24"


  tags = {
    Name = "db_subnet"
  }
}