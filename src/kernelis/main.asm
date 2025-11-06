[bits 32]
global _start
extern kernel_main

_start:
	; set up VGA cursor
	mov dx, 0x3D4
	mov al, 0x0E
	out dx, al
	inc dx
	mov al, 0
	out dx, al
	dec dx
	mov al, 0x0F
	out dx, al
	inc dx
	mov al, 0
	out dx, al
    call kernel_main
    hlt
	jmp $
