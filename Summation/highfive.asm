%include "asm_io.inc"
%assign SYS_EXIT 1

; File:     highfive.asm
;
; Author:   Eric Wu, A00971904
;
; Date:     1/22/2020
;
; Description:
;   This program performs a basic summation of the 
;   integer array [100,200,300,400,500], and prints
;   the result at the end
;
; Compile & run:
;   $ make
;   $ ./highfive.exe

section .text
    global main
    extern printf

main:
    mov     eax, len    ;len of data arry
    push    eax           
    push    dword line1 ;string to print
    call    printf 
    add     esp, 8      ;pop from stack

    mov     ecx, len        ;len of data arry
    mov     ebx, data       ;data arry
    mov     edx, [result]   ;assign result to edx register

    print:
        push    ecx         ;save loop counter to stack

        cmp     ecx, len    ;if first iteration, dont print ','
        je      skip_first
        mov     al, ","
        call    print_char

        skip_first:
            mov     eax, [ebx]  ;mov element in data arry to eax register
            add     edx, eax    ;add sum
            call    print_int
            add     ebx, 4      ;increment to next index
            pop     ecx         ;retrieve loop counter from stack

        loop    print
        call    print_nl

    mov     eax, edx
    push    eax
    push    dword line3
    call    printf 
    add     esp, 8

    mov     eax, 1
    int     0x80

section .data
    data:   dd 100, 200, 300, 400, 500
    len:    equ ( $ - data ) / 4
    index:  db 0
    result: dd 0
    line1:  db "I have %d numbers:", 10, 0
    line3:  db "The total is: %d", 10, 0


    