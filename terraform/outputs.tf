# Terraform Outputs for Sea OKI Collection AWS Infrastructure

output "website_url" {
  description = "Website URL"
  value       = "https://${var.domain_name}"
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.website.arn
}

output "s3_bucket_regional_domain_name" {
  description = "Regional domain name of the S3 bucket"
  value       = aws_s3_bucket.website.bucket_regional_domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID (needed for GitHub Actions)"
  value       = aws_cloudfront_distribution.website.id
}

output "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website.arn
}

output "cloudfront_distribution_domain_name" {
  description = "Domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website.domain_name
}

output "cloudfront_distribution_hosted_zone_id" {
  description = "CloudFront distribution hosted zone ID"
  value       = aws_cloudfront_distribution.website.hosted_zone_id
}

output "acm_certificate_arn" {
  description = "ARN of the ACM certificate"
  value       = aws_acm_certificate.website.arn
}

output "route53_name_servers" {
  description = "Route 53 name servers for the domain"
  value       = aws_route53_zone.main.name_servers
}

output "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = aws_route53_zone.main.zone_id
}

output "deployment_instructions" {
  description = "Next steps for deployment"
  value       = <<-EOT
    
    ================================
    Deployment Complete!
    ================================
    
    1. Add the following GitHub Secret:
       Name: CLOUDFRONT_DISTRIBUTION_ID
       Value: ${aws_cloudfront_distribution.website.id}
    
    2. Update your domain registrar nameservers to:
       ${join("\n       ", aws_route53_zone.main.name_servers)}
    
    3. Wait for DNS propagation (up to 48 hours, usually < 1 hour)
    
    4. Your website will be available at:
       - https://${var.domain_name}
       - https://www.${var.domain_name}
    
    5. Deploy your site by pushing to the main branch or run:
       aws s3 sync dist/ s3://${aws_s3_bucket.website.id} --delete
       aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.website.id} --paths "/*"
    
    ================================
  EOT
}
