dosseg
.model small
.stack 100h
.data
array dw  25, 2005,3004
decimal db "In decimal it is : $" 
binary db "In binary it is : $"
hex db "In hex it is : $"

new_line db 10,13,"$"
.code



main proc
mov ax,@data
mov ds,ax
mov cx,3
mov si, offset array

main_loop:


mov dx,offset decimal
call print_line
mov ax, [si]
mov bx,10
call get_num


mov dx,offset new_line
call print_line
mov dx,offset binary
call print_line
mov ax,[si]
mov bx,2
call get_num


mov dx,offset new_line
call print_line
mov dx,offset hex
call print_line
mov ax,[si]
mov bx,16
call get_num


mov dx,offset new_line
call print_line
call print_line


add si,2
dec cx 
jnz main_loop

mov ah,4ch
int 21h
main endp


get_num proc
push cx
mov cx,0
again:
mov dx,0
div bx
push dx
inc cx
cmp ax,0
jne again

print_loop:
pop dx
call print_num
dec cx 
jnz print_loop

pop cx
ret
get_num endp

print_num proc
add dx,30h
cmp dx,39h
jbe exit
add dx,7h
exit:
mov ah,02
int 21h
ret
print_num endp

print_line proc
mov ah,09
int 21h
ret
print_line endp 



end main
