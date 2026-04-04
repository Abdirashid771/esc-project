# ThreatComposer — ECS Fargate Deployment

ThreatComposer is an open-source threat modelling tool developed by AWS, designed to help security teams identify, document, and communicate risks across their systems.

This project deploys ThreatComposer on AWS in a production-grade environment. The application is containerised using a multi-stage Docker build, running as a non-root user with a minimal image footprint. Each image is scanned for vulnerabilities with Trivy before being pushed to ECR.

Infrastructure is fully defined in modular Terraform and deployed within a custom VPC spanning multiple availability zones, with both public and private subnets. The application runs on ECS Fargate behind an Application Load Balancer, with HTTPS enforced via ACM and Route53.

Four dedicated GitHub Actions pipelines manage the full lifecycle—building, scanning, deploying, and tearing down infrastructure—all authenticated OIDC, eliminating the need for static credentials.

---

**Wesbite: https://tm.esproject.xyz**

![Terraform Destroy Pipeline](Docs/pipelines/demo.png)

## Overview

This project deploys ThreatComposer on AWS with:

- **Containerisation** - Docker multi-stage build with non-root user and minimal image footprint
- **Infrastructure** - Terraform with modular architecture and remote state on S3
- **Orchestration** - ECS Fargate, serverless containers across two availability zones
- **Networking** - VPC with public and private subnets, ALB, security groups
- **TLS** - ACM certificate with DNS validation, HTTPS enforced via ALB listener rule
- **DNS** - Route53 alias record pointing to the ALB
- **Registry** - ECR with immutable tags and scan on push
- **CI/CD** - GitHub Actions with OIDC, no static credentials
- **Security scanning** - Trivy on Docker images, Checkov on Terraform code
- **Config management** - SSM Parameter Store for dynamic ECR URL retrieval
- **Logging** - CloudWatch 


---

## Architecture

![Architecture Diagram](Docs/architecture.png)

---

## Repository Structure
```
├── app/                        
├── Dockerfile                  
├── .dockerignore
├── infra/
│   ├── main.tf                 
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf              
│   └── modules/
│       ├── vpc/
│       ├── ecs/
│       ├── alb/
│       ├── ecr/
│       ├── acm/
│       └── route53/
└── .github/
    └── workflows/
        ├── docker.yml
        ├── plan.yml
        ├── apply.yml
        └── destroy.yml

```
## Multistage Dockerfile

![Multistage Dockerfile](Docs/pipelines/Multistage.png)

---

## Boostrap

Before running any pipeline, provision the Terraform backend by running the bootstrap script once from the project root

```bash
bash bootstrap.sh
```
This creates:
- S3 bucket for remote state storage with versioning and encryption enabled
- DynamoDB table for state locking
- Script is idempotent — safe to run multiple times

The OIDC provider and IAM roles are managed by Terraform.
Store the role ARNs as GitHub secrets — read role for plan, write role for docker, apply and destroy pipelines.

---

## Local Development
```bash
docker build -t threatcomposer ./app
docker run -p 80:80 threatcomposer


```

---

## CI/CD Pipelines

Four pipelines — infrastructure and application deployments are fully independent, with path filters ensuring only the relevant pipeline triggers when changes are made.

| Pipeline | Steps |
|---|---|
| Docker | Build → Trivy scan → push to ECR |
| Plan | fmt → init → validate → Checkov → plan → upload artifact |
| Apply | Download plan → init → apply |
| Destroy | init → destroy |

### Docker Pipeline
![Docker Pipeline](Docs/pipelines/docker.png)

### Terraform Plan Pipeline
![Terraform Destroy Pipeline](Docs/pipelines/terraform-deploy-pipeline.png)

### Terraform Apply Pipeline
![Terraform Apply Pipeline](Docs/pipelines/apply.png)

### Terraform Destroy Pipeline
![Terraform Destroy Pipeline](Docs/pipelines/destroy.png)

---

## Intended Pipeline Triggers

When moved to a team environment, pipelines would be triggered as follows rather than manually:

| Pipeline | Trigger | Path Filter |
|---|---|---|
| Docker | Push to `main` | `app/**`, `Dockerfile` |
| Plan | Pull request | `infra/**` |
| Apply | Merge to `main` | `infra/**` |
| Destroy | `workflow_dispatch` only | — |

Path filters ensure only the relevant pipeline fires when changes are made. A change to `app/` never triggers a Terraform plan. A change to `infra/` never triggers a Docker build. Destroy remains manual only — never automated under any circumstance.

---

## Security

| Control | Implementation |
|---|---|
| No static credentials | OIDC — credentials issued per job, expire on completion |
| Least privilege | Separate read and write IAM roles — plan cannot modify infrastructure |
| Network isolation | ECS tasks in private subnets, ECS SG scoped to ALB SG only |
| TLS | ACM certificate, HTTP redirects to HTTPS via ALB listener rule |
| Image integrity | Immutable ECR tags — SHA tags permanently locked on push |
| Vulnerability scanning | Trivy on every image build — fails on fixable critical CVEs |
| IaC scanning | Checkov on every PR — catches misconfigurations before deployment |
| Config management | SSM Parameter Store — no hardcoded values in pipelines or code |

---

## Future Improvements

**WAF** — attach AWS Web Application Firewall to the ALB for rate limiting, SQL injection protection, and geo-blocking.

**Secrets Manager** — migrate sensitive values from SSM Parameter Store to AWS Secrets Manager for automatic secret rotation.

**Multi-environment** — separate dev and prod Terraform workspaces with environment-specific tfvars. Currently single environment only.

**Monitoring** — CloudWatch alarms on ALB 5xx error rate and ECS task health.

---

## Teardown

Trigger the destroy pipeline manually from GitHub Actions. S3 bucket and DynamoDB table are Tier-0 and not Terraform managed — delete manually if no longer needed.
