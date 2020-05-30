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


; here we are coping IDT (with handlers code) from 0xF1200 to 0x01200

copy_idt:
    xor eax, eax
    mov es, ax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    mov edx, idt_ptr
    mov eax, idt_handlers_end
copy_single_idt_byte:
    mov bl, byte [cs:edx]
    mov [es:edx], byte bl

    inc edx
    cmp edx, eax
    jl copy_single_idt_byte
copy_idt_done:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    ret