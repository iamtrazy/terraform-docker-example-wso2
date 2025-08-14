output "network_id" {
  description = "ID of the docker network"
  value       = docker_network.network.id
  depends_on  = [docker_network.network]
}
