banner.exe: asm_io.o banner.o
	gcc -o banner.exe -m32 banner.o asm_io.o
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
banner.o: banner.asm
	nasm -f elf32 -d ELF_TYPE banner.asm