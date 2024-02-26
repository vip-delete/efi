        org 7C00h

        mov ax, cs
        mov ds, ax         ; ds <- cs
        cld                ; inc si after lodsb

        mov ah, 0Eh        ; int 10h/0Eh: print character
        xor bx, bx         ; page number
        mov si, msg
        mov cx, len

.print: lodsb              ; same as mov al, [ds:si]
        int 10h
        loop .print

        xor ah, ah         ; int 16h/0: wait for any key
        int 16h

        jmp 0xF000:0xFFF0  ; reset vector address

msg     db 'The system started in Legacy BIOS mode, but EFI required.', 10, 13
        db 'Press any key to continue...', 10, 13
len     equ $ - msg
        times 510 - ($-$$) db 0
        dw 0xAA55
