# GCP Security Services Baseline

Terraform module deploying the GCP-native security baseline for the CGE-P capstone.

## Services deployed

### Org Policy (project scope)
Enforces security controls at the API — non-compliant resource creation is rejected before it exists.

| Policy | Control | What it enforces |
|--------|---------|-----------------|
| storage.uniformBucketLevelAccess | CM-6 | All GCS buckets must use uniform bucket-level access |
| iam.disableServiceAccountKeyCreation | AC-2 | Long-lived service account keys cannot be created |
| compute.requireOsLogin | AC-3 | OS Login required for all Compute Engine VMs |

### Workload Identity Federation
Replaces long-lived service account JSON keys with short-lived OIDC tokens for GitHub Actions.
- No keys on disk, no keys in GitHub Secrets
- Token expires automatically after one hour
- Scoped to a specific GitHub repository via `attribute_condition`

### Data Access Audit Logs
**Off by default — this is the #1 GCP audit finding.**
Enabled for three services:

| Service | Log types | Control |
|---------|-----------|---------|
| storage.googleapis.com | DATA_READ, DATA_WRITE, ADMIN_READ | AU-2, AU-12 |
| cloudkms.googleapis.com | DATA_READ, DATA_WRITE, ADMIN_READ | AU-2, AU-12 |
| iam.googleapis.com | DATA_READ, DATA_WRITE, ADMIN_READ | AU-2, AU-12 |

## Key lesson

Data Access logs are off by default in GCP. Every organization that hasn't explicitly enabled them is missing audit records for every storage read, KMS operation, and IAM change. This is the most common finding in GCP compliance assessments.

## Evidence

- `evidence/lab-5-4/iam-policy.json` — IAM policy output capturing Data Access logs configuration

## GitHub Actions WIF usage

```yaml
permissions:
  id-token: write
  contents: read

steps:
  - uses: google-github-actions/auth@v2
    with:
      workload_identity_provider: ${{ steps.outputs.workload_identity_provider }}
      service_account: cgep-grc-gate-sa@project-5ff1b0f7-ade0-446d-b22.iam.gserviceaccount.com
```