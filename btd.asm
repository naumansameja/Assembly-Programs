dosseg
.model small
.stack 100h
.data
prompt db "Please enter a string in binary, press enter to end the input : $"
decimal db "Your number in decimal is : $"
new_line db 10,13,"$"

.code
main proc
mov ax,@data
mov ds,ax
call take_input
mov dx, offset new_line
mov ah,09
int 21h
mov dx, offset decimal
mov ah,09
int 21h
mov ax,bx
mov bx,10
call get_num
mov ah,4ch
int 21h
main endp


take_input proc
mov dx, offset prompt
mov ah,09
int 21h
mov cx,16
mov bx,0
input_loop:
mov ah,01
int 21h
cmp al,13
je end_input
sub al,30h
rol bx,1
add bl,al
dec cx
jnz input_loop



end_input:
ret
take_input endp

get_num proc
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


end main