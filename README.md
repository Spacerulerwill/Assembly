# Assembly
Assembly language experiments written with X86-64 GNU assembly (GAS) on linux

# Build Instructions
Some files will not need the C standard library and will be marked at the top of the file as such. To compile these files and run these files: 
```bash
gcc file.s -o file -static -nostdlib
./file
```
Otherwise:
```bash
gcc file.s -o file -static
./file
```
