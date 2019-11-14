output "do_lb_id" {
  value = digitalocean_loadbalancer.do_loadbalancer.*.id
}

output "do_lb_name" {
  value = digitalocean_loadbalancer.do_loadbalancer.*.name
}

output "do_lb_urn" {
  value = digitalocean_loadbalancer.do_loadbalancer.*.urn
}

output "do_lb_ip" {
  value = digitalocean_loadbalancer.do_loadbalancer.*.ip
}