module "flask-image" {
  source        = "./modules/Build-Image"
  image_name    = var.flaskapp_image_name
  build_context = var.flaskapp_context
  build_tag     = var.flaskapp_build_tag
}

module "mysql-image" {
  source     = "./modules/Registry-Image"
  image_name = var.mysql_image_name
}

module "mysql-data-volume" {
  source      = "./modules/Volume"
  volume_name = var.mysql_volume_name
}

module "caddy-image" {
  source     = "./modules/Registry-Image"
  image_name = var.caddy_image_name
}

module "app-network" {
  source         = "./modules/Network"
  network_name   = var.app_network_name
  network_driver = var.app_network_driver
}

module "mysql-container" {
  source         = "./modules/Container"
  image_id       = module.mysql-image.image_id
  container_name = var.mysql_container_name
  restart_policy = var.mysql_container_restart_policy
  env_vars       = var.mysql_secrets
  should_wait    = true
  healthcheck = {
    test    = var.mysql_container_healthcheck_test
    retries = var.mysql_container_healthcheck_retries
    timeout = var.mysql_container_healthcheck_timeout
  }
  volumes = [
    {
      container_path = var.mysql_container_volume_mountpath
      volume_name    = module.mysql-data-volume.volume_id
    }
  ]
  networks = [
    {
      name = module.app-network.network_id
    }
  ]
}

module "flaskapp-container" {
  source         = "./modules/Container"
  image_id       = module.flask-image.image_id
  container_name = var.flaskapp_container_name
  restart_policy = var.flaskapp_container_restart_policy
  volumes = [
    {
      container_path = var.flaskapp_container_config_mountpath
      host_path      = abspath(var.flaskapp_container_config_hostpath)
    }
  ]
  networks = [
    {
      name = module.app-network.network_id
    }
  ]
  depends_on = [
    module.mysql-container
  ]
}

module "caddy-container" {
  source         = "./modules/Container"
  image_id       = module.caddy-image.image_id
  container_name = var.caddy_container_name
  restart_policy = var.caddy_container_restart_policy
  volumes = [
    {
      container_path = var.caddy_container_config_mountpath
      host_path      = abspath(var.caddy_container_config_hostpath)
    }
  ]
  ports = [
    {
      internal = 80
      external = 80
    },
    {
      internal = 443
      external = 443
    }
  ]
  networks = [
    {
      name = module.app-network.network_id
    }
  ]
}
