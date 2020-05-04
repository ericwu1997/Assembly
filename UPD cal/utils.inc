%macro display_prompt 2
    mov   eax, 4        ; prompt
    mov   ebx, 1
    mov   ecx, %1
    mov   edx, %2
    int   80h
%endmacro

%macro scan_input 2
    mov eax, 3          ; scan input and store it
    mov ebx, 2
    mov ecx, %1
    mov edx, %2
    add edx, 1
    int 80h
%endmacro

%macro char_arry_to_int 3
    mov ecx, %3
    mov eax, 0          ; initialize index to 0
    mov [%2], eax
    convert:
        push ecx

        mov ebx, %1
        add ebx, [%2]
        mov eax, [ebx]
        sub eax, '0'
        mov [ebx], eax

        mov eax, [%2]   ; increment index by one
        add eax, 1
        mov [%2], eax

        pop ecx
    loop convert

%endmacro

%macro display 3
    mov ecx, %3
    mov eax, 0          ; initialize index to 0
    mov [%2], eax
    print:
        push ecx

        mov edx, 1      ; print element at current index
        mov ecx, %1
        add ecx, [%2]
        add byte [ecx], 48
        mov ebx, 1
        mov eax, 4
        int 0x80

        mov eax, [%2]   ; increment index by one
        add eax, 1
        mov [%2], eax

        pop ecx
    loop print
%endmacro


%macro upc_cal 4
    mov ecx, %3
    mov eax, 0          ; initialize index to 0
    mov [%2], eax       ; initialize result to 0
    mov ebx, %4         ; load addr of result to ebx
    mov edx, 3
    process:
        push ecx

        mov ecx, %1     ; get number from data array
        add ecx, [%2]

        mov al, [%2]    ; determine odd or even position
        test al, 1
        jnz odd
        jz even
        odd:
            mov al, [ecx]

            jmp add
        even:
            mov edx, 3
            mov al, [ecx]
            mul edx

            jmp add
        add:
        add [ebx], al

        mov ecx, [%2]   ; increment index by one
        add ecx, 1
        mov [%2], ecx

        pop ecx
    loop process

    cdq                 ; divide result by 10 and get remainent
    mov eax, [ebx]
    mov ecx, 10
    idiv ecx

    cmp edx, 0          ; chekc if is 0, if it is, M = 10 - Ms
    je return           ; otherwise just return it
    mov ebx, 10
    sub ebx, edx
    mov edx, ebx

    return:
        mov [%4], edx
%endmacro

%macro exit 1
    mov eax, %1
    int 0x80
%endmacro