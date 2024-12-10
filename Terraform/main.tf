terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.80.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "redhat_ec2" {
  # AMI Red Hat Enterprise Linux 9 with High Availability
  ami           = "ami-036c2987dfef867fb"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.clave_aws.key_name

  vpc_security_group_ids = [aws_security_group.tomcat-sg.id]

  tags = {
    Name = "redhat12-Tomcat"
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 60
      echo "[redhat_tomcat]\n
      ${self.public_ip} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_ssh_common_args='-o StrictHostKeyChecking=no'" > ../Ansible/hosts.ini
      ansible-playbook -i ../Ansible/hosts.ini ../Ansible/tomcat_setup.yml 
    EOT
  }

}

resource "aws_security_group" "tomcat-sg" {
  name_prefix = "tomcat-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh_http"
  }

}

resource "aws_key_pair" "clave_aws" {
  key_name   = "MiClave"
  public_key = file("~/.ssh/id_rsa.pub")
}

output "ip_publica" {
  value = "http://${aws_instance.redhat_ec2.public_ip}:8080"
}
