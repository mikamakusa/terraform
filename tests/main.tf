module "vpc" {
  source                  = "../modules/AWS/VPC"
  aws_vpc                 = var.aws_vpc
  endpoint                = var.endpoint
  internet_gateway        = var.internet_gateway
  route                   = var.route
  route_table             = var.route_table
  route_table_association = var.route_table_association
  region                  = var.region
  default_sg              = var.default_sg
  eip                     = var.eip
  nat-gw                  = var.nat_gw
  subnet                  = var.subnet
}