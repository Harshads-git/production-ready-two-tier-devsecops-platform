# Terraform Work

This directory contains a starter EC2-first Terraform plan for the 15-day portfolio version.

## What It Creates

- Security group for SSH and app access.
- EC2 instance for running the Docker Compose stack.
- Docker installation through `user_data.sh`.

## What It Does Not Do Yet

- It does not create a VPC.
- It does not create an RDS database.
- It does not push images to ECR.
- It does not deploy the application automatically.

Those are intentional future improvements.

## Usage

Copy the example variables file:

```powershell
Copy-Item infra\terraform\terraform.tfvars.example infra\terraform\terraform.tfvars
```

Edit `terraform.tfvars` with real AWS values, then run from `infra/terraform`:

```powershell
terraform init
terraform plan
```

Only run `terraform apply` after confirming AWS cost and access assumptions.

