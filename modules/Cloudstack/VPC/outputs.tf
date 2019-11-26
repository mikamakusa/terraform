output "vpc_id" {
  value = cloudstack_vpc.vpc.*.id
}

output "vpc_display_text" {
  value = cloudstack_vpc.vpc.*.display_text
}

output "vpc_source_nat_ip" {
  value = cloudstack_vpc.vpc.*.source_nat_ip
}