output "application_public_ip" {
  value = aws_instance.application.public_ip
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}
