output "cloudtrail_name" {
  value       = aws_cloudtrail.mgmt.name
  description = "Name of the CloudTrail trail."
}

output "cloudtrail_bucket" {
  value       = aws_s3_bucket.trail.id
  description = "S3 bucket storing CloudTrail logs."
}

output "security_hub_arn" {
  value       = aws_securityhub_account.this.id
  description = "Security Hub account ARN."
}