

resource "aws_security_group" "instance_sg" {
  name        = "${module.label.id}-instance-sg"
  description = "Instances security group"
  vpc_id      = aws_default_vpc.vpc.id

  ingress {
    description = "HTTPS Ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP Ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH Ingress"
    from_port   = 22
    to_port     = 22
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
    Name = "allow_tls"
  }
}

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  iam_instance_profile = aws_iam_instance_profile.jenkins_profile.name
  key_name        = var.key_name

  tags = merge(module.label.tags, {
    "Name" = "${module.label.id}-jenkins-instance"
  },)
}

resource "aws_instance" "application" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name        = var.key_name

  tags = merge(module.label.tags, {
    "Name" = "${module.label.id}-application-instance"
  },)
}

resource "aws_route53_record" "jenkins_dns" {
  zone_id = var.zone_id
  name    = "jenkins.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.jenkins.public_ip]
}

resource "aws_route53_record" "app_dns" {
  zone_id = var.zone_id
  name    = "app.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.application.public_ip]
}
