log_group = [
  {
    id                = "0"
    name              = "ecs-fargate"
    retention_in_days = "7"
  }
]

log_stream = [
  {
    id           = "0"
    log_group_id = "0"
    name         = "ecs-fargate"
  }
]