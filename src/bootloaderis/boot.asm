org 0x7c00
bits 16
jmp short pargindine
nop

; FAT12 headeris
bdb_oem: db 'MSWIN4.1'
bdb_sektoriaus_dydis: dw 512
bdb_sektoriai_per_clusteri: db 1
bdb_reservuoti_sektoriai: dw 1
bdb_fat_skaicius: db 2
bdb_dir_irasu_sk: dw 224
bdb_sektoriu_sk: dw 2880
bdb_media_desc_tipas: db 0xf0
bdb_sektoriai_per_fat: dw 9
bdb_sektoriai_per_trasa: dw 18
bdb_pusiu_sk: dw 2
bdb_paslepti_sektoriai: dd 0
bdb_dideliu_sektoriu_sk: dd 0
; boot irasas
ebr_drive_sk: db 0
db 0
ebr_zyme: db 0x29
ebr_turio_id: db 67, 67, 67, 67
ebr_turio_zyme: db 'VIEVERSYSOS'
ebr_sistemos_zyme: db 'FAT12   '

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

zinute: db "Labas", 0

times 510-($-$$) db 0
dw 0AA55h
