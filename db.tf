# # Create a subnet group for MySQL RDS instances
# resource "aws_db_subnet_group" "mysql_subnet_group" {
#   name        = "mysql-subnet-group"                   # Name for the subnet group
#   description = "Subnet group for MySQL RDS instances" # Description

#   # Specify the subnet IDs to include in the subnet group
#   subnet_ids = [aws_subnet.data_subnet.id]
# }

# # Create an AWS RDS MySQL instance in the specified subnet
# resource "aws_db_instance" "mysql_instance" {
#   allocated_storage   = 20            # Allocated storage for the database
#   storage_type        = "gp2"         # Storage type (General Purpose SSD)
#   engine              = "mysql"       # Database engine (MySQL)
#   engine_version      = "5.7"         # MySQL version
#   instance_class      = "db.t2.micro" # Instance type
#   username            = "db_user"     # Database username
#   password            = "db_password" # Database password
#   skip_final_snapshot = true          # Skip taking a final snapshot when deleting

#   # Specify the security group for the RDS instance (replace with your security group ID)
#   vpc_security_group_ids = [aws_security_group.allow_tls.id]

#   # Specify the subnet group for the RDS instance
#   db_subnet_group_name = aws_db_subnet_group.mysql_subnet_group.name
# }

# # Define an output to retrieve the MySQL RDS endpoint
# output "mysql_endpoint" {
#   value = aws_db_instance.mysql_instance.endpoint
# }