module "infrastructure" {
  source = "../../infra/"

  aws_region = "us-east-1"
  aws_profile = "leo-aws"
  ecr_postgres_repository = "outline-postgres"
}