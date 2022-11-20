
resource "aws_security_group" "outline-sg" {
  name        = "outline-sg"
  description = "outline-sg"

  ingress {
    description = "outline-sg"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "outline-sg"
  }
}