output "image_id" {
  description = "Docker image id"
  value       = docker_image.image.image_id
  depends_on  = [docker_image.image]
}
