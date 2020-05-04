%include "asm_io.inc"
%include "./utils/input_to_decimal.inc"
%assign SYS_EXIT 0

; File:     factorial.asm

; Author:   Eric Wu, A00971904

; Date:     1/30/2020

; Description:
; This simple program prompts user for an integer
; , calculate factorial number using that input
; and display the result on console. Note that the
; the input only accepts up to 2 digit

; Compile & run:
; $ make

section .text
    global main
    extern printf

factorial:
    enter 0, 0              ; multiplies eax by ebx and places result in edx:ecx
    mov ebx, [ebp + 8]
    call proc_fact
    leave
    ret

proc_fact:
    mov edx, 0
    cmp bl, 1
    jg do_calculation
    mov eax, 1
    mov [result], eax
    ret

do_calculation:
    cmp edx, 0              ; if overflow bit set, skip the iteration
    jne next
    dec   ebx
    call  proc_fact
    inc   ebx

    mov eax, [result]
    mul ebx                 ; EDX:EAX = EAX*EBX
    mov [result], eax       ; save result
    mov ecx, edx            ; save carried part in ECX

    mov eax, [result+4]
    mul ebx
    add eax, ecx            ; add carried part from previous multiplication
    mov [result+4], eax
    mov ecx, edx

    cmp edx, 0              ; check for overflow bit
    jne set_of_bit
    jmp next

    set_of_bit:             ; set overflow bit
        mov [of_bit], edx
    next:                   ; zero out edx if no overflow occurs
        mov edx, 0
    ret


main:
    scan_int                ; result stores in eax

    push eax
    call factorial
    add esp, 4

    mov edx, [of_bit]       ; check if overflow bit set after the calculation
    cmp edx, 0
    jne overflow

    no_overflow:
        mov eax, [result]   ; move lower 32 bit to eax
        mov edx, [result+4] ; move upper 32 bit to edx

        push edx            ; prints integer in edx:eax
        push eax
        push strFormat
        call printf
        add esp, 12

        ; dump_regs 0         ; For debugging

        mov eax, SYS_EXIT   ; exit
        int 0x80
        jmp done

    overflow:
        push error
        call printf
        add esp, 4
        mov eax, SYS_EXIT   ; exit
        int 0x80

    done:

section .data
    of_bit: dd 0
    error: db "Dont blame me, an overflow occured!", 10, 0
    strFormat: db "The Factorial is: %lld", 10, 0
    result: dd 0            ; zero out 64 bit memory space for storing factiruak result
            dd 0

section .bss
