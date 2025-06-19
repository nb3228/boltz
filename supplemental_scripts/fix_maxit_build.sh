#!/usr/bin/env bash
set -euo pipefail

RCSBROOT=/home/username/maxit-v11.300; export RCSBROOT
PATH="$RCSBROOT/bin:"$PATH; export PATH

# 0. Ensure we’re in the MAXIT source root
if [ ! -d etc ] || [ ! -d cif-file-v1.0 ]; then
  echo "Error: run this from the maxit-v11.300-prod-src directory." >&2
  exit 1
fi


# Helper to install a package if missing
ensure_pkg() {
  local pkg=$1
  if ! command -v "$pkg" &>/dev/null; then
    echo "Installing missing package: $pkg"
    sudo apt-get update
    sudo apt-get install -y "$pkg"
  else
    echo "Found $pkg"
  fi
}

echo "=== Checking build dependencies ==="
ensure_pkg bison
ensure_pkg flex
ensure_pkg clang++

echo "=== 1. Patch etc/platform.sh ==="
sed -i '/^    Linux)/,/^    ;;/c\
    Linux)\
        # On any modern Linux (GCC ≥ 8), just use the gnu8 configuration\
        sysid="gnu8"\
        ;;' etc/platform.sh

echo "=== 2. Patch make.platform.* to disable overloaded-virtual errors ==="
find etc -type f -name 'make.platform.*' \
  -exec sed -i 's/^WARNINGS_AS_ERRORS=-Werror.*/WARNINGS_AS_ERRORS=-Werror -Wno-error=overloaded-virtual/' {} \;

echo "=== 3. Patch vflib-2.0.6/Makefile ==="
sed -i '/^include \.\.\/etc\/Makefile\.platform$/a \
CXXFLAGS += -Wno-error=overloaded-virtual' vflib-2.0.6/Makefile

echo "=== 4. Force Clang in filterlib-v10.1 ==="
grep -q '^CCC=clang++' filterlib-v10.1/Makefile || \
  sed -i '1iCCC=clang++' filterlib-v10.1/Makefile


echo "=== 5. Fixing ProcessDataBlockName in DICParserBase.C ==="
sed -i 's/if\s*(\s*&(\s*Glob_dataBlockNameDIC\s*)\[5\]\s*&&\s*(strlen\s*(\s*&(\s*Glob_dataBlockNameDIC\s*)\[5\]\s*)>0\s*)\s*)\s*{/if (Glob_dataBlockNameDIC \&\& strlen(Glob_dataBlockNameDIC) > 5 \&\& strlen(Glob_dataBlockNameDIC + 5) > 0) {/' cifparse-obj-v7.0/src/DICParserBase.C


echo "=== 6. Value-initialize STRAND in Promotif_Sheet.C ==="
sed -i 's|^[[:space:]]*STRAND str;|            STRAND str{};|' \
    annotation-v1.0/src/Promotif_Sheet.C

echo "=== 7. Running make ==="
make clean
make 
make binary


echo "Done - MAXIT has been patched and installed successfully."

echo "Use to run standalone:"
echo "export RCSBROOT="$HOME/maxit-v11.300-prod-src""
echo "export PATH="$RCSBROOT/bin:$PATH""
echo " "
echo "Example"
echo "maxit -input INPUT.pdb -output OUTPUT.cif -o 1"

