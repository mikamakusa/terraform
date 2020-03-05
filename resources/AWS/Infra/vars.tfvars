vpc = [
  {
    id                   = "0"
    cidr_block           = "10.10.0.0/16"
    instance_tenancy     = "default"
    enable_dns_hostnames = "true"
    enable_dns_support   = "true"
  }
]

subnets = [
  {
    id                   = "0"
    vpc_id               = "0"
    cidr_block           = "10.10.10.0/24"
    availability_zone_id = "0"
  },
  {
    id                   = "1"
    vpc_id               = "0"
    cidr_block           = "10.10.20.0/24"
    availability_zone_id = "1"
  },
  {
    id                   = "2"
    vpc_id               = "0"
    cidr_block           = "10.10.30.0/24"
    availability_zone_id = "0"
  },
  {
    id                   = "3"
    vpc_id               = "0"
    cidr_block           = "10.10.40.0/24"
    availability_zone_id = "1"
  }
]

internet_gateway = [
  {
    id     = "0"
    vpc_id = "0"
  }
]

eip = [
    {
    id     = "0"
    vpc_id = "0"
  }
]

route_table = [
    {
    id     = "0"
    vpc_id = "0"
    route = [
      {
        cidr_block     = "0.0.0.0/0"
        gateway_id     = "0"
        nat_gateway_id = ""
      }
    ]
  },
  {
    id     = "1"
    vpc_id = "0"
    route = [
      {
        cidr_block     = "0.0.0.0/0"
        gateway_id     = ""
        nat_gateway_id = "0"
      }
    ]
  }
]

nat_gateway = [
    {
    id            = "0"
    allocation_id = "0"
    subnet_id     = "0"
  }
]

route_table_association = [
    {
    id             = "0"
    route_table_id = "0"
    subnet_id      = "0"
  },
  {
    id             = "1"
    route_table_id = "0"
    subnet_id      = "1"
  },
  {
    id             = "2"
    route_table_id = "1"
    subnet_id      = "2"
  },
  {
    id             = "3"
    route_table_id = "1"
    subnet_id      = "3"
  }
]