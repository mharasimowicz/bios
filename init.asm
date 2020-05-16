; SimpleBIOS
; Copyright (C) 2020 Michal Harasimowicz

; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <https://www.gnu.org/licenses/>.


;16 bit mode
[bits 16]

times 0x1000 - ($-$$) db 0x90 ; 0x90 - NOP will mean unused/uninitialized memory
%include "gdt\data.asm"
%include "gdt\copy.asm"

times 0x1100 - ($-$$) db 0x90 
%include "idt\data.asm"
%include "idt\copy.asm"

;32 bit mode code
[bits 32]
times 0x2000 - ($-$$) db 0x90
start_32bit_protected_mode_code:
    sti
    ; woohooo we are in the protected mode!
flush_segment_registers:
    mov ax, 0x10
    mov es, ax
    mov ds, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov eax, dword [es:0x0000]
    mov eax, dword [ds:0x0000]
    mov eax, dword [fs:0x0000]
    mov eax, dword [gs:0x0000]
    mov eax, dword [ss:0x0000]
    xor eax, eax

    jmp $

end_start_32bit_protected_mode_code:



[bits 16]
times 0x3000 - ($-$$) db 0x90

%include "real_mode\ivt_init.asm"
%include "real_mode\enter_protected_mode.asm"
%include "real_mode\copy_32bit_code.asm"

;
; this is entry of real mode
;
times 0x4000 - ($-$$) db 0x90
__start:

; setting up registers
xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx
mov ax, cs
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax

; setting up stack to 0x1000
mov ax, 0x0000
mov ss, ax
mov sp, 0x1000

call ivt_init
call copy_32bit_code

jmp enter_protected_mode
; we should not be here
mov eax, 0x0000dead
hlt
jmp $

; padding for initial step
times 0xfff0 - ($-$$) db 0x90
[bits 16]
; jumping to start
jmp 0xf000:__start

times 0x10000 - ($-$$) db 0x90