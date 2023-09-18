# Create a target group (for ALB or NLB attachment)
resource "aws_lb_target_group" "alb_tg" {
  name     = "wp-target-group"
  port     = 80 # Adjust the port as needed
  protocol = "HTTP"
  vpc_id   = aws_vpc.wp_vpc.id # Replace with your VPC ID
}