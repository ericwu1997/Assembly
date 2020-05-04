%include "asm_io.inc"
%include "utils.inc"
%assign SYS_EXIT 1

; File:     script.asm

; Author:   Eric Wu, A00971904

; Date:     1/26/2020

; Description:
; This calculates check digit from user input
; 11 digit product code

; Compile & run:
; $ make

section .text
    global main
    extern printf

main:
    call print_nl

    display_prompt welcome_msg, welcome_msg_len ; welcome message
    display_prompt prompt, prompt_len           ; prompt user for input
    scan_input data, 11                         ; scan number from input and store it
    char_arry_to_int data, index, 11            ; convert char string to int
    upc_cal data, index, 11, result

    mov eax, [result]                           ; prints result M to console
    push eax
    push line
    call printf
    add esp, 8

    exit 0

section .data
    welcome_msg: db "Welcome to Elmo's Amazing UPC Calculator", 10, 0
    welcome_msg_len: equ $ - welcome_msg
    prompt: db "Please input 11 digit: ", 0
    prompt_len: equ $ - prompt
    line: db "M: %d", 10, 0
    result: dd 0                                ; data has to be last, because I scan 1 extra char 'enter' that
    data: times 11 db 0                         ; overwrites the first char of next memory block

section .bss
    index resb 1