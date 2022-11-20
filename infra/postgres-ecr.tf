resource "aws_ecr_repository" "postgres-ecr" {
  name = var.ecr_postgres_repository
}

resource "null_resource" "docker_login_aws" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.aws_region} --profile ${var.aws_profile} | docker login --username AWS --password-stdin ${aws_ecr_repository.postgres-ecr.repository_url}"
  }

  depends_on = [aws_ecr_repository.postgres-ecr]
}

resource "null_resource" "build_image" {
  provisioner "local-exec" {
    working_dir = "./../../images"
    command = "docker build --file postgres -t ${var.ecr_postgres_repository} ."
  }

  depends_on = [null_resource.docker_login_aws]
}

resource "null_resource" "tag_image" {
  provisioner "local-exec" {
    command = "docker tag ${var.ecr_postgres_repository}:latest ${aws_ecr_repository.postgres-ecr.repository_url}:latest"
  }

  depends_on = [null_resource.build_image]
}

resource "null_resource" "push_image" {
  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.postgres-ecr.repository_url}:latest"
  }

  depends_on = [null_resource.tag_image]
}





