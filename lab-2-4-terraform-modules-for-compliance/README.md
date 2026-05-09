# compliant-gcs-bucket

A Terraform module that enforces the following NIST 800-53 controls on a single GCS bucket:

- **SC-12** – Cryptographic key establishment via Cloud KMS keyring (customer-managed).
- **SC-13** – Cryptographic protection using CMEK AES-256 with 90-day key rotation.
- **SC-28** – Protection of data at rest via CMEK encryption on all objects.
- **AU-11** – Object versioning and retention policy to protect audit records.
- **CM-6** – Required labels (project, environment, managed_by, compliance_scope) enforced on every bucket.
- **AC-3** – Uniform bucket-level access and public access prevention set to enforced.