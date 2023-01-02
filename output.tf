########################
###    print dns    ###
########################

output "public_ipv4_address" {
  value = aws_elb.elb.dns_name
}
