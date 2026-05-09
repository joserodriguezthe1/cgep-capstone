# Lab 2-5: IaC as Compliance Evidence

This lab builds an immutable evidence vault on AWS S3 and a capture script that bundles, hashes, and uploads Terraform evidence with a recorded VersionId.

## What this lab demonstrates

- **Chain of custody** — integrity, attribution, and reproducibility of compliance evidence
- **S3 Object Lock** — GOVERNANCE mode prevents deletion during the retention window
- **Evidence capture** — `capture-evidence.sh` collects plan.json, state.json, git commit, and Terraform version, hashes each file, bundles them, and uploads to the vault
- **Immutability proof** — deletion attempt returns `AccessDenied because object protected by object lock`

## Controls enforced on the vault

- **SC-28** — AES-256 encryption at rest
- **AC-3** — Public access fully blocked
- **AU-9** — Object Lock prevents evidence tampering or deletion
- **CM-6** — Required tags on all resources

## Key outputs

- `evidence/receipt.json` — run_id, vault name, S3 key, VersionId, and timestamp of the captured bundle
- `scripts/capture-evidence.sh` — reusable capture script used by Lab 4.3's CI pipeline

## Note

This vault is reused throughout the capstone. Every lab that produces evidence uploads to this bucket using the same capture pattern.