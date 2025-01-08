terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "1.8.0"
    }
  }
}

variable "vhost" {
    description = "The RabbitMQ vhost to use"
    type        = string
}

variable "resource_prefix" {
    description = "The prefix for the topic and queue names"
    type        = string
}

resource "rabbitmq_exchange" "exchange" {
  vhost = var.vhost
  name  = "${var.resource_prefix}-topic"
  settings {
    type    = "fanout"
    durable = true
  }
}

resource "rabbitmq_queue" "queue" {
  vhost = var.vhost
  name  = "${var.resource_prefix}-queue"
  settings {
    durable = true
    arguments = {
      "x-queue-type" = "classic"
    }
  }
}

resource "rabbitmq_binding" "binding" {
  vhost            = var.vhost
  source           = rabbitmq_exchange.exchange.name
  destination      = rabbitmq_queue.queue.name
  destination_type = "queue"
}
