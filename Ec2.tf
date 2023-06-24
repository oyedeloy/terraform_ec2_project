provider "aws" {
    region  = "us-east-2"
}

# Create EC2 instance
resource "aws_instance" "jump-box" {
  ami                    = "ami-024e6efaf93d85776"
  instance_type          = "t2.micro"
  key_name               = "devops-key2"
  vpc_security_group_ids = [aws_security_group.Project_1_sg.id]

  tags = {
    Name        = "Project1_EC2"
    name        = "jumphost"
    provisioner = "Terraform"
  }
}

#Create security group

