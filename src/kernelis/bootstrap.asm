org 0xb000
bits 16
jmp pargindine

gdt_start:
	; null descriptor
	dq 0x0
	; code segment
	dw 0xffff
	dw 0x0000
	db 0x00
	db 0x9a
	db 0xcf
	db 0x00
	; data segment
	dw 0xffff
	dw 0x0000
	db 0x00
	db 0x92
	db 0xcf
	db 0x00
	; user code segment
	dw 0xffff
	dw 0x0000
	db 0x00
	db 0xfa
	db 0xcf
	db 0x00
	; user data segment
	dw 0xffff
	dw 0x0000
	db 0x00
	db 0xf2
	db 0xcf
	db 0x00
	; tast state segment
	dw 0x0067 ; SIX SEVEN!!!! (reference not intended)
	dw tss
	db 0
	db 0x89
	db 0x00
	db 0
	
gdt_end:
gdt_descriptor:
	dw gdt_end - gdt_start - 1
	dd gdt_start

tss:
	times 148 db 0 ; preping for 64 bit long mode

sgdt_start:
	; null descriptor
	dq 0
	dq 0
	; kernel code segment
	dw 0xffff
	dw 0
	db 0
	db 0x9a
	db 0xaf
	db 0
	dq 0
	; kernel data segment
	dw 0xffff
	dw 0
	db 0
	db 0x92
	db 0xcf
	db 0
	dq 0
	; user mode data segment
	dw 0xffff
	dw 0
	db 0
	db 0xf2
	db 0xcf
	db 0
	dq 0
	; user mode code segment
	dw 0xffff
	dw 0
	db 0
	db 0xfa
	db 0xaf
	db 0
	dq 0
	; tss segment
	dw 0x93
	dw tss
	db 0
	db 0x89
	db 0x0
	db 0
	dq 0
sgdt_end:

sgdt_descriptor:
	dw sgdt_end - sgdt_start - 1
	dd sgdt_start

pargindine:
	; clear VGA
	mov ax, 0x0003
	int 0x10
	; switch to 32 bit
	cli
	lgdt [gdt_descriptor]
	xor ax, ax
	mov bx, 0x0
	mov fs, bx
	mov gs, bx
	mov ds, bx
	mov es, bx
	mov ss, bx
	mov sp, 0x7c00
	xor bx, bx
	mov eax, cr0
	or al, 1
	mov cr0, eax
	jmp 0x08:bootstrap_end
bootstrap_end:
