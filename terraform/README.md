# Terraform AWS Infrastructure

This directory contains Terraform configuration for deploying the Sea OKI Collection website infrastructure on AWS.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- AWS CLI configured with appropriate credentials
- An AWS account with permissions for S3, CloudFront, ACM, and Route 53

## Quick Start

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Review the Plan**:
   ```bash
   terraform plan
   ```

3. **Apply Configuration**:
   ```bash
   terraform apply
   ```
   Type `yes` when prompted.

4. **Save Outputs**:
   After deployment, save the outputs (especially `cloudfront_distribution_id`) for GitHub Actions configuration.

## Configuration

### Variables

Edit `variables.tf` or create a `terraform.tfvars` file:

```hcl
domain_name = "seaoki.com"
aws_region  = "us-east-1"
environment = "production"
```

### Important Notes

- **Region**: Must use `us-east-1` for ACM certificates used with CloudFront
- **Domain**: Must be registered and have Route 53 as the DNS provider
- **DNS Propagation**: Can take up to 48 hours after nameserver changes

## Resources Created

This configuration creates:

- **S3 Bucket**: For static website files
- **S3 Bucket (Logs)**: For CloudFront access logs
- **CloudFront Distribution**: CDN with HTTPS
- **CloudFront OAI**: Origin Access Identity for secure S3 access
- **ACM Certificate**: Free SSL/TLS certificate
- **Route 53 Hosted Zone**: DNS management
- **Route 53 Records**: A records for root and www subdomains

## Outputs

After `terraform apply`, you'll see:

- `website_url`: Your website URL
- `cloudfront_distribution_id`: Needed for GitHub Actions
- `s3_bucket_name`: S3 bucket name
- `route53_name_servers`: Nameservers for domain configuration

## State Management

⚠️ **Important**: Terraform state contains sensitive information.

### Local State (Current Setup)

State is stored locally in `terraform.tfstate`. Keep this file secure and backed up.

### Remote State (Recommended for Production)

For production use, configure remote state with S3 backend:

```hcl
terraform {
  backend "s3" {
    bucket = "seaoki-terraform-state"
    key    = "production/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
  }
}
```

## Common Commands

```bash
# Initialize and download providers
terraform init

# Format code
terraform fmt

# Validate configuration
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Show current state
terraform show

# List resources
terraform state list

# Destroy all resources (careful!)
terraform destroy
```

## Updating Infrastructure

To modify the infrastructure:

1. Edit the `.tf` files
2. Run `terraform plan` to preview changes
3. Run `terraform apply` to apply changes

## Cost Optimization

The configuration uses:
- CloudFront `PriceClass_100` (North America & Europe only) for lower costs
- S3 lifecycle policies to delete old logs after 90 days
- Versioning enabled for rollback capability

## Troubleshooting

### Certificate Validation Timeout

If certificate validation hangs:
1. Check that nameservers point to Route 53
2. Verify validation CNAME records were created
3. Wait up to 30 minutes

### CloudFront Access Denied

If you get 403 errors:
1. Verify S3 bucket policy allows CloudFront OAI
2. Check files were uploaded to S3
3. Ensure default root object is set

## Security

- S3 bucket has public access blocked
- Access only through CloudFront using OAI
- HTTPS enforced (HTTP redirects to HTTPS)
- TLS 1.2+ required
- CloudFront access logs enabled

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

⚠️ This will delete:
- S3 buckets (and all files)
- CloudFront distribution
- SSL certificate
- DNS records

## Support

For issues:
1. Check AWS service status
2. Review Terraform logs
3. Verify AWS credentials and permissions
4. Consult [Terraform AWS Provider docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
