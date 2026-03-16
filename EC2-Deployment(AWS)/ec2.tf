resource "aws_key_pair" "my_key" {
  key_name   = "terraform_ec2"
  public_key = file("terr_key_ec2.pub")
}

resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "my_security_group" {
  name        = "automate_sg"
  description = "Security group for EC2 instance"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }
  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow application traffic on port 8000"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "Automate_Security_Group"
  }
}

resource "aws_instance" "my_instance" {

  count = 1
  depends_on = [
    aws_security_group.my_security_group,
    aws_key_pair.my_key
  ]
  key_name = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [
    aws_security_group.my_security_group.id
  ]

  instance_type = var.ec2_instance_type
  ami           = var.ec2_ami_id

  user_data = file("install_nginx.sh")

  root_block_device {
    volume_size = var.ec2_root_storage_size
    volume_type = "gp3"
  }


 tags = {
    Name = "EC2 automate by Terraform"
  }
}