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
    ;int 0x00
    dw handle_idt_int_0x00  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000
    
    ;int 0x01
    dw handle_idt_int_0x01  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000
    
    ;int 0x02
    dw handle_idt_int_0x02  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

    ;int 0x03
    dw handle_idt_int_0x03  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000
    
    ;int 0x04
    dw handle_idt_int_0x04  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

    ;int 0x05
    dw handle_idt_int_0x05  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

    ;int 0x06
    dw handle_idt_int_0x06  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

    ;int 0x07
    dw handle_idt_int_0x07  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

    ;int 0x08
    dw handle_idt_int_0x08  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000
    
    ;int 0x09
    dw handle_idt_int_0x09  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000
    
    ;int 0x0a
    dw handle_idt_int_0x0a  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

    ;int 0x0b
    dw handle_idt_int_0x0b  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000
    
    ;int 0x0c
    dw handle_idt_int_0x0c  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

    ;int 0x0d
    dw handle_idt_int_0x0d  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

    ;int 0x0e
    dw handle_idt_int_0x0e  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

    ;int 0x0f
    dw handle_idt_int_0x0f  ; offset 0-15
    dw 0x0008               ; selector
    db 0                    ; unused
    db 10001110b            ; enabled - ring 0 32bit interrupt gate
    dw 0x0000

%rep 240
    dw handle_idt_int_not_implemented   ; offset 0-15
    dw 0x0008                           ; selector
    db 0                                ; unused
    db 10001110b                        ; enabled - ring 0 32bit interrupt gate
    dw 0x0000                           ; offset 16-31
%endrep

idt_end:

handle_idt_int_0x00:
    mov eax, 0xbb00
    jmp $

handle_idt_int_0x01:
    mov eax, 0xbb01
    jmp $

handle_idt_int_0x02:
    mov eax, 0xbb02
    jmp $

handle_idt_int_0x03:
    mov eax, 0xbb03
    jmp $

handle_idt_int_0x04:
    mov eax, 0xbb04
    jmp $

handle_idt_int_0x05:
    mov eax, 0xbb05
    jmp $

handle_idt_int_0x06:
    mov eax, 0xbb06
    jmp $

handle_idt_int_0x07:
    mov eax, 0xbb07
    jmp $

handle_idt_int_0x08:
    mov eax, 0xbb08
    jmp $

handle_idt_int_0x09:
    mov eax, 0xbb09
    jmp $

handle_idt_int_0x0a:
    mov eax, 0xbb0a
    jmp $

handle_idt_int_0x0b:
    mov eax, 0xbb0b
    jmp $

handle_idt_int_0x0c:
    mov eax, 0xbb0c
    jmp $

handle_idt_int_0x0d:
    mov eax, 0xbb0d
    jmp $

handle_idt_int_0x0e:
    mov eax, 0xbb0e
    jmp $

handle_idt_int_0x0f:
    mov eax, 0xbb0f
    jmp $

handle_idt_int_not_implemented:
    mov eax, 0xdddddd00
    jmp $

idt_handlers_end: