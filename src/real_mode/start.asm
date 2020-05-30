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

;
; this is entry of real mode
;

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