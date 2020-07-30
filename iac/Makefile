OPTS=

.ONESHELL:
plan:
	[ -f ./tfvars ] && . ./tfvars
	terraform init
	terraform plan $(OPTS)

.ONESHELL:
apply:
	[ -f ./tfvars ] && . ./tfvars
	terraform init
	terraform apply --auto-approve

destroy:
	[ -f ./tfvars ] && . ./tfvars
	terraform init
	terraform destroy
