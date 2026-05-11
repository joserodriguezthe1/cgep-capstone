# Lab 6.1 OSCAL Documents

OSCAL (Open Security Controls Assessment Language) machine-readable compliance documentation for the CGE-P capstone.

## Structure
component-definitions/
└── compliant-s3-v1/
└── component-definition.json   ← describes the Lab 2.3 compliant-s3 module
profiles/
└── cge-p-minimum/
└── profile.json                ← selects sc-28, ac-3, au-3, cm-6 from NIST 800-53
catalogs/
└── cge-p-minimum-resolved/
└── catalog.json                ← resolved flat list of selected controls

## Components

| Component | Module | Controls implemented |
|-----------|--------|---------------------|
| compliant-s3-v1 | lab-2-3-first-compliant-resource | SC-28, AC-3, AU-3 |

## Evidence chain

Each implemented-requirement in the component definition contains a `links[rel=evidence].href` pointing at a signed bundle in the Lab 2.5 vault:
s3://cgep-lab-grc-evidence-vault-ddbffd9c/runs/lab-5-2-findings/bundle.tar.gz

To verify the chain:
```bash
EVIDENCE_VAULT=cgep-lab-grc-evidence-vault-ddbffd9c \
  bash ../lab-4-4-evidence-management-chain-of-custody/scripts/verify-evidence.sh \
  lab-5-2-findings --profile default
```

## Validation

Both documents validated by trestle:
trestle validate -f component-definitions/compliant-s3-v1/component-definition.json
trestle validate -f profiles/cge-p-minimum/profile.json

Output captured in `evidence/lab-6-1/trestle-validate.txt`.