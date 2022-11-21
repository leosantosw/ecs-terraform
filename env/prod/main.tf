module "infrastructure" {
  source = "../../infra/"

  aws_region = "us-east-1"
  
  aws_profile = "leo-aws"

  vpc_ecs = "vpc-088eda898f634f11d"

  private_subnets = ["subnet-0cac05b9279bd484e", "subnet-054846eb1778944e3"]

  security_group = "outline-sg"
  
  ecr_postgres_repository = "outline-postgres"
  
  ecs_cluster_name = "outline-cluster"

  ecs_task_definition = "postgres-outline-task"

  ecs_service_name = "postgres-outline-service"
}