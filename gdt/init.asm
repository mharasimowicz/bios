; we are going to store GDT on this address
GDT_ADDRESS equ 0x00000800


gdt_init:
    cli
    ; set offset
    xor   eax, eax
    mov   ax, ds
    shl   eax, 4
    add   eax, gdt_null_segment
    mov   [GDT_ADDRESS + 2], eax
    ; set size
    mov   eax, gdt_end
    sub   eax, gdt_null_segment    
    mov   [GDT_ADDRESS], ax
    ; load GDT
    lgdt  [GDT_ADDRESS]
    sti
    ; cleanup
    xor   eax, eax
    ret
    

; Basic GDT structure
; null segment (required)
gdt_null_segment:
    ; limit 0-15
    db 0
    db 0
    ; base 0-15
    db 0
    db 0
    ; base 16-23
    db 0
    ; access
    db 0
    ; limit_16-19 + flags
    db 0
    ; base 24-31
    db 0

; code segment
gdt_code_segment:
    ; limit 0-15
    db 0xFF
    db 0xFF
    ; base 0-15
    db 0
    db 0
    ; base 16-23
    db 0
    ; access
    db 0x9A ; code segment
    ; limit_16-19 + flags
    db 0xFC ; 4kb blocks & 32bit
    ; base 24-31
    db 0

; data segment
gdt_data_segment:
    ; limit 0-15
    db 0xFF
    db 0xFF
    ; base 0-15
    db 0
    db 0
    ; base 16-23
    db 0
    ; access
    db 0x92 ; data segment
    ; limit_16-19 + flags
    db 0xFC
    ; base 24-31
    db 0

; user code segment
gdt_user_code_segment:
    ; limit 0-15
    db 0xFF
    db 0xFF
    ; base 0-15
    db 0
    db 0
    ; base 16-23
    db 0
    ; access
    db 0xFA ; user code segment
    ; limit_16-19 + flags
    db 0xFC
    ; base 24-31
    db 0

; user data segment
gdt_user_data_segment:
    ; limit 0-15
    db 0xFF
    db 0xFF
    ; base 0-15
    db 0
    db 0
    ; base 16-23
    db 0
    ; access
    db 0xF2 ; user data segment
    ; limit_16-19 + flags
    db 0xFC
    ; base 24-31
    db 0

gdt_end:
;