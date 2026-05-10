# Compliance Policies

Rego policy library for the CGE-P capstone. Each policy maps to a NIST 800-53 control.

## GCP Policies

| Policy | Control | Severity | What it checks |
|--------|---------|----------|----------------|
| sc28_encryption.rego | SC-28 | High | Every google_storage_bucket has a CMEK encryption block |
| ac3_no_public.rego | AC-3 | Critical | Buckets have uniform access + public prevention enforced; firewalls don't expose ports 22 or 3389 to 0.0.0.0/0 |
| cm6_required_tags.rego | CM-6 | Medium | Every taggable resource carries project, environment, managed_by, compliance_scope labels |

## AWS Policies

| Policy | Control | Severity | What it checks |
|--------|---------|----------|----------------|
| sc28_encryption_aws.rego | SC-28 | High | Every aws_s3_bucket has a matching aws_s3_bucket_server_side_encryption_configuration |
| ac3_no_public_aws.rego | AC-3 | Critical | Every aws_s3_bucket has an aws_s3_bucket_public_access_block with all four flags true |
| cm6_required_tags_aws.rego | CM-6 | Medium | Every taggable AWS resource carries Project, Environment, ManagedBy, ComplianceScope tags |

## Running the suite

```
# GCP
opa test -v policies/
opa eval -d policies -i plan.json data.compliance.sc28.deny --format=pretty
opa eval -d policies -i plan.json data.compliance.ac3.deny  --format=pretty
opa eval -d policies -i plan.json data.compliance.cm6.deny  --format=pretty

# AWS
conftest test --policy policies --namespace compliance.sc28_aws plan.json
conftest test --policy policies --namespace compliance.ac3_aws  plan.json
conftest test --policy policies --namespace compliance.cm6_aws  plan.json
```