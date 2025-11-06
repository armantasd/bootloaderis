global prtchr ; (char c, int index)
section .text
prtchr:
	push ebp
	mov ebp, esp
	mov eax, [ebp+12]
	mov ebx, [ebp+8]
	add eax, 0xB8000
	mov byte [eax], bl
	mov byte [eax+1], 0x0F
	pop ebp
	ret
