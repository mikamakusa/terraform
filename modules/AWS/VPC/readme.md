# How to use this module ?

## Resources
```hcl-terraform
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
```

## Variables
```hcl-terraform
variable "aws_vpc" {
  type = "list"
}
variable "endpoint" {
  type = "list"
}
variable "internet_gateway" {
  type = "list"
}
variable "route" {
  type = "list"
}
variable "route_table" {
  type = "list"
}
variable "route_table_association" {
  type = "list"
}
variable "region" {
  default = "eu-west-3"
}
variable "default_sg" {
  type = "list"
}

variable "eip" {
  type = "list"
}

variable "nat_gw" {
  type = "list"
}

variable "subnet" {
  type = "list"
}
```

## The variables file
```hcl-terraform
aws_vpc = [
  {
    id                   = "0"
    cidr_block           = "10.10.0.0/24"
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"

    lifecycle = [
      {
        create_before_destroy = "true"
      }
    ]
  }
]

internet_gateway = [
  {
    vpc_id = "0"
  }
]

route_table = [
  {
    id     = "0"
    vpc_id = "0"
  }
]

route = [
  {
    route_table_id         = "0"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = "0"
  }
]

endpoint = [
  {
    id                = "0"
    vpc_id            = "0"
    service_name      = "s3"
    vpc_endpoint_type = "Gateway"
  }
]

default_sg = [
  {
    vpc_id = "0"
    ingress = [
      {
        from_port = "0"
        to_port   = "0"
        protocol  = "-1"
      }
    ]
    egress = [
      {
        from_port = "0"
        to_port   = "0"
        protocol  = "-1"
      }
    ]
  }
]
route_table_association = [
  {
    route_table_id  = "0"
    vpc_endpoint_id = "0"
  }
]
nat_gw = [
  {
    eip_id = "0"
    subnet_id = "0"
  }
]

subnet = [
  {
    subnet_id = "0"
    vpc_id = "0"
    availability_zone = "1"
    map_public_ip_on_launch = "false"
    lifecycle = [
      {
        create_before_destroy = "true"
        prevent_destroy = "false"
      } 
    ] 
  }
]

eip = []
```