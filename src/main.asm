org 0x7c00
bits 16

jmp pagrindine
; si - string pointeris
atspausdink:
	push si
	push ax
ciklas:
	lodsb
	cmp al, 0
	jz baige
	mov ah, 0x0E
	int 10h
	jmp ciklas
baige:
	pop ax
	pop si
	ret
;

pargindine:
	mov ax, 0
	mov bx, 0
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7c00

	mov si, [zinute]
	call atspausdink
	
	hlt

pabaiga:
	jmp $

times 510-($-$$) db 0
dw 0AA55h
