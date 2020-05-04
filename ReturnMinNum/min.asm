%include "asm_io.inc"

; File:     min.asm

; Author:   Eric Wu, A00961904

; Date:     03/05/2020

; Description:
; This simple program accept user
; for two integer inputs, compare both
; integer, and print the one that is
; smaller in terms of value in decimal

; Compile & run:
; $ make

segment .text
    global main
    extern printf                                       ; import the printf fucntion

main:
    mov eax, welcome
    call print_string

    mov eax, prompt1                                    ; in this section, we are scanning for first
    call print_string                                   ; integer from user, and keep it in variable "tmp"
    call read_int                                       ; so we can use it for comparison later
    mov [tmp], eax

    mov eax, prompt2                                    ; in this section, we are scanning for second
    call print_string                                   ; integer from user, and keep it in eax so we
    call read_int                                       ; can use it for comparison later

    cmp eax, [tmp]
    jge GREATER_EQUAL                                   ; check if the second integer is greater or equal to
                                                        ; first integer. If is greater, jump to GREATER_EQUAL
                                                        ; directive, otherwise just go to LESS directive
    ;dump_regs 0                                         ; for debugging, checking content of register

    LESS:                                               ; the second integer is smaller than first integer
        push eax
        jmp DONE                                        ; skip and proceed to output the result

    GREATER_EQUAL:                                      ; the first integer is smaller than second integer
        mov eax, [tmp]
        push eax
        jmp DONE                                        ; skip and proceed to output the result

    DONE:                                               ; now that we have determine the smaller number
        push output                                     ; and push to eax, print the output and exit
        call printf
        add esp, 8                                      ; pop off push data from stack after done with printing

        mov eax, 1                                      ; exit the program
        int 80h

segment .data
    welcome: db "Welcome to Eric Wu's Min Calculator!  ", 10, 0 ; welcome message
    prompt1: db "Please enter your first number: ", 0   ; prompt for scanning first integer
    prompt2: db "Please enter your next number: ", 0    ; prompt for scanning second integer
    output: db "The min number is: %d", 10, 0           ; output string for printing final result
    tmp: db 0                                           ; variable for keeping first integer