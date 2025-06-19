#!/usr/bin/env bash
#
# batch_convert.sh
#
# Convert all PDB files in SRC_DIR into mmCIF files in DST_DIR
# using MAXIT: maxit -input protein.pdb -output protein.cif -o 1
export RCSBROOT="$HOME/maxit-v11.300-prod-src"
export PATH="$RCSBROOT/bin:$PATH"

set -euo pipefail                  # exit on error, undefined var, or failed pipe :contentReference[oaicite:0]{index=0}
shopt -s nullglob                  # make *.pdb expand to empty list if no matches :contentReference[oaicite:1]{index=1}

# --- Configuration: update these paths as needed ---
SRC_DIR="DIR_WITH_PDBS"          # directory containing .pdb files :contentReference[oaicite:2]{index=2}
DST_DIR="DIR_FOR_CIFS"     # directory for output .cif files

# Ensure source directory exists
if [ ! -d "$SRC_DIR" ]; then
  echo "Error: source directory '$SRC_DIR' not found." >&2
  exit 1
fi

# Create destination directory if missing
mkdir -p "$DST_DIR"                # -p avoids error if it already exists :contentReference[oaicite:3]{index=3}

# Loop over each PDB file
for pdb in "$SRC_DIR"/*.pdb; do    # glob only .pdb files, skipping others :contentReference[oaicite:4]{index=4}
  [ -f "$pdb" ] || continue        # skip if no real file (e.g. nullglob) :contentReference[oaicite:5]{index=5}
  base=$(basename "$pdb" .pdb)     # extract filename without directory or extension :contentReference[oaicite:6]{index=6}
  out="$DST_DIR/$base.cif"
  echo "Converting '$pdb' → '$out'"

  # Invoke MAXIT for conversion
  maxit -input "$pdb" \
        -output "$out" \
        -o 1                         # 1 = mmCIF output format :contentReference[oaicite:7]{index=7}
done
