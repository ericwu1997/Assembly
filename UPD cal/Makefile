OUTPUT=upc_a_cal.exe
all: $(OUTPUT) clean run
run: $(OUTPUT)
	clear
	./$(OUTPUT)
$(OUTPUT): asm_io.o script.o
	gcc -o $(OUTPUT) -m32 asm_io.o script.o
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
script.o: script.asm
	nasm -f elf32 -d ELF_TYPE script.asm
clean:
	rm *.o
