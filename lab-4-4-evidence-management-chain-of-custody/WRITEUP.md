# Lab 4-4: Evidence Management & Chain of Custody

## Chain of Custody Properties

This lab demonstrates four properties that constitute a complete chain of custody for compliance evidence.

| Property | Definition | Artifact that proves it |
|----------|-----------|------------------------|
| **Authenticity** | The evidence was produced by a specific, verified identity | Cosign signature tied to GitHub OIDC subject (`repo:joserodriguezthe1/cgep-capstone:...`) |
| **Integrity** | The evidence has not been modified since it was created | SHA-256 sidecar file; any byte change breaks the hash |
| **Timeliness** | The evidence was created at a specific, verifiable moment | Sigstore Rekor transparency log timestamps the signature |
| **Completeness** | The evidence covers the full scope of what was assessed | Bundle contains plan.json, conftest-results.json, tfsec.sarif, plan.txt |

## How the chain works

1. A PR opens and the `grc-gate` workflow runs
2. Evidence files are bundled into `evidence-<run_id>-<sha>.tar.gz`
3. SHA-256 hash computed and stored as sidecar
4. Cosign signs the bundle using GitHub OIDC — no keys on disk
5. Sigstore Fulcio issues a short-lived certificate tied to the repo identity
6. Sigstore Rekor logs the signature with a timestamp
7. Bundle, hash, signature, and receipt uploaded to the Object Lock vault
8. Object Lock applies retention — deletion blocked for retention window

## How the chain breaks (and why it can't here)

| Attack | Defense |
|--------|---------|
| Tamper the bundle | SHA-256 mismatch detected by verify-evidence.sh |
| Replace the bundle | Object Lock blocks overwrite; new key = new run |
| Forge the signature | Cosign cert tied to GitHub OIDC — not forgeable without repo access |
| Delete the evidence | Object Lock GOVERNANCE mode blocks deletion |
| Backdate the evidence | Rekor transparency log is append-only and public |

## Verification

Run this to verify any evidence bundle:

```bash
EVIDENCE_VAULT=cgep-lab-grc-evidence-vault-ddbffd9c \
  bash scripts/verify-evidence.sh <run_id> --profile default
```

Expected output:
```
=== 1. Integrity (SHA-256) ===
  OK (...)
=== 2. Authenticity + timestamp (Cosign + Sigstore Rekor) ===
Verified OK
  OK (Cosign verified, Rekor entry exists)
=== 3. Preservation (Object Lock retention) ===
  OK (retain until ...)

CHAIN INTACT for run <run_id>
```