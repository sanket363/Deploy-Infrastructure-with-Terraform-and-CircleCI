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

[Fork this Repo](https://github.com/hashicorp/learn-terraform-circleci.git) to your machine. The repository contains an example configuration to deploy Terramino, a Terraform-skinned Tetris game, to an AWS S3 bucket using Terraform and CircleCI.

### Review Terraform Configuration:
The Terraform configuration in this repository deploys Terramino, a Terraform-skinned Tetris application, to an AWS S3 bucket.
This configuration uses a terraform.tfvars file to set values for the input variables of your configuration. Open the terraform.tfvars file to review its contents.
Next, open the terraform.tf file. The configuration in this file defines the required provider and Terraform versions for this configuration. It also includes an empty cloud block.
The cloud block configures a Terraform Cloud integration for CLI-driven Terraform Cloud runs.

### Review CircleCI Jobs and Workflow:

Navigate to the Subdirectory
```bash
cd .circleci
```
Review all the files and make required changes to them

### Create Terraform Cloud workspace:
In the Terraform Cloud UI, create a new CLI-driven workspace named learn-terraform-circleci.

On the workspace overview page, click on the curent Execution Mode to navigate to the general settings.

![image](https://user-images.githubusercontent.com/98816965/235306661-3020ad79-5d78-4baa-9f75-723d1ed02a31.png)

Under Execution Mode, select Local. Then, click Save Settings at the bottom of the page.
![image](https://user-images.githubusercontent.com/98816965/235306670-f2ab43c0-a3a8-4a15-a254-c3493373d157.png)

### Configure CircleCI project

Navigate to your CircleCI dashboard. Make sure that you are in the correct organization with access to your GitHub account by confirming the organization in the top left corner.

Then, select Projects in the left sidebar.

![image](https://user-images.githubusercontent.com/98816965/235306706-76cf7737-1e88-4c30-8956-9dea2dd8a270.png)

Select the Fastest configuration option to use the CircleCI configuration file in the repository. Enter the main branch as the brain to track. Then, click Set Up Project.

![image](https://user-images.githubusercontent.com/98816965/235306718-a77cd010-fffd-4baa-8cc7-fd2eb03ebaf3.png)


CircleCI will automatically attempt to run the job and fail because the project needs your AWS credentials and Terraform Cloud integration details.

Navigate to the project's Project Settings, then select Environment Variables from the sidebar.

![image](https://user-images.githubusercontent.com/98816965/235306725-3061777c-3495-4b87-9723-c9d5fb9fbf87.png)


Set the following environment variables, which Terraform will access in your build environment to configure both the AWS provider and the Terraform Cloud integration for your project:

1. Set AWS_ACCESS_KEY_ID to the generated key for the AWS user running this job. To generate an access key and secret access key file, log in to your AWS account and create them in IAM.
2. Set AWS_SECRET_ACCESS_KEY to the secret access key you generated above.
3. Set TF_CLOUD_ORGANIZATION to your Terraform Cloud organization name
4. Set TF_WORKSPACE to learn-terraform-circleci, the Terraform Cloud workspace you created and configured earlier in this tutorial.
5. Set TF_TOKEN_app_terraform_io to the API token you created at the beginning of the tutorial.

When complete, your environment variables page will list the configured variables.

![image](https://user-images.githubusercontent.com/98816965/235306782-4b9340ba-ecff-4cbc-91db-841798386c10.png)

### Define your Terraform variables

In your file editor, open terraform.tfvars and update the label variable value to hashicorp.fun. Then, save the file.

```bash
region = "us-east-1"
label  = "hashicorp.fun"
app    = "terramino"
```

### Trigger CircleCI workflow
Stage your changes to your GitHub repository.
```bash
git add terraform.tfvars
```
Commit these changes with a message.
```bash
git commit -m "Update variable definitions"
```
Finally, push these changes to your forked repository's main branch to kick off a CircleCI run.
```bash
git push
```
The CircleCI web UI should indicate that your build started. The steps for this deployment will initialize your Terraform directory, plan the Terraform deployment, and wait for your approval to apply the planned changes.

![image](https://user-images.githubusercontent.com/98816965/235306911-f71e2b88-c5b2-4d01-a83e-f17c86b5d962.png)


Review the output for the plan-apply job, which shows the proposed execution plan to create your resources. First, click on the plan-apply step in the workflow, then expand the terraform init && plan step to review the execution plan.

Then, return to the workflow overview by clicking the plan_approve_apply workflow at the top and approve it.

![image](https://user-images.githubusercontent.com/98816965/235306934-22ac8073-5900-4c83-aba8-a558e9634580.png)



