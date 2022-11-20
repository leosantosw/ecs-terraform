module "infrastructure" {
  source = "../../infra/"

  aws_region = "us-east-1"
  aws_profile = "leo-aws"
  vpc_ecs = "vpc-ecs"
  security_group = "outline-sg"
  ecr_postgres_repository = "outline-postgres"
}