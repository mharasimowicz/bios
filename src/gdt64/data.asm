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



gdt64_ptr:
dw gdt64_end - gdt64_start
dd gdt64_start

; Basic GDT structure
gdt64_start:
; null segment (required)
gdt64_null_segment:
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
gdt64_code_segment:
    ; limit 0-15
    db 0xFF
    db 0xFF
    ; base 0-15
    db 0
    db 0
    ; base 16-23
    db 0
    ; access
    db 10011010b ; code segment
    ; limit_16-19 + flags
    db 10101111b ; 4kb blocks & 32bit
    ; base 24-31
    db 0

; data segment
gdt64_data_segment:
    ; limit 0-15
    db 0xFF
    db 0xFF
    ; base 0-15
    db 0
    db 0
    ; base 16-23
    db 0
    ; access
    db 10010010b ; data segment
    ; limit_16-19 + flags
    db 10101111b
    ; base 24-31
    db 0

; user code segment
gdt64_user_code_segment:
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
    db 10101111b
    ; base 24-31
    db 0

; user data segment
gdt64_user_data_segment:
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
    db 10101111b
    ; base 24-31
    db 0

gdt64_end:
;