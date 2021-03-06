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

ivt_init:

    ; setting up interrupts
    mov ax, 0x0000
    mov es, ax
    cli

    mov ax, cs
    ; 0x00 - divide by 0
    mov [es:0x0000], dword handle_int_0x00_divide_by_zero
    mov [es:0x0002], ax 
    ; 0x01 - single step / reserved
    mov [es:0x0004], dword handle_int_0x01_single_step
    mov [es:0x0006], ax
    ; 0x02 - power fail / NMI
    mov [es:0x0008], dword handle_int_0x02_nmi
    mov [es:0x000a], ax
    ; 0x03 - breakpoint
    mov [es:0x000c], dword handle_int_0x03_breakpoint
    mov [es:0x000e], ax
    ; 0x04 - overflow
    mov [es:0x0010], dword handle_int_0x04_overflow
    mov [es:0x0012], ax
    ; 0x05 - bounds range exceeded
    mov [es:0x0014], dword handle_int_0x05_bounds_range_exceeded
    mov [es:0x0016], ax
    ; 0x06 - invalid opcode
    mov [es:0x0018], dword handle_int_0x06_invalid_opcode
    mov [es:0x001a], ax
    ; 0x07 - device not available
    mov [es:0x001c], dword handle_int_0x07_device_na
    mov [es:0x001e], ax
    ; 0x08 - double fault
    mov [es:0x0020], dword handle_int_0x08_double_fault
    mov [es:0x0022], ax
    ; 0x09 - coprocessor segment overrun
    mov [es:0x0024], dword handle_int_0x09_coprocessor_segment_overrun
    mov [es:0x0026], ax
    ; 0x0a - invalid TSS
    mov [es:0x0028], dword handle_int_0x0a_invalid_tss
    mov [es:0x002a], ax
    ; 0x0b - segment not present
    mov [es:0x002c], dword handle_int_0x0b_segment_not_present
    mov [es:0x002e], ax
    ; 0x0c - stack segment fault
    mov [es:0x0030], dword handle_int_0x0c_stack_segment_fault
    mov [es:0x0032], ax
    ; 0x0d - general protection fault
    mov [es:0x0034], dword handle_int_0x0d_general_protection_fault
    mov [es:0x0036], ax
    ; 0x0e - page fault
    mov [es:0x0038], dword handle_int_0x0e_page_fault
    mov [es:0x003a], ax
    ; 0x0f - reserved
    mov [es:0x003c], dword not_implemented
    mov [es:0x003e], ax
    ; 0x10 - x87 fpu error
    mov [es:0x0040], dword not_implemented
    mov [es:0x0042], ax
    ; 0x11 - alignment check
    mov [es:0x0044], dword not_implemented
    mov [es:0x0046], ax
    ; 0x12 - machine check
    mov [es:0x0048], dword not_implemented
    mov [es:0x004a], ax
    ; 0x13 - simd floating-point exception
    mov [es:0x0048], dword not_implemented
    mov [es:0x004a], ax
    ; 0x14 - unk
    mov [es:0x004c], dword not_implemented
    mov [es:0x004e], ax
    ; 0x15 - unk
    mov [es:0x0050], dword not_implemented
    mov [es:0x0052], ax  
    ; 0x16 - unk
    mov [es:0x0054], dword not_implemented
    mov [es:0x0056], ax
    ; 0x17 - unk
    mov [es:0x0058], dword not_implemented
    mov [es:0x005a], ax
    ; 0x18 - unk
    mov [es:0x005c], dword not_implemented
    mov [es:0x005e], ax
    ; 0x19 - unk
    mov [es:0x0060], dword not_implemented
    mov [es:0x0062], ax  
    ; 0x1a - unk
    mov [es:0x0064], dword not_implemented
    mov [es:0x0066], ax
    ; 0x1b - unk
    mov [es:0x0068], dword not_implemented
    mov [es:0x006a], ax
    ; 0x1c - unk
    mov [es:0x006c], dword not_implemented
    mov [es:0x006e], ax
    ; 0x1d - unk
    mov [es:0x0070], dword not_implemented
    mov [es:0x0072], ax
    ; 0x1e - unk
    mov [es:0x0074], dword not_implemented
    mov [es:0x0076], ax
    ; 0x1f - unk
    mov [es:0x0078], dword not_implemented
    mov [es:0x007a], ax

    ; 0x20-0xff - others..
    mov bx, 0x007c
    set_interrupt:
    mov [es:bx], dword not_implemented
    add bx, 2
    mov [es:bx], ax
    add bx, 2
    cmp bx, 0x0400
    jl set_interrupt
    xor ax, ax
    xor bx, bx

    sti
    ret

handle_int_0x00_divide_by_zero:
    mov ebx, 0xaa00
    jmp $

handle_int_0x01_single_step:
    mov ebx, 0xaa01
    jmp $

handle_int_0x02_nmi:
    mov ebx, 0xaa02
    jmp $

handle_int_0x03_breakpoint:
    mov ebx, 0xaa03
    jmp $

handle_int_0x04_overflow:
    mov ebx, 0xaa04
    jmp $

handle_int_0x05_bounds_range_exceeded:
    mov ebx, 0xaa05
    jmp $

handle_int_0x06_invalid_opcode:
    mov ebx, 0xaa06
    jmp $

handle_int_0x07_device_na:
    mov ebx, 0xaa07
    jmp $

handle_int_0x08_double_fault:
    mov ebx, 0xaa08
    jmp $

handle_int_0x09_coprocessor_segment_overrun:
    mov ebx, 0xaa09
    jmp $

handle_int_0x0a_invalid_tss:
    mov ebx, 0xaa0a
    jmp $

handle_int_0x0b_segment_not_present:
    mov ebx, 0xaa0b
    jmp $

handle_int_0x0c_stack_segment_fault:
    mov ebx, 0xaa0c
    jmp $

handle_int_0x0d_general_protection_fault:
    mov ebx, 0xaa0d
    jmp $

handle_int_0x0e_page_fault:
    mov ebx, 0xaa0e
    jmp $

not_implemented:
    mov ebx, 0xABCD
    jmp $