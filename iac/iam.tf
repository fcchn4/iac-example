resource "aws_iam_role" "jenkins_role" {
  name = "${module.label.id}-jenkins-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge(module.label.tags, {
    "Name" = "${module.label.id}-jenkins-role"
  },)
}

resource "aws_iam_policy" "policy" {
  name        = "${module.label.id}-route53-policy"
  description = "A test policy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "certbot-dns-route53 sample policy",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:ListHostedZones",
                "route53:GetChange"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect" : "Allow",
            "Action" : [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource" : [
                "arn:aws:route53:::hostedzone/${var.zone_id}"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "default" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "${module.label.id}-jenkins-profile"
  role = aws_iam_role.jenkins_role.name
}
