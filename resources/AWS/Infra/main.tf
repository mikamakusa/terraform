module "vpc" {
  source = "../../../modules/AWS/VPC/vpc"
  tags   = local.vpc_tags
  vpc    = var.vpc
}

module "subnets" {
  source = "../../../modules/AWS/VPC/subnet"
  subnet = var.subnets
  tags   = local.subnet_tags
  vpc_id = module.vpc.vpc_id
}

module "eip" {
  source               = "../../../modules/AWS/EC2/eip"
  eip                  = var.eip
  instance_id          = ""
  network_interface_id = ""
  vpc_id               = module.vpc.vpc_id
}

module "nat_gateway" {
  source      = "../../../modules/AWS/VPC/nat_gateway"
  eip_id      = module.eip.eip_id
  nat_gateway = var.nat_gateway
  subnet_id   = module.subnets.subnet_id
}

module "internet_gateway" {
  source           = "../../../modules/AWS/VPC/internet_gateway"
  internet_gateway = var.internet_gateway
  tags             = local.ig_tags
  vpc_id           = module.vpc.vpc_id
}

module "route_table" {
  source         = "../../../modules/AWS/VPC/route_table"
  gateway_id     = module.internet_gateway.intenet_gateway_id
  nat_gateway_id = module.nat_gateway.nat_gateway_id
  route_table    = var.route_table
  tags           = local.rt_tags
  vpc_id         = module.vpc.vpc_id
}

module "route_table_association" {
  source                  = "../../../modules/AWS/VPC/route_table_association"
  route_table_association = var.route_table_association
  route_table_id          = module.route_table.route_table_id
  subnet_id               = module.subnets.subnet_id
}
