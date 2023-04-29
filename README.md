# Deploy Infrastructure with Terraform and CircleCI

## Deploying an S3-Backed Web Application using CircleCI and Terraform

### Introduction:
This tutorial explains how to deploy an S3-backed web application using CircleCI and Terraform. The tutorial assumes that the reader is familiar with the Terraform and Terraform Cloud workflows. The reader will learn how to authenticate with Terraform Cloud to store the project's Terraform state, configure CircleCI and Terraform Cloud integrations, and review and modify the Terraform and CircleCI configurations

### Prerequisites:
To complete this tutorial, the following are needed: a GitHub account, a CircleCI account, an AWS account, and a Terraform Cloud account.

### Create a Terraform Cloud token

Under the Team API Token section, click Create a team token.
![image](https://user-images.githubusercontent.com/98816965/235306131-94e697cc-938c-4541-9b55-248e3b83a53d.png)
 
### Fork and Clone Example Configuration:

(Fork this Repo)[https://github.com/hashicorp/learn-terraform-circleci.git]
