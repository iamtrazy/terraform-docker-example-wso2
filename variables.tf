variable "flaskapp_image_name" {
  description = "Flask app docker image build name"
  type        = string
  default     = "flaskapp"
}

variable "flaskapp_context" {
  description = "Flask app build context directory with Dockerfile"
  type        = string
}

variable "flaskapp_build_tag" {
  description = "Flask app docker image build tag"
  type        = list(string)
  default     = ["wso2:flaskapp"]
}

variable "mysql_image_name" {
  description = "MySQL docker image name"
  type        = string
  default     = "mysql:8.0"
}

variable "mysql_volume_name" {
  description = "MySQL dbdata volume name"
  type        = string
  default     = "dbdata"
}

variable "caddy_image_name" {
  description = "Caddy docker image name"
  type        = string
  default     = "caddy:2.10.0-alpine"
}

variable "app_network_name" {
  description = "Network name for the app"
  type        = string
  default     = "app-network"
}

variable "app_network_driver" {
  description = "Network driver for the app network"
  type        = string
  default     = "bridge"
}

variable "mysql_container_name" {
  description = "Container name of the MySQL container"
  type        = string
  default     = "mysql"
}

variable "mysql_secrets" {
  description = "Secret environment variables to pass to MySQL container"
  type        = set(string)
  sensitive   = true
}

variable "mysql_container_restart_policy" {
  description = "MySQL container restart policy"
  type        = string
  default     = "unless-stopped"
}

variable "mysql_container_healthcheck_test" {
  description = "MySQL container healthcheck test command"
  type        = list(string)
  default     = ["CMD", "mysqladmin", "ping", "-h", "localhost"]
}

variable "mysql_container_healthcheck_retries" {
  description = "MySQL container healthchek retries"
  type        = number
  default     = 10
}

variable "mysql_container_healthcheck_timeout" {
  description = "MySQL container healthcheck timeout"
  type        = string
  default     = "20s"
}

variable "mysql_container_volume_mountpath" {
  description = "Contaner path to mount mysql data volume"
  type        = string
  default     = "/var/lib/mysql"
}

variable "flaskapp_container_name" {
  description = "Container name of the Flask app container"
  type        = string
  default     = "flaskapp"
}

variable "flaskapp_container_restart_policy" {
  description = "Flask app container restart policy"
  type        = string
  default     = "unless-stopped"
}

variable "flaskapp_container_config_mountpath" {
  description = "Contaner path to mount Flask app config"
  type        = string
  default     = "/app/config/db_config.py"
}

variable "flaskapp_container_config_hostpath" {
  description = "Host path to mount Flask app config"
  type        = string
}


variable "caddy_container_name" {
  description = "Container name of the Caddy container"
  type        = string
  default     = "caddy"
}

variable "caddy_container_restart_policy" {
  description = "Caddy container restart policy"
  type        = string
  default     = "unless-stopped"
}

variable "caddy_container_config_mountpath" {
  description = "Contaner path to mount Caddy config"
  type        = string
  default     = "/etc/caddy/Caddyfile"
}

variable "caddy_container_config_hostpath" {
  description = "Host path to mount Caddy config"
  type        = string
}
