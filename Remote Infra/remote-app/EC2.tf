resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-remote-app-key"
  public_key = file("terr_key_ec2.pub")

  tags = {
    Environment = var.env
  }
}

resource "aws_default_vpc" "default" {
}

resource "aws_security_group" "my_security_group" {
  name        = "${var.env}-remote-app-security_group"
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
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name =  "${var.env}-remote-app-security_group"
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

  instance_type = var.instance_type
  ami           = var.ami_id

  user_data = file("install_nginx.sh")

  root_block_device {
    volume_size = var.env == "prod" ? 20 : 25
    volume_type = "gp3"
  }


 tags = {
    Name = "${var.env}-remote-app-instance"
    Environment = var.env
  }
} 