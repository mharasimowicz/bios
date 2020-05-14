;16 bit mode
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

; setting up stack to 0x10000
mov ax, 0x1000
mov si, ax
mov sp, 0x0000

; setting up interrupts
mov ax, 0x0000
mov ds, ax
cli
; divide by 0
mov [ds:0x0000], dword handle_divide_by_zero_interrupt
mov [ds:0x0002], dword 0xf000 
; single step
mov [ds:0x0004], dword handle_single_step_interrupt
mov [ds:0x0006], dword 0xf000
;power fail
mov [ds:0x0008], dword handle_power_fail_interrupt
mov [ds:0x000a], dword 0xf000
;breakpoint
mov [ds:0x000c], dword handle_breakpoint
mov [ds:0x000e], dword 0xf000
;overflow
mov [ds:0x0010], dword handle_overflow
mov [ds:0x0012], dword 0xf000 
sti
hlt
xor ax, ax
zonc:
inc ax
jmp zonc

handle_divide_by_zero_interrupt:
jmp $
handle_single_step_interrupt:
jmp $
handle_power_fail_interrupt:
jmp $
handle_breakpoint:
jmp $
handle_overflow:
jmp $

; padding for initial step
times 0xffff0 - ($-$$) db 0

; jumping to start
jmp 0xf000:0x0000

times 0x100000 - ($-$$) db 0