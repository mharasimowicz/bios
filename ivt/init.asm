ivt_init:

    ; setting up interrupts
    push es
    mov ax, 0x0000
    mov es, ax
    cli
    ; 0x00 - divide by 0
    mov [es:0x0000], dword handle_int_0x00_divide_by_zero
    mov [es:0x0002], dword 0xf000 
    ; 0x01 - single step / reserved
    mov [es:0x0004], dword handle_int_0x01_single_step
    mov [es:0x0006], dword 0xf000
    ; 0x02 - power fail / NMI
    mov [es:0x0008], dword handle_int_0x02_nmi
    mov [es:0x000a], dword 0xf000
    ; 0x03 - breakpoint
    mov [es:0x000c], dword handle_int_0x03_breakpoint
    mov [es:0x000e], dword 0xf000
    ; 0x04 - overflow
    mov [es:0x0010], dword handle_int_0x04_overflow
    mov [es:0x0012], dword 0xf000
    ; 0x05 - bounds range exceeded
    mov [es:0x0014], dword handle_int_0x05_bounds_range_exceeded
    mov [es:0x0016], dword 0xf000
    ; 0x06 - invalid opcode
    mov [es:0x0018], dword handle_int_0x06_invalid_opcode
    mov [es:0x001a], dword 0xf000
    ; 0x07 - device not available
    mov [es:0x001c], dword handle_int_0x07_device_na
    mov [es:0x001e], dword 0xf000
    ; 0x08 - double fault
    mov [es:0x0020], dword handle_int_0x08_double_fault
    mov [es:0x0022], dword 0xf000
    ; 0x09 - coprocessor segment overrun
    mov [es:0x0024], dword handle_int_0x09_coprocessor_segment_overrun
    mov [es:0x0026], dword 0xf000
    ; 0x0a - invalid TSS
    mov [es:0x0028], dword handle_int_0x0a_invalid_tss
    mov [es:0x002a], dword 0xf000
    ; 0x0b - segment not present
    mov [es:0x002c], dword handle_int_0x0b_segment_not_present
    mov [es:0x002e], dword 0xf000
    ; 0x0c - stack segment fault
    mov [es:0x0030], dword handle_int_0x0c_stack_segment_fault
    mov [es:0x0032], dword 0xf000
    ; 0x0d - general protection fault
    mov [es:0x0034], dword handle_int_0x0d_general_protection_fault
    mov [es:0x0036], dword 0xf000
    ; 0x0e - page fault
    mov [es:0x0038], dword handle_int_0x0e_page_fault
    mov [es:0x003a], dword 0xf000
    ; 0x0f - reserved
    mov [es:0x003c], dword not_implemented
    mov [es:0x003e], dword 0xf000
    ; 0x10 - x87 fpu error
    mov [es:0x0040], dword not_implemented
    mov [es:0x0042], dword 0xf000
    ; 0x11 - alignment check
    mov [es:0x0044], dword not_implemented
    mov [es:0x0046], dword 0xf000
    ; 0x12 - machine check
    mov [es:0x0048], dword not_implemented
    mov [es:0x004a], dword 0xf000
    ; 0x13 - simd floating-point exception
    mov [es:0x0048], dword not_implemented
    mov [es:0x004a], dword 0xf000
    ; 0x14 - unk
    mov [es:0x004c], dword not_implemented
    mov [es:0x004e], dword 0xf000
    ; 0x15 - unk
    mov [es:0x0050], dword not_implemented
    mov [es:0x0052], dword 0xf000  
    ; 0x16 - unk
    mov [es:0x0054], dword not_implemented
    mov [es:0x0056], dword 0xf000
    ; 0x17 - unk
    mov [es:0x0058], dword not_implemented
    mov [es:0x005a], dword 0xf000
    ; 0x18 - unk
    mov [es:0x005c], dword not_implemented
    mov [es:0x005e], dword 0xf000
    ; 0x19 - unk
    mov [es:0x0060], dword not_implemented
    mov [es:0x0062], dword 0xf000  
    ; 0x1a - unk
    mov [es:0x0064], dword not_implemented
    mov [es:0x0066], dword 0xf000
    ; 0x1b - unk
    mov [es:0x0068], dword not_implemented
    mov [es:0x006a], dword 0xf000
    ; 0x1c - unk
    mov [es:0x006c], dword not_implemented
    mov [es:0x006e], dword 0xf000
    ; 0x1d - unk
    mov [es:0x0070], dword not_implemented
    mov [es:0x0072], dword 0xf000
    ; 0x1e - unk
    mov [es:0x0074], dword not_implemented
    mov [es:0x0076], dword 0xf000
    ; 0x1f - unk
    mov [es:0x0078], dword not_implemented
    mov [es:0x007a], dword 0xf000

    ; 0x20-0xff - others..
    mov bx, 0x7c
    set_interrupt:
    mov [es:bx], dword not_implemented
    add bx, 2
    mov [es:bx], dword 0xf000
    add bx, 2
    cmp bx, 0x0400
    jl set_interrupt
    xor bx, bx

    sti
    pop es
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