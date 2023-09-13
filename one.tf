# # Define a security group for the ALB
# resource "aws_security_group" "alb_sg" {
#   name        = "alb-sg"
#   description = "Security group for the ALB"
  
#   # Define inbound rules to allow HTTP (80) and HTTPS (443) traffic
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
  
#   ingress {
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # Create an Application Load Balancer (ALB)
# resource "aws_lb" "example_alb" {
#   name               = "example-alb"
#   internal           = false
#   load_balancer_type = "application"
  
#   enable_deletion_protection = false  # Enable or disable deletion protection
  
#   subnets            = [aws_subnet.public_subnet-1a.id, aws_subnet.public_subnet-1b.id]
#   security_groups    = [aws_security_group.alb_sg.id]
# }

# # Create a launch template for the Auto Scaling Group (ASG)
# resource "aws_launch_template" "example_lt" {
#   name_prefix = "example-lt-"
  
#   # Define the instance settings, such as AMI, instance type, and security groups
#   instance_type          = "t2.micro"
#   key_name               = "your-key-pair"
#   security_group_names   = [aws_security_group.allow_tls.name]  # Replace with your security group name
#   iam_instance_profile   = "your-iam-instance-profile"
  
#   # User data script for instances
#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello, World!" > /var/www/html/index.html
#               EOF
# }

# # Create an ALB target group
# resource "aws_lb_target_group" "example_target_group" {
#   name        = "example-target-group"
#   port        = 80
#   protocol    = "HTTP"
#   target_type = "instance"
#   vpc_id      = aws_vpc.main-wp-vpc.id
# }

# # Create an Auto Scaling Group (ASG) with the launch template
# resource "aws_autoscaling_group" "example_asg" {
#   name_prefix           = "example-asg-"
#   max_size              = 3
#   min_size              = 1
#   desired_capacity      = 2
#   launch_template {
#     id      = aws_launch_template.example_lt.id
#     version = "$Latest"  # Use the latest version of the launch template
#   }
#   vpc_zone_identifier   = [aws_subnet.private_subnet-1a.id, aws_subnet.private_subnet-1b.id]
#   target_group_arns     = [aws_lb_target_group.example_target_group.arn]
# }
