resource "docker_network" "network" {
  name   = var.network_name
  driver = var.network_driver
}
