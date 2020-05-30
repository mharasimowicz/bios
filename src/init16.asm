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

; 0x90 - NOP will mean unused/uninitialized memory
%define NOT_INITIALIZED_OPCODE      0x90

; alignment addresses
%define GDT_ALIGNMENT               0x1000
%define IDT_ALIGNMENT               0x1100
%define REAL_MODE_CODE_ALIGNMENT    0x2000
%define REAL_MODE_START_ALIGNMENT   0x3000
%define PROTECTED_MODE_ALIGNMENT    0x4000

times GDT_ALIGNMENT - ($-$$) db NOT_INITIALIZED_OPCODE 
%include "./src/gdt/data.asm"
%include "./src/gdt/copy.asm"

times IDT_ALIGNMENT - ($-$$) db NOT_INITIALIZED_OPCODE 
%include "./src/idt/data.asm"
%include "./src/idt/copy.asm"

times REAL_MODE_CODE_ALIGNMENT - ($-$$) db NOT_INITIALIZED_OPCODE
%include "./src/real_mode/ivt_init.asm"
%include "./src/real_mode/enter_protected_mode.asm"
%include "./src/real_mode/copy_32bit_code.asm"

times REAL_MODE_START_ALIGNMENT - ($-$$) db NOT_INITIALIZED_OPCODE
%include "./src/real_mode/start.asm"

;32 bit mode code
times PROTECTED_MODE_ALIGNMENT - ($-$$) db NOT_INITIALIZED_OPCODE
start_32bit_protected_mode_code: