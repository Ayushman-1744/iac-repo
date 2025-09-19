**Project README — Provision AWS VPC, EC2, and RDS (Terraform)**

**Details**
1. https://lucid.app/lucidchart/20817668-e36b-4cad-ac48-2df4b6ad90ad/edit?invitationId=inv_1487d189-6a1e-489a-98f4-bdd975e100f9 (View)
2. Tech Stack & Justification-
   Terraform — chosen because it enables modular, declarative IaC, has a large module registry, supports remote state and locking (S3 + DynamoDB), and works well in a GitOps pipeline. Terraform is ideal for creating reproducible environments across dev/staging/prod by varying inputs.

   AWS (VPC, EC2, RDS) — using native AWS services: VPC for secure networking, EC2 for app servers, and RDS to manage databases with automated backups and patching. RDS reduces operational overhead compared to self-managed DB on EC2.

   GitHub Actions — integrates with your GitHub repository to run Terraform in CI/CD, automate plan on PRs and apply on protected branches with secrets. Easy to set up and doesn't require additional infrastructure.

   S3 + DynamoDB — used for Terraform remote state storage and state locking to prevent accidental concurrent changes, lock stays may need manual deletion.
   
   IAM-permission to work apart from Root user for safe access and work environment and follow principle of least privilege.
   IAM credentials for login ---terraform-user(admin access for greater issue resolving by using cloudwatch logs)
                             ---Admin@123
4. Ensure GitHub secrets are set:(done) as link is public

    -AWS_ACCESS_KEY_ID

    -AWS_SECRET_ACCESS_KEY

    -AWS_REGION
   
  3.1 Backend config 

   -terraform/backend.tf (example provided in repo) configures S3/DynamoDB remote backend. Each environment will use a unique key prefix

  3.2 Run ENVS of **DEV | STAGING | PROD** based on selection at RUN WORKFLOWS based on commands
    terraform init 
    terraform workspcase new (dev | staging | prod)
    terraform select workspace (dev | staging | prod)
    terraform validate
    terraform plan
    terraform apply
    --deployment using terraform ensures clear code and GIT-HUB workflows ensures CI/CD so that at every push or commits made deployemt follows canary deployment.

4. Terraform Destroy works fine if also it fails as issue of dynamo-db-lock terraform file may stay, so manual deletion of lock is at times required.
5. Reources are resuable and working fine. 
   
