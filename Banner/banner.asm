%include "asm_io.inc"
%assign SYS_EXIT 1

; File:     banner.asm
;
; Author:   Eric Wu, A00971904
;
; Date:     1/22/2020
;
; Description:
;   The program prints a banner with student ID
;   name, greeting message and some unique non
;   ASCII character
;
; Compile & run:
;   $ make
;   $ ./banner.exe

section .text
    global main
    extern printf

main:
    mov ebx, data       ;filler character array
    mov ecx, len        ;banner height
    mov eax, 0          ;initialize index to 0
    mov [index], eax    
    outter:
        push ecx

        cmp ecx, 3      ;print name and greeting instead of filler
        je name_and_greeting

        mov ecx, 50     ;banner width
        inner:
            push ecx
            
            mov edx, 1
            mov ecx, data
            add ecx, [index]    ;filler character
            mov ebx, 1
            mov eax, 4
            int 0x80   

            pop ecx
        loop inner 
        jmp skip

        name_and_greeting:
            push    dword greeting  ;print name and greeting
            call    printf 
            add     esp, 4 

        skip:

        mov eax, 1
        add [index], eax

        call print_nl

        pop ecx
    loop outter

    mov     eax, 1  ;exit
    int     0x80

section .data
    data:     db "=", "*", "-", "*", "="
    len:      equ $ - data
    greeting: db "--------------- MEME saved my life ---------------", 10
    name:     db "---------------- Eric Wu A00961904 ---------------", 10
    six:      times 25 db `\u905b`

section .bss
    index resb 1