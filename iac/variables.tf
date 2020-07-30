variable "app_instance_type" {
  type = string
  default = "t2.micro"
  description = "Instance type"
}

variable "jenkins_instance_type" {
  type = string
  default = "t2.medium"
  description = "Instance type"
}

variable "key_name" {
  type = string
  description = "Key pair used for ec2 instances"
}

variable "availability_zone" {
  type = string
  description = "Availability Zone in which instances will be created"
  default = "us-east-1e"
}

variable "zone_id" {
  type = string
  description = "Route53 Zone ID"
}

variable "domain" {
  type = string
  description = "Domain name for which DNS records will be created"
}
