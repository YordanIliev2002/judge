module "new-submissions" {
  source = "./queue_topic_pair"
  vhost = rabbitmq_vhost.vhost.name
  resource_prefix = "new-submissions"
}

module "evaluated-submissions" {
  source = "./queue_topic_pair"
  vhost = rabbitmq_vhost.vhost.name
  resource_prefix = "evaluated-submissions"
}
