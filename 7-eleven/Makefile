OUTPUT=7eleven
all: $(OUTPUT).exe clean run
run: $(OUTPUT).exe
	clear
	./$(OUTPUT).exe
$(OUTPUT).exe: asm_io.o  $(OUTPUT).o
	gcc -o $(OUTPUT).exe -m32 asm_io.o $(OUTPUT).o
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
 $(OUTPUT).o:  $(OUTPUT).asm
	nasm -f elf32 -d ELF_TYPE $(OUTPUT).asm -l $(OUTPUT).lst
clean:
	rm *.o
