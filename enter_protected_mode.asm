CMOS_RESET_CODE equ 0x0f
NMI_DISABLE_BIT equ 0x80
PORT_CMOS_INDEX equ 0x70
PORT_CMOS_DATA  equ 0x71
PORT_A20        equ 0x92
A20_ENABLE_BIT  equ 0x02

; Change into 32bit mode from 16bit mode.
; edx = return location (in 32bit mode)
; Clobbers: ecx, flags, segment registers, cr0, idt/gdt
enter_protected_mode:
    ;Disable irqs (and clear direction flag)
    cli
    cld

    ; Disable nmi
    mov ecx, eax
    mov eax, CMOS_RESET_CODE
    or eax, NMI_DISABLE_BIT
    out PORT_CMOS_INDEX, al
    in al, PORT_CMOS_DATA

    ; enable a20
    in al, PORT_A20
    or al, A20_ENABLE_BIT
    out PORT_A20, al
    mov eax, ecx

nmi_off:
    ; Set segment descriptors
    lidt [cs:pmode_IDT_info]
    lgdt [cs:rombios32_gdt_48]

    ; Enable protected mode
    mov ecx, cr0
    and ecx, $~(CR0_PG|CR0_CD|CR0_NW)
    or ecx, $CR0_PE
    mov cr0, ecx

    ; start 32bit protected mode code
    jmp $(BUILD_BIOS_ADDR + 1f), $SEG32_MODE32_CS

.code32
    ; init data segments
    mov ecx, $SEG32_MODE32_DS
    mov ds, cx
    mov es, cx
    mov ss, cx
    mov fs, cx
    mov gs, cx

    jmp [edx]