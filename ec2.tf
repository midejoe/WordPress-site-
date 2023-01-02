
######################
###    AZ          ###
######################

data "aws_availability_zones" "available_zones" {}


resource "aws_instance" "db_instance" {
  #  ami                    = data.aws_ami.amazon_linux_2.id
  ami                    = "ami-052efd3df9dad4825"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.db_az2.id
  vpc_security_group_ids = ["${aws_security_group.db_security_group.id}"]
  key_name               = "new"
  user_data              = file("install-mysql.sh")

  tags = {
    Name = "db server"
  }
}





