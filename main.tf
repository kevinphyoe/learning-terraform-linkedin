data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id # This now points to the Amazon Linux image
  instance_type = "t3.nano"

  # Automate the installation of Tomcat
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
