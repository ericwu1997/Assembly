%include "asm_io.inc"

; File:     7eleven.asm

; Author:   Eric Wu, A00971904

; Date:     2/20/2020

; Description:
; This simple program simulates 
; convenient store shopping 

; Compile & run:
; $ make

segment .data
        welcome:   db "Welcome to Eric's 7-eleven store!  ", 10, 0
        prompt:    db "Please enter your quantity here.", 10, 0
        item1      db "    Slurpees ($10 each): ", 0
        item2      db "    Hotdogs ($20 each): ", 0
        item3      db "    Chips ($30 each): ", 0  
        total:     db  "Your total in dolars is: ", 0
        item1_cost  dd 10
        item2_cost  dd 20
        item3_cost  dd 30

segment .bss
result  resd 1

segment .text
        global  main

main:
        mov     eax, welcome		
        call    print_string		 
        mov     eax, prompt		
        call    print_string

        ;----------------------------------------------------
        ; get quantities and calculate running total
        ;----------------------------------------------------

        xor     ebx, ebx                        ; addded 
        xor     eax, eax                        ; addded 
        
        mov     eax, item1			
        call    print_string		
        call    read_int			; get number into eax
        imul    byte [item1_cost]               ; addded 
        add     bl, al                          ; addded 

        mov     eax, item2			
        call    print_string		
        call    read_int
        imul    byte [item2_cost]               ; addded 	
        add     bl, al		                ; addded 

        mov     eax, item3  		
        call    print_string		
        call    read_int
        imul    byte [item3_cost]               ; addded 	
        add     bl, al	                        ; addded 

        ; dump_regs 0                           ; addded  

        ;------------------------------------
        ; print the grand total 
        ;------------------------------------
        mov     eax, total
        call    print_string
        mov     eax, ebx                        ; addded 
        call    print_int
        call    print_nl
	

