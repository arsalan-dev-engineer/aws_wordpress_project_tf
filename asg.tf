# Create a launch configuration
resource "aws_launch_configuration" "wp_lc" {
  image_id      = "ami-028eb925545f314d6" # Replace with your desired AMI
  instance_type = "t2.micro"               # Replace with your desired instance type
  key_name                    = "wordpress-project-key-pair-tf"
  associate_public_ip_address = true
  security_groups = [aws_security_group.allow_tls.id] # Replace with your SG ID
}

# Create an Auto Scaling Group
resource "aws_autoscaling_group" "wp_asg" {
  name                      = "wordpress-asg"
  launch_configuration      = aws_launch_configuration.wp_lc.name
  min_size                  = 1
  max_size                  = 3
  desired_capacity          = 2
  vpc_zone_identifier       = [aws_subnet.public_subnet_2a.id, aws_subnet.public_subnet_2b.id] # Replace with your subnet IDs
  target_group_arns         = [aws_lb_target_group.alb_tg.arn] # Attach ASG to the target group
  health_check_type         = "ELB" # Use "EC2" for EC2 instances
  health_check_grace_period = 300  # Adjust as needed
  force_delete              = true # To delete instances immediately when scaled in
}

