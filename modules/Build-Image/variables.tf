variable "image_name" {
  description = "The name of the docker image to build"
  type        = string
}

variable "build_context" {
  description = "The context of the docker image build"
  type        = string
  default     = "."
}

variable "build_tag" {
  description = "The tag of the docker image to build"
  type        = list(string)
}
