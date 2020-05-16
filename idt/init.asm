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

idt_ptr:
dw idt_end - idt_start
dd idt_start

idt_start:


idt_end:

; IDT_ADDRESS equ 0x000f0900

; times IDT_ADDRESS - ($-$$) db 0

; idt_ptr:
; dw 0x1234
; dd 0x87654321

; START_ADDRESS equ 0x000f1000

; times START_ADDRESS - ($-$$) db 0

; main loop