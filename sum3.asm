data segment
	opr1 db 0ah,0dh,"Enter the first Number$"
	opr2 db 0ah,0dh,"Enter the second number$" 
	opr3 db 0ah,0dh,"INPUTTED NUMBER= $"	
	result db 0ah,0dh,"Result=$"
	
	
	num1 dw ?
	num2 dw ?
	num3 dw ?
	temp dw ?
	sum  dw ?

	display macro msg
		mov dx,offset msg
		mov ah,09h
		int 21h
		endm	

	read macro num	
		local l1,exit
		mov ah,01h	
		int 21h
		mov ah,00h	
		sub ax,0030h
		mov  num,ax
	l1:	mov ah,01h
		int 21h
		cmp al,0dh
		je exit
		mov ah,00h
		sub ax,0030h
		mov temp,ax
		mov ax,num
		mov bx,000ah
		mul bx	
		add ax,temp
		mov num,ax
		jmp l1
	exit:	nop
		endm

	print   macro num	
		local l2,l3
		mov ax,num	
		mov cx,0000h
	l2:	mov dx,0000h
		mov bx,000ah
		div bx
		push dx	
		inc cx 
		cmp ax,0000h
		jne l2
	l3:	pop dx
		add dx,0030h
		mov ah,02h	
		int 21h	
		loop l3	
		endm	

data ends

code segment
	assume cs:code ,ds:data
	start:	mov ax,data
		mov ds,ax
		display opr1
		read num1
		mov cx,num1
		
		display opr2
		read num2		
		mov bx,num2		

		display result
		add cx,bx

		mov sum,cx
		print sum	

		mov ah,4ch
		int 21h	


code ends
end start