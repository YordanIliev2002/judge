variable "rabbitmq_host" {
  nullable    = false
  description = "The hostname of the RabbitMQ server"
}

variable "rabbitmq_port" {
  nullable    = false
  description = "The port of the RabbitMQ server"
}

variable "rabbitmq_username" {
  nullable    = false
  sensitive   = true
  description = "The username for the RabbitMQ user"
}

variable "rabbitmq_password" {
  nullable    = false
  sensitive   = true
  description = "The password for the RabbitMQ user"
}
