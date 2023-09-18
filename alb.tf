resource "aws_lb" "wp-alb" {
  name               = "wordpress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets = [aws_subnet.public_subnet_2a.id,
  aws_subnet.public_subnet_2b.id]

  enable_deletion_protection = false
  
  tags = {
    Environment = "wp-alb"
  }
}
