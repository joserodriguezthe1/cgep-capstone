# Compliance Policies

Rego policy library for the CGE-P capstone. Each policy maps to a NIST 800-53 control.

| Policy | Control | Severity | What it checks |
|--------|---------|----------|----------------|
| sc28_encryption.rego | SC-28 | High | Every google_storage_bucket has a CMEK encryption block |
| ac3_no_public.rego | AC-3 | Critical | Buckets have uniform access + public prevention enforced; firewalls don't expose ports 22 or 3389 to 0.0.0.0/0 |
| cm6_required_tags.rego | CM-6 | Medium | Every taggable resource carries project, environment, managed_by, compliance_scope labels |

## Remediation

- **SC-28**: Add `encryption { default_kms_key_name = ... }` block referencing a `google_kms_crypto_key` you control.
- **AC-3**: Set `uniform_bucket_level_access = true` and `public_access_prevention = "enforced"`. For firewalls, narrow `source_ranges` or remove the rule.
- **CM-6**: Add the four required labels to every taggable resource.

## Running the suite

```
opa test -v policies/
opa eval -d policies -i terraform/plan.json data.compliance.sc28.deny --format=pretty
opa eval -d policies -i terraform/plan.json data.compliance.ac3.deny  --format=pretty
opa eval -d policies -i terraform/plan.json data.compliance.cm6.deny  --format=pretty
```