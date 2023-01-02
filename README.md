# WordPress-site-
Create Existing Infrastructure Using Terraform

Our goal is to use Terraform to provision resources on AWS that execute MySQL queries on database-server and process and display data on application-server.

I have written a wiki to explain how it can be achieved. Check it out here.

You can also follow the steps below to 

* Install terraform onto your machine
* Start by creating the infra resources like VPC, Subnets, Internet Gateway, Nat gateway, Route Tables, etc, 
* Launch Database server by creating EC2 server and WordPress server through launch configuration and add it to an autoscaling group
* After all that create an Application load balancer and configure the proper health check for it
* You can either do step by step and apply the changes in one-go
