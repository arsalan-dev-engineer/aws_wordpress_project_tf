# Create a launch configuration
resource "aws_launch_configuration" "wp_lt" {
  name_prefix     = "wp-lt"
  image_id        = "ami-028eb925545f314d6" # Replace with your desired AMI
  instance_type   = "t2.micro"              # Replace with your desired instance type
  key_name        = "wordpress-project-key-pair-tf"
  security_groups = [aws_security_group.allow_tls.id] # Replace with your SG ID

  user_data = <<-EOF
  #!/bin/bash

  # Update the package list
  sudo apt-get update -y

  # Install Nginx
  sudo apt-get install nginx -y

  # Start the Nginx service
  sudo systemctl start nginx

  # Enable Nginx to start on boot
  sudo systemctl enable nginx

  # Create a simple HTML file
  sudo sh -c 'echo "<html><head><title>Welcome to My Website</title></head><body><h1>Hello from Nginx on EC2!</h1></body></html>" > /var/www/html/index.html'

  # Set the correct permissions for the HTML file
  sudo chown www-data:www-data /var/www/html/index.html

  # Restart Nginx to apply changes
  sudo systemctl restart nginx
  EOF
}

