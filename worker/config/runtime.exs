import Config

config :judge_worker, Rabbit,
  host: System.get_env("AMQP_HOST") || "localhost",
  username: System.get_env("AMQP_USERNAME") || "admin",
  password: System.get_env("AMQP_PASSWORD") || "password"
