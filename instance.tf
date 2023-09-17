resource "aws_instance" "wp_instance_2a_1" {
  ami                         = "ami-028eb925545f314d6"
  instance_type               = "t2.micro"
  key_name                    = "wordpress-project-key-pair-tf"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  subnet_id                   = aws_subnet.public_subnet_2a.id

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
    mysql -h "${aws_db_instance.mysql_instance.endpoint}" -u admin -p admin246! -e "CREATE DATABASE wordpress;"

    # Debugging
    echo "MySQL Endpoint: ${aws_db_instance.mysql_instance.endpoint}" >> /var/log/user-data.log

    EOF
}

# Output the MySQL RDS endpoint
output "mysql_endpoint" {
  value = aws_db_instance.mysql_instance.endpoint
}
