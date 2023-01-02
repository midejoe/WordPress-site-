# Define the load balancer and attach it to the ASG
resource "aws_elb" "elb" {
  name            = "wordpress-elb"
  security_groups = [aws_security_group.alb_security_group.id]
  subnets         = [aws_subnet.web_az1.id, aws_subnet.db_az2.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/wp-admin/setup-config.php"
    interval            = 30
  }
  tags = {
    key                 = "Name"
    value               = "my-elb"
    propagate_at_launch = true
  }
}
