resource "docker_container" "container" {
  name         = var.container_name
  image        = var.image_id
  restart      = var.restart_policy
  env          = var.env_vars
  wait         = var.should_wait
  wait_timeout = var.healthcheck_wait_timeout

  dynamic "healthcheck" {
    for_each = var.healthcheck != null ? [var.healthcheck] : []
    content {
      test         = healthcheck.value.test
      timeout      = healthcheck.value.timeout
      retries      = healthcheck.value.retries
      interval     = healthcheck.value.interval
      start_period = healthcheck.value.start_period
    }
  }

  dynamic "volumes" {
    for_each = var.volumes
    content {
      container_path = volumes.value.container_path
      volume_name    = lookup(volumes.value, "volume_name", null)
      host_path      = lookup(volumes.value, "host_path", null)
      read_only      = volumes.value.read_only
    }
  }

  dynamic "networks_advanced" {
    for_each = var.networks
    content {
      name    = networks_advanced.value.name
      aliases = networks_advanced.value.aliases
    }
  }

  dynamic "ports" {
    for_each = var.ports
    content {
      internal = ports.value.internal
      external = ports.value.external
      protocol = ports.value.protocol
      ip       = ports.value.ip
    }
  }
}
