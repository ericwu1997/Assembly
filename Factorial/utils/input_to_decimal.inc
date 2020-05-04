%macro scan_int 0
    mov edx, msg_len       ; welcome message
    mov ecx, welcome_msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, prompt_len ; prompt for input
    mov ecx, prompt
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax, 3          ; scan input and store it
    mov ebx, 0
    mov ecx, input_buf
    int 80h
    sub eax, 1

    cmp eax, 2
    jae double_digit

    single_digit:
    mov al, byte [input_buf]
    sub eax, '0'
    jmp convertion_completed

    double_digit:
    mov al, byte [input_buf]
    sub eax, '0'
    mov bl, 10
    mul bl
    mov bl, byte [input_buf + 1]
    sub ebx, '0'
    add eax, ebx

    convertion_completed:
%endmacro

section .data
    welcome_msg: db "Thanks for using Eric Wu's Factorial Calculator", 10, 0
    msg_len: equ $ - welcome_msg
    prompt: db "Please enter a number: ", 0
    prompt_len: equ $ - prompt
section .bss
    input_buf: resb 256