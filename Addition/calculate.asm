%include "asm_io.inc"
%assign SYS_EXIT 0

; File:     calculate.asm

; Author:   Eric Wu, A00971904

; Date:     1/30/2020

; Description:
; This simple program prompts user
; for two integer, adds them and
; prints the result on console

; Compile & run:
; $ make

section .text
    global main
    extern printf
    extern scanf

addtwo:
    enter 0, 0
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    add eax, ebx
    leave
    ret

main:
    push prompt1      ; ask for first input
    call printf
    add esp, 4

    push tmp          ; scan first input
    push format
    call scanf
    add esp, 8

    push dword [tmp]  ; pushing 4 byte on to stack

    push prompt2      ; ask for second input
    call printf
    add esp, 4

    push tmp          ; scan second input
    push format
    call scanf
    add esp, 8

    push dword [tmp]  ; pushing 4 byte on to stack

    call addtwo       ; return value in eax
    add esp, 8

    push eax
    push output
    call printf
    add esp, 8

    mov eax, SYS_EXIT ; exit
    int 0x80

section .data
    prompt1: db "Please enter 1st number: ", 0
    prompt2: db "Please enter 2nd number: ", 0
    tmp: dd 0
    format: db "%d", 0
    output: db "Result is: %d", 10, 0
section .bss
