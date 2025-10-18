org 0x7c00
bits 16
jmp short start ; I had to do two jumps because jump short wasn't enough
nop

; FAT12 header (too lazy to translate that, it's a FAT12 header anyways lol)
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

start:
	jmp main

; si - string pointer
print_msg:
	push si
	push ax
print_loop:
	lodsb
	cmp al, 0
	jz end_print_loop
	mov ah, 0x0e
	int 10h
	jmp print_loop
end_print_loop:
	pop ax
	pop si
	ret
;

; - ibrahim's disk read chs
read_sector_chs:
    pusha
    mov ah, 0x02
    int 0x13
    jc .error
    popa
    clc
    ret
.error:
    popa
    stc
    ret
read_fail:
	mov si, disk_error_msg
;

; on the stack: buffer ptr, lba
disk_read:
	pusha
	mov bp, sp
	mov ax, word [bp+18] ; 8 16-bit registers + return address (holds lba)
	mov bx, word [bp+20] ; same thing + lba (holds buffer)
	xor dx, dx
	div word [bdb_sektoriai_per_trasa] ; divide by sectors per track
	mov cl, dl
	inc cl
	xor dx, dx
	div word [bdb_pusiu_sk] ; divide by the number of heads
	shl ax, 6
	or cx, ax
	shl dx, 8
	mov ah, 2
	mov al, 1
	call read_sector_chs
	jc read_fail
	popa
	ret
;
main:
	mov ax, 0
	mov bx, 0
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7c00

	mov si, welcome_message
	call print_msg

	push buffer
	push 2
	call disk_read

	hlt

end:
	jmp $

welcome_message: db "Labas", 0
disk_error_msg: db "Failed to read disk"

times 510-($-$$) db 0
dw 0AA55h

buffer resb 512
