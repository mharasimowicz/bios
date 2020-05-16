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


; here we are coping GDT from 0xF1000 to 0x01000

copy_gdt:
    xor eax, eax
    mov es, ax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx

copy_gdt_ptr:
    mov eax, gdt_ptr
    mov bx, word [cs:eax + 0]
    mov ecx, dword [cs:eax + 2]
    mov [es:eax + 0], word bx ; size
    mov [es:eax + 2], dword ecx ; address

copy_gdt_data:
    mov edx, ecx
    mov eax, edx
    add eax, ebx
    
copy_single_gdt_byte:
    mov bl, byte [cs:edx]
    mov [es:edx], byte bl

    inc edx
    cmp edx, eax
    jl copy_single_gdt_byte
copy_gdt_done:
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    ret