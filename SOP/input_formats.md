# Input File Formats

Boltz-2 accepts inputs either in YAML or FASTA format. YAML files enable advanced features such as pocket constraints and affinity prediction, while FASTA files provide a simple line-based syntax for basic predictions.

## YAML

A YAML input contains one or more sequences. Each entry specifies the entity type (`protein`, `dna`, `rna` or `ligand`) and optional metadata.

```yaml
version: 1
sequences:
  - protein:
      id: A
      sequence: MVTPEGNVSLVD...
      msa: ./msa/a.a3m
  - ligand:
      id: B
      smiles: "N[C@@H](Cc1ccc(O)cc1)C(=O)O"
```

## FASTA

FASTA entries follow the format `>CHAIN_ID|ENTITY_TYPE|MSA_PATH`. MSA paths are only required for proteins. Use `empty` to run single-sequence mode.

```fasta
>A|protein|./msa/a.a3m
MVTPEGNVSLVD...
```

## Examples

Example files demonstrating different workflows are located in `SOP/examples`:

- `protein.yaml` and `protein.fasta` – single protein chain
- `protein_ligand.yaml` – protein–ligand complex
- `protein_complex.yaml` – protein–protein complex

