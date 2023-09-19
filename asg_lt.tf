# Create a launch configuration
resource "aws_launch_configuration" "wp_lt" {
  name_prefix     = "wp-lt"
  image_id        = "ami-028eb925545f314d6" # Replace with your desired AMI
  instance_type   = "t2.micro"              # Replace with your desired instance type
  key_name        = "wordpress-project-key-pair-tf"
  associate_public_ip_address = true
  security_groups = [aws_security_group.allow_tls.id] # Replace with your SG ID

  user_data = <<-EOF
    #!/bin/bash

    sudo yum install httpd php php-mysqlnd php-json wget -y
    sudo wget https://wordpress.org/latest.tar.gz
    tar -xzvf latest.tar.gz
    sudo mv wordpress/* /var/www/html/
    sudo chown -R apache.apache /var/www/html
    sudo setenforce 0
    sudo systemctl start httpd

    # Install MySQL client
    sudo yum install mysql -y

    # Connect to the MySQL RDS instance and perform database operations
    mysql_endpoint="${aws_db_instance.mysql_instance.endpoint}"
    mysql_user="admin"
    mysql_password="admin246!"

    # Create a database
    mysql -h "$mysql_endpoint" -u "$mysql_user" -p "$mysql_password" -e "CREATE DATABASE wordpress;"

    EOL
    EOF
}

