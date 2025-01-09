terraform {
  required_providers {
    rabbitmq = {
      source = "cyrilgdn/rabbitmq"
      version = "1.8.0"
    }
  }
}

provider "rabbitmq" {
  endpoint = "http://${var.rabbitmq_host}:${var.rabbitmq_port}"
  username = var.rabbitmq_username
  password = var.rabbitmq_password
}

resource "rabbitmq_vhost" "vhost" {
  name = "/"
}
