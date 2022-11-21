data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = var.ecs_cluster_name

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 1
      }
    }
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.ecs_task_definition
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = data.aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "ecs",
    "image": "${aws_ecr_repository.postgres-ecr.repository_url}:latest",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5432,
        "hostPort": 5432
      }
    ]
  }
]
TASK_DEFINITION

}

resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = 1

  network_configuration {
    subnets = var.private_subnets
    security_groups = [aws_security_group.security_group.id]
    assign_public_ip = true
  }
}