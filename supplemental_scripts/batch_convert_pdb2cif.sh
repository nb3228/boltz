#!/usr/bin/env bash
#
# batch_convert.sh
#
# Convert all PDB files in SRC_DIR into mmCIF files in DST_DIR
# using MAXIT: maxit -input protein.pdb -output protein.cif -o 1
export RCSBROOT="$HOME/maxit-v11.300-prod-src"
export PATH="$RCSBROOT/bin:$PATH"

set -euo pipefail                  # exit on error, undefined var, or failed pipe 
shopt -s nullglob                  # make *.pdb expand to empty list if no matches 

# --- Configuration: update these paths as needed ---
SRC_DIR="DIR_WITH_PDBS"          # directory containing .pdb files 
DST_DIR="DIR_FOR_CIFS"           # directory for output .cif files

# Makes sure source directory exists
if [ ! -d "$SRC_DIR" ]; then
  echo "Error: source directory '$SRC_DIR' not found." >&2
  exit 1
fi

# Create destination directory if missing
mkdir -p "$DST_DIR"                

# Loop over each PDB file
for pdb in "$SRC_DIR"/*.pdb; do    # only .pdb files, skipping others 
  [ -f "$pdb" ] || continue        # skip if no real file 
  base=$(basename "$pdb" .pdb)     # extract filename without directory 
  out="$DST_DIR/$base.cif"
  echo "Converting '$pdb' → '$out'"

  # MAXIT for conversion
  maxit -input "$pdb" \
        -output "$out" \
        -o 1                         # 1 = mmCIF output format 
done
