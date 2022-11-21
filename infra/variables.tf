variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "vpc_ecs" {
  type = string
}

variable "security_group" {
  type = string
}

variable "ecr_postgres_repository" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "ecs_task_definition" {
  type = string
}

variable "ecs_service_name" {
  type = string
}