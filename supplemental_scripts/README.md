
# MAXIT Installation for PDB to mmCIF conversion

(build fixed on WSL2 Ubuntu-24.04)


## Dependencies and downloads

Install dependencies:
```
apt-get install bison
apt-get install flex
apt-get install clang
```
Download and extract MAXIT:
```
wget https://sw-tools.rcsb.org/apps/MAXIT/maxit-v11.300-prod-src.tar.gz
zcat maxit-v11.300-prod-src.tar.gz | tar -xf - 
```

Move into maxit-v11.300-prod-src and download build fixer for v11.3:
```
cd maxit-v11.300-prod-src
wget -L https://raw.githubusercontent.com/nb3228/boltz/main/supplemental_scripts/fix_maxit_build.sh
```
Run build fixer:
```
bash fix_maxit_build.sh         
```


## Optional: Download batch converter script:
```
wget -L https://raw.githubusercontent.com/nb3228/boltz/main/supplemental_scripts/batch_convert_pdb2cif.sh
```
Original Source (Outdated)

 - [https://sw-tools.rcsb.org/apps/MAXIT/index.html](https://sw-tools.rcsb.org/apps/MAXIT/index.html)
 - [https://sw-tools.rcsb.org/apps/MAXIT/source.html](https://sw-tools.rcsb.org/apps/MAXIT/source.html)
 - [https://sw-tools.rcsb.org/apps/MAXIT/README-source](https://sw-tools.rcsb.org/apps/MAXIT/README-source)
