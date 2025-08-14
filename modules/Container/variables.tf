variable "container_name" {
  description = "Docker container name"
  type        = string
}

variable "image_id" {
  description = "Docker image id"
  type        = string
}

variable "restart_policy" {
  description = "Container restart policy"
  type        = string
  default     = "no"
}

variable "env_vars" {
  description = "Environment variables passed to the container"
  type        = set(string)
  default     = null
}

variable "should_wait" {
  description = "Should Container wait for an healthcheck"
  type        = bool
  default     = false
}

variable "healthcheck" {
  description = "A single healthcheck configuration object. Omitted if null."
  type = object({
    test           = list(string)
    interval       = optional(string)
    retries        = optional(number)
    start_interval = optional(string)
    start_period   = optional(string)
    timeout        = optional(string)
  })
  default = null
}

variable "volumes" {
  description = "A list of volume mounts. Omitted if empty."
  type = list(object({
    container_path = optional(string)
    from_container = optional(string)
    host_path      = optional(string)
    read_only      = optional(bool, false)
    volume_name    = optional(string)
  }))
  default = []
}

variable "networks" {
  description = "A list of advanced network configurations. Omitted if empty."
  type = list(object({
    name         = string
    aliases      = optional(list(string), [])
    ipv4_address = optional(string)
    ipv6_address = optional(string)
  }))
  default = []
}

variable "ports" {
  description = "A list of port mappings. Omitted if empty."
  type = list(object({
    internal = number
    external = number
    ip       = optional(string)
    protocol = optional(string)
  }))
  default = []
}
