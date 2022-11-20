resource "aws_ecs_cluster" "ecs-cluster" {
  name = "outline-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}