# Boltz-2 Capabilities and Usage

Boltz-2 predicts protein structures, protein–protein complexes, protein–ligand complexes and ligand binding affinities. It can run on GPUs, CPUs and TPUs and can automatically generate MSAs using the ColabFold server.

The main command is:

```bash
boltz predict <INPUT_PATH> [OPTIONS]
```

`<INPUT_PATH>` should be a YAML or FASTA file describing the molecules you want to model. When a directory is provided, all `.yaml` and `.fasta` files inside are processed.

Commonly used options:

| Option | Default | Description |
| --- | --- | --- |
| `--out_dir PATH` | `./` | Where to save predictions |
| `--devices INT` | `1` | Number of devices to use |
| `--accelerator [gpu|cpu|tpu]` | `gpu` | Hardware backend |
| `--sampling_steps INT` | `200` | Diffusion steps for structure prediction |
| `--diffusion_samples INT` | `1` | Number of sampled structures |
| `--use_msa_server` | | Request MSAs from the ColabFold server |
| `--use_potentials` | | Enable inference-time potentials |
| `--output_format [pdb|mmcif]` | `mmcif` | Structure file format |

Run `boltz predict --help` for the full list of options and descriptions.

## Workflows

### Single Protein

```
boltz predict examples/prot.yaml --out_dir results
```

### Protein–Protein Complex

```
boltz predict examples/multimer.yaml --use_msa_server
```

### Protein–Ligand Complex with Affinity

```
boltz predict examples/affinity.yaml --use_msa_server --diffusion_samples_affinity 5
```

