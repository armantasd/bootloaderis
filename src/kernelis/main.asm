org 0xb000
bits 16

jmp pargindine
; si - string pointeris
atspausdink:
	push si
	push ax
ciklas:
	lodsb
	cmp al, 0
	jz baige
	mov ah, 0x0e
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

	mov si, zinute
	call atspausdink
	
	hlt

pabaiga:
	jmp $

zinute: db "Labas is kernelio!", 0x0D, 0xA, 0

times 510-($-$$) db 0
dw 0AA55h
