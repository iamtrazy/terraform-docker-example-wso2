resource "docker_image" "image" {
  name = var.image_name
  build {
    context = var.build_context
    tag     = var.build_tag
  }
}
