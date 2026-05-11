# AWS Security Services Baseline

Terraform module deploying the AWS-native compliance backbone for the CGE-P capstone.

## Services deployed

### CloudTrail
Multi-region trail with log-file validation enabled. Records all management events across every AWS region.

| Control | How CloudTrail satisfies it |
|---------|---------------------------|
| AU-2 | Records all management API calls as auditable events |
| AU-12 | Generates audit records for every action in every region |
| AU-10 | Log-file validation (digest files) proves logs haven't been tampered with |

### Security Hub
Aggregates findings from native AWS checks into one normalized view. Two standards subscribed:
- **NIST 800-53 Rev 5** — ~300 checks mapped to NIST controls
- **AWS Foundational Security Best Practices (FSBP)** — AWS-native security checks

| Control | How Security Hub satisfies it |
|---------|------------------------------|
| RA-5 | Continuous vulnerability scanning across all subscribed checks |
| SI-4 | Continuous monitoring of security posture with finding aggregation |

### AWS Config (optional)
If deployed, Config records resource configuration history and feeds Security Hub controls.

| Control | How Config satisfies it |
|---------|------------------------|
| CM-2 | Baseline configuration recorded for every resource |
| CM-6 | Configuration settings tracked and evaluated against rules |
| CM-8 | Complete inventory of all AWS resources maintained |

## Evidence

- `evidence/lab-5-2/security-hub-findings.json` — first wave of Security Hub findings captured as compliance evidence

## Evidence signing

The `security-hub-findings.json` file was captured and uploaded to the evidence vault via Lab 2.5's `capture-evidence.sh` script.

- **Vault:** `cgep-lab-grc-evidence-vault-ddbffd9c`
- **Run ID:** `lab-5-2-findings`
- **Version ID:** `5gYsCAHx4Jh7YN3iAQKp9d74.haDRm50`
- **Key:** `runs/lab-5-2-findings/bundle.tar.gz`

## Cost warning

Security Hub charges ~$0.001 per security check per month. Destroy same day to minimize cost.