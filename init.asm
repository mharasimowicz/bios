;16 bit mode
[bits 16]

times 0xf0000 - ($-$$) db 0

; main loop
__start:
mov ax, 0x0000
mov es, ax
mov ds, ax
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx

; setting up stack to 0xfffe
mov ax, 0x0000
mov ss, ax
mov sp, 0xfffe

; setting up segments
mov ax, cs
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax

call ivt_init
call gdt_init
call idt_init

jmp $


%include "ivt\init.asm"
%include "gdt\init.asm"
%include "idt\init.asm"



;%include "enter_protected_mode.asm"
; padding for initial step
times 0xffff0 - ($-$$) db 0

; jumping to start
jmp 0xf000:0x0000 ;__start

times 0x100000 - ($-$$) db 0