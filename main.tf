# 1. Lookup a current Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.nano"

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y tomcat
              systemctl enable --now tomcat
              EOF

  tags = {
    Name = "HelloWorld"
  }
}
