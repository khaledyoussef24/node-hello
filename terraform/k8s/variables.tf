variable "image_name" {
  type    = string
  default = "node-hello"
}

variable "image_tag" {
  type    = string
  default = "latest"
}

variable "container_name" {
  type    = string
  default = "node-hello-container"
}

variable "container_port" {
  type    = number
  default = 3000
}

variable "host_port" {
  type    = number
  default = 8080
}
