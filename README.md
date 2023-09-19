# aws WordPress Project using Terraform
main
-----

## Objective:
Deploy a Highly available WordPress website on AWS using public, private, and database subnets to ensure security and scalability.


## Architecture overview:
* Two availability zones (AZs) for redundency and high availability.
* A public subnet in each AZ to host the load balancer and allow public access to the WordPress site.
* A private subnet in each AZ to host the application servers running WordPress.
* A seperate database subnet in each AZ to host the database instances (ec2 with MySQL or AWS managed RDS).

-----

## "Nice to have" features:
* CloudWatch monitoring / Alerting for EC2 (e.g, is the hard drive full, or is the RAM spiking).
* Autoscaling group instead of standalone instance.
* IAM Role for WordPress admins/users.
* SSM access to the instances, instead of direct ssh.

-----

## VPC Resource Map
![Project Architecture](https://github.com/Azzy001/aws_wordpress_project_tf/blob/449edcc8b017017e50a9669a39fe1e69fd216e2b/images/Mini-Project-Architect-Design.drawio.png)

-----

## VPC Resource Map
![Graphviz architecture visualisation](https://github.com/Azzy001/aws_wordpress_project_tf/blob/449edcc8b017017e50a9669a39fe1e69fd216e2b/images/aws-terraform-graphviz.png)

-----

## VPC Resource Map
![vpc resource map](https://github.com/Azzy001/aws_wordpress_project_tf/blob/265fac9964708691a4bd369452c7f9ede83fe089/images/aws-vpc-resource-map.png)
