provider "aws" {
  region = var.region
}
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id =var.subnet_id
  associate_public_ip_address = true 
  vpc_security_group_ids = [aws_security_group.pgadmin-security-group.id]
  tags = {
    Name = "fsa-pgadmin-dev"
  }
}
resource "aws_key_pair" "pgadminkeypair" {
  key_name = "pgadminkeypair.pem"
  public_key = tls_private_key.rsa.public_key_openssh
  tags={
    Name= "pgadminkeypair.pem"
  }
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
 content  = tls_private_key.rsa.private_key_pem
 filename = "pgadminkeypair.pem"
}

resource "aws_security_group" "pgadmin-security-group" {
  name        = "latest-pgadmin-instance-security-group"
  description = "security group created using Terraform for the pgadmin instance"
  vpc_id      = var.vpc_id
  tags = {
    Name="pgadminsg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.121.27.98/32", "182.76.203.185/32",
"103.121.27.90/32", "202.164.151.150/32"]  
   
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    
    cidr_blocks = ["103.121.27.98/32", "182.76.203.185/32",
"103.121.27.90/32", "202.164.151.150/32"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




