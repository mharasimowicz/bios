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

[bits 32]

; 0x90 - NOP will mean unused/uninitialized memory
%define NOT_INITIALIZED_OPCODE      0x90
%define DATA_SEGMENT                0x10
%define PROTECTED_MODE_STACK_START  0x00001000

; alignment addresses
%define GDT64_ALIGNMENT             0x1000
%define PROTECTED_MODE_CODE_SIZE    0xbff0

start_32bit_protected_mode_code:
    sti
    ; woohooo we are in the protected mode!
flush_segment_registers:
    mov eax, dword DATA_SEGMENT
    mov es, ax
    mov ds, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov esp, PROTECTED_MODE_STACK_START
    mov eax, dword [es:0x0000]
    mov eax, dword [ds:0x0000]
    mov eax, dword [fs:0x0000]
    mov eax, dword [gs:0x0000]
    mov eax, dword [ss:0x0000]
    xor eax, eax

reenable_nmi:

    in al, 0x70
    and al, 0x7f
    out 0x70, al


    ;jmp enter_long_mode

    mov eax, dword 0xcccc7777
    ; we should not be here
    ;hlt
    jmp $

end_start_32bit_protected_mode_code:
enter_long_mode:
    ;Disable irqs
    ;cli
    mov eax, 0xccbbaa00

    jmp $

times GDT64_ALIGNMENT - ($-$$) db NOT_INITIALIZED_OPCODE
%include "./src/gdt64/data.asm"
%include "./src/gdt64/copy.asm"

; padding
times PROTECTED_MODE_CODE_SIZE - ($-$$) db NOT_INITIALIZED_OPCODE
