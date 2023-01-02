# Create launch configuration for auto scaling group
resource "aws_launch_configuration" "wp" {
  name_prefix = "terraform-lc-"
  #  image_id        = data.aws_ami.amazon_linux_2.id
  image_id                    = "ami-052efd3df9dad4825"
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.ec2_security_group.id}"]
  key_name                    = "new"
  user_data                   = file("install-wordpress.sh")
  associate_public_ip_address = true
  
  lifecycle {
    create_before_destroy = true
  }
}



# Create auto scaling group
resource "aws_autoscaling_group" "wp" {
  launch_configuration      = aws_launch_configuration.wp.name
  vpc_zone_identifier       = ["${aws_subnet.web_az1.id}"]
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 1
  health_check_grace_period = 300

  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "wordpress-server-asg"
    propagate_at_launch = true
  }
}

# Create a new load balancer attachment
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.wp.id
  elb                    = aws_elb.elb.id
}





