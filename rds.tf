# # Create a subnet group for MySQL RDS instances
# resource "aws_db_subnet_group" "mysql_subnet_group" {
#   name        = "mysql-subnet-group"
#   description = "Subnet group for MySQL RDS instances"
#   subnet_ids = [
#     aws_subnet.private_subnet_2a.id,
#   aws_subnet.private_subnet_2b.id]
# }

# # Create an AWS RDS MySQL instance in the specified subnet
# resource "aws_db_instance" "mysql_instance" {
#   identifier          = "wordpress-database"
#   allocated_storage   = 10            # Allocated storage for the database
#   storage_type        = "gp2"         # Storage type (General Purpose SSD)
#   engine              = "mysql"       # Database engine (MySQL)
#   engine_version      = "5.7"         # MySQL version
#   instance_class      = "db.t2.micro" # Instance type
#   username            = "admin"       # Database username
#   password            = "admin246!"   # Database password
#   publicly_accessible = true
#   skip_final_snapshot = true # Skip taking a final snapshot when deleting

#   # Specify the security group for the RDS instance (replace with your security group ID)
#   vpc_security_group_ids = [aws_security_group.allow_tls.id]

#   # Specify the subnet group for the RDS instance
#   db_subnet_group_name = aws_db_subnet_group.mysql_subnet_group.name
# }

