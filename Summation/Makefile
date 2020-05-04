highfive.exe: asm_io.o highfive.o
	gcc -o highfive.exe -m32 asm_io.o highfive.o
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
highfive.o: highfive.asm
	nasm -f elf32 -d ELF_TYPE highfive.asm