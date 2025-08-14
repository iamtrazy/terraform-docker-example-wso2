output "volume_id" {
  description = "Docker volume id"
  value       = docker_volume.volume.id
  depends_on  = [docker_volume.volume]
}
