output "image_id" {
  description = "Image id of the build image"
  value       = docker_image.image.image_id
  depends_on  = [docker_image.image]
}
