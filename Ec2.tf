Bprovider "aws" {
    region  = "us-east-2"
}


resource "aws_security_group" "Simpli_EC_proj_221" {
    name   = "terraform create_32d"
  
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
  vpc_security_group_ids = [aws_security_group.Simpli_EC_proj_221.id]

  tags = {
    Name        = "Project1_EC2"
    name        = "jumphost"
    provisioner = "Terraform"
}
user_data     = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install openjdk-11-jre
    sudo yum install -y python3
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo yum install -y jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    EOF
  }



