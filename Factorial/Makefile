OUTPUT=factorial.exe
all: $(OUTPUT) clean run
run: $(OUTPUT)
	clear
	./$(OUTPUT)
$(OUTPUT): asm_io.o factorial.o
	gcc -o $(OUTPUT) -m32 asm_io.o factorial.o
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
factorial.o: factorial.asm
	nasm -f elf32 -d ELF_TYPE factorial.asm
clean:
	rm *.o
