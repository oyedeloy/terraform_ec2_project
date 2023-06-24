provider "aws" {
    region  = "us-east-2"
}


resource "aws_security_group" "Simpli_EC_proj_1" {
    name   = "terraform create_2d"
  
    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}
# Create EC2 instance
resource "aws_instance" "jump-box" {
  ami                    = "ami-024e6efaf93d85776"
  instance_type          = "t2.micro"
  key_name               = "devops-key2"
  vpc_security_group_ids = [aws_security_group.Simpli_EC_proj_1.id]

  tags = {
    Name        = "Project1_EC2"
    name        = "jumphost"
    provisioner = "Terraform"
  }
}


