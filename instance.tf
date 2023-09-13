resource "aws_instance" "wp_instance_2a_1" {
  ami                         = "ami-028eb925545f314d6"
  instance_type               = "t2.micro"
  key_name                    = "wordpress-project-key-pair-tf"
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  subnet_id                   = aws_subnet.public_subnet_2a.id

  # provisioner "remote-exec" {
  #   connection {
  #     # Update with the appropriate SSH user for your AMI
  #     type = "ssh"
  #     user = "ec2-user"
      
  #     # Update with the path to your private key
  #     private_key = file("D:/Programming/DevOps/Martins-project/wordpress-project-key-pair-tf.pem")
      
  #     # Use "self.public_ip" if the instance has a public IP
  #     host = self.public_ip
  #   }

  #   inline = [
  #     "sudo yum install httpd php php-mysqlnd php-json wget -y",
  #     "sudo wget https://wordpress.org/latest.tar.gz",
  #     "tar -xzvf latest.tar.gz",
  #     "sudo mv wordpress/* /var/www/html/",
  #     "sudo chown -R apache.apache /var/www/html",
  #     "sudo setenforce 0",
  #     "sudo systemctl start httpd"
  #   ]
  # }
}

resource "aws_instance" "wp_instance_2b_1" {
  ami                         = "ami-028eb925545f314d6"
  instance_type               = "t2.micro"
  key_name                    = "wordpress-project-key-pair-tf"
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  subnet_id                   = aws_subnet.public_subnet_2b.id

}