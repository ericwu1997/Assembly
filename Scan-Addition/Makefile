OUTPUT=calculate.exe
all: $(OUTPUT) clean run
run: $(OUTPUT)
	clear
	./$(OUTPUT)
$(OUTPUT): asm_io.o calculate.o
	gcc -o $(OUTPUT) -m32 asm_io.o calculate.o
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
calculate.o: calculate.asm
	nasm -f elf32 -d ELF_TYPE calculate.asm
clean:
	rm *.o
