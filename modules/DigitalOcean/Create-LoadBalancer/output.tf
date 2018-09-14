output "do_lb_id" {
  value = "${digitalocean_loadbalancer.do_loadbalancer.id}"
}

output "do_lb_name" {
  value = "${digitalocean_loadbalancer.do_loadbalancer.name}"
}