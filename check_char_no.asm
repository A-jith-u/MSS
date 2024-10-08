

section .data
    msg1 db 'Enter the string:', 0xa
    len1 equ $ - msg1
    msg2 db 'Enter the character:', 0xa
    len2 equ $ - msg2
    msg3 db 'Character count:'
    len3 equ $ - msg3
    
section .bss
    str1 resb 100
    chr resb 1
    count resb 10
    
section .text
    global _start
    
_start:
    ; Print message to enter the string
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg1]
    mov edx, len1
    int 0x80
    
    ; Read the input string
    mov eax, 3
    mov ebx, 0
    lea ecx, [str1]
    mov edx, 100
    int 0x80
    
    ; Null-terminate the input string
    mov byte [str1 + eax - 1], 0
    
    ; Print message to enter the character
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg2]
    mov edx, len2
    int 0x80
    
    ; Read the character
    mov eax, 3
    mov ebx, 0
    lea ecx, [chr]
    mov edx, 1
    int 0x80
    
    ; Initialize counters
    xor ecx, ecx ; Count of characters matching
    lea esi, [str1] ; Source string pointer
    mov al, [chr] ; Character to count

count_loop:
    mov bl, [esi] ; Load current character from string
    cmp bl, 0 ; End of string check
    je done
    cmp bl, al ; Compare with target character
    jne next_char
    inc ecx ; Increment count if match
next_char:
    inc esi ; Move to the next character
    jmp count_loop
    
done:
    ; Store the count in `count`
    mov [count], ecx
    
    ; Print character count message
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg3]
    mov edx, len3
    int 0x80
    
    ; Convert the count to ASCII and print it
    mov eax, [count]
    add eax, '0' ; Convert to ASCII
    mov [count], al ; Store the ASCII character
    
    mov eax, 4
    mov ebx, 1
    lea ecx, [count]
    mov edx, 1 ; Print single character
    int 0x80
    
    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80


	
