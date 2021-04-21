#Launchtemplate
resource "aws_launch_template" "ec2-temp" {
  name = var.ec2-temp
  image_id = var.ami_id
  instance_type = var.instance_type
  disable_api_termination = false
  key_name = var.key_name
  #vpc_security_group_ids = var.sg_id
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.sg_id
  }
}


#Autoscaling group
resource "aws_autoscaling_group" "asg" {
  name               = var.asg
  min_size           = 1
  max_size           = 3
  vpc_zone_identifier = var.subnet_id
  target_group_arns = [aws_alb_target_group.lbtg.arn]

  launch_template {
    id      = aws_launch_template.ec2-temp.id
  }
}

#Applicationloadbalancer
resource "aws_lb" "tfelb" {
  name               = var.elb
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_id
  subnets            = var.subnet_id

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}


#Creating target group for alb
resource "aws_alb_target_group" "lbtg" {
  name     = var.target-group
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = var.vpc_id
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 1800
    enabled         = true
  }
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    port                = 80
  }
}


#listener rule
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.tfelb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.lbtg.arn
  }
}

resource "aws_autoscaling_attachment" "alb_autoscale" {
  alb_target_group_arn   = aws_alb_target_group.lbtg.arn
  autoscaling_group_name = aws_autoscaling_group.asg.id
}
