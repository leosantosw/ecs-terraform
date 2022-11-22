locals {
  envs = { 
    for tuple in regexall("(.*)=(.*)", file("../../.env")) : tuple[0] => replace(tuple[1], "\r", "")
  }
}

variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "vpc_ecs" {
  type = string
}

variable "private_subnets" {
  type = list(string)
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