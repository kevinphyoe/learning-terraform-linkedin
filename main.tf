data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["137112412989"]

filter {
    name   = "name"
    # This wildcard matches any AL2023 x86_64 image
    values = ["al2023-ami-2023.*-x86_64*"] 
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id # This now points to the Amazon Linux image
  instance_type = "t3.micro"

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
