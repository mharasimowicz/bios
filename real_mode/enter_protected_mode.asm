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

; Change into 32bit mode from 16bit mode.
enter_protected_mode:
    ;Disable irqs (and clear direction flag)
    cli
    cld

disable_nmi:
    xor eax, eax
    in al, 0x70
    or al, 0x80
    out 0x70, al

enable_a20_line:
    in al, 0x92
    or al, 2
    out 0x92, al

    call copy_gdt

    lgdt [gdt_ptr]
    ;lidt [idt_ptr]

set_segment_descriptors:
    mov cx, 0x10
    mov ds, cx
    mov es, cx
    mov ss, cx
    mov fs, cx
    mov gs, cx
    
enable_protected_mode:
    mov eax, cr0 
    or al, 1       ; set PE (Protection Enable) bit in CR0 (Control Register 0)
    mov cr0, eax

jump_to_32bit_mode:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    jmp 0x08:start_32bit_protected_mode_code
