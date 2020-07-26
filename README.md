Infrastructure As Code Example
===

This repository is an example of how IaC using Terraform is is applied to create two servers one for Jenkins and the other for an application. It will also create their DNS records based on the Route53 Hosted Zone that is provided.


### How to run AWS Infrastructure
In order to create the AWS Infrastructure just follow the next steps:

Go to `iac` directory and create a `tfvars` file based on the `tfvars.example`. Here you set the domain name and Hosted Zone Id that will be used.

After that run the next commands:

```
$ cd iac
$ make plan
This will show all resources that will be created
$ make apply
```

So far there will be two servers created that can be accessed using the next domains:

- `jenkins.example.com`
- `app.example.com`

### How to run Ansible to provision servers
So far the servers that we have do not have any resource installed. We provision those servers with all the required tools for the demo using [Ansible](https://docs.ansible.com/ansible/latest/index.html).

First you must have Ansible installed. Once you have it you can follow next steps.

To provision the Jenkins first modify the `ansible/inventory.txt` file with the correct domain names for the two servers and do the same for `ansible/group_vars/all.yml`. Once you changed to the correct values run:

```
$ cd ansible
$ ansible-playbook -i inventory.txt jenkins-playbook.yml --private-key <server-private-key>
```
