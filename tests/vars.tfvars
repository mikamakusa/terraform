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