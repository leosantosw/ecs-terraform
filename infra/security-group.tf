
resource "aws_security_group" "security_group" {
  name   = var.security_group
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "outline-sg"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.security_group}"
  }
}