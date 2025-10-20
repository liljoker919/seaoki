# Quick Start Guide - AWS Deployment

This is a condensed version of the deployment guide. For complete details, see [DEPLOYMENT.md](../DEPLOYMENT.md).

## Prerequisites Checklist

- [ ] AWS Account created
- [ ] Domain name registered (can use Route 53)
- [ ] Terraform installed (v1.0+)
- [ ] Node.js 18+ installed
- [ ] GitHub repository access

## Step-by-Step Deployment

### 1. AWS IAM User Setup (5 minutes)

```bash
# In AWS Console:
# 1. Go to IAM → Users → Add User
# 2. Name: seaoki-deployer
# 3. Enable: Programmatic access
# 4. Attach policies: S3, CloudFront, ACM, Route53 full access
# 5. Save Access Key ID and Secret Access Key
```

### 2. GitHub Secrets (2 minutes)

Add these secrets in GitHub → Settings → Secrets:

```
AWS_ACCESS_KEY_ID=<your-access-key>
AWS_SECRET_ACCESS_KEY=<your-secret-key>
AWS_REGION=us-east-1
S3_BUCKET=seaoki.com
```

### 3. Configure Terraform (2 minutes)

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your domain name
nano terraform.tfvars
```

### 4. Deploy Infrastructure (20-30 minutes)

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Deploy (confirm with 'yes')
terraform apply
```

**Important**: Save the CloudFront Distribution ID from the output!

### 5. Add CloudFront ID to GitHub (1 minute)

```bash
# Copy the distribution ID from terraform output
terraform output cloudfront_distribution_id

# Add to GitHub Secrets as:
# CLOUDFRONT_DISTRIBUTION_ID=E1234ABCDEFGH
```

### 6. Update Nameservers (5 minutes)

```bash
# Get nameservers
terraform output route53_name_servers

# Update at your domain registrar with these nameservers
# Wait for DNS propagation (usually < 1 hour, can take up to 48 hours)
```

### 7. Deploy Website (automatic)

```bash
# Simply push to main branch
git push origin main

# Or manually:
npm run build
aws s3 sync dist/ s3://seaoki.com --delete
aws cloudfront create-invalidation --distribution-id E1234ABCDEFGH --paths "/*"
```

## Verification

1. Check GitHub Actions: `https://github.com/YOUR-USERNAME/seaoki/actions`
2. Test website: `https://seaoki.com`
3. Test www: `https://www.seaoki.com`
4. Verify SSL: Check for padlock icon in browser

## Common Issues

### SSL Certificate Stuck
- Wait up to 30 minutes
- Ensure nameservers point to Route 53
- Check validation records in Route 53

### 403 Error on Website
- Verify files uploaded to S3: `aws s3 ls s3://seaoki.com`
- Check CloudFront distribution status: must be "Deployed"
- Wait 5-10 minutes after first deployment

### Changes Not Showing
- Create CloudFront invalidation
- Wait 2-5 minutes for cache clear
- Hard refresh browser (Ctrl+Shift+R)

## Cost Estimate

- S3 Storage: ~$0.12/month
- CloudFront: Free tier (1TB)
- Route 53: $0.50/month
- ACM Certificate: Free
- **Total: ~$0.70/month**

## Next Steps

1. Customize `src/pages/index.astro` with your content
2. Add blog posts to `src/content/blog/`
3. Update property information
4. Test deployment by pushing to main

## Support Resources

- Full guide: [DEPLOYMENT.md](../DEPLOYMENT.md)
- Terraform guide: [terraform/README.md](../terraform/README.md)
- GitHub secrets: [.github/SECRETS.md](./SECRETS.md)

---

**Total Setup Time**: ~45-60 minutes (excluding DNS propagation)
