; The program should display segment address followed by 
; collon followed by starting offset address then 16 bytes in 
; hexadecimal followed by their ASCII characters. 
; Then on new line, again segment address which remains ensame, 
; followed by offset address which is 10 more in hexadecimal 
; followed by next 16 bytes followed by their ASCII an so on till 8 lines.


dosseg
.model small
.stack 100h
.data
array db 31h, 32h,128 dup(30h)
new_line db 10,13,"$"
.code
main proc
mov ax,@data
mov ds,ax
mov cx,8
mov si, offset array
main_loop:
mov bx, @data
call print_4
mov dx,":"
mov ah,02
int 21h
mov bx,si
push bx
call print_4
call print_elements 
mov dx," "
mov ah,02
int 21h
pop bx
mov si, bx
call print_ascii
mov dx,offset new_line
mov ah,09
int 21h
dec cx
jnz main_loop

mov ah,4ch
int 21h
main endp
print_elements proc
push cx
mov cx,16
element_loop:
mov dx," "
mov ah,02
int 21h
mov ah,0
mov al, [si]
mov bx, 16

call get_num
inc si
dec cx
jnz element_loop
pop cx
ret
print_elements endp

print_ascii proc
push cx
mov cx,16
ascii_loop:
mov dx,[si]
mov ah,02
int 21h
inc si
dec cx
jnz ascii_loop
pop cx
ret
print_ascii endp

print_4 proc
push cx
mov cx,4
again_1:
rol bx,1
rol bx,1
rol bx,1
rol bx,1
mov al,bl
and al,0fh
cmp al,9
ja print_alpha
mov dl,al
add dl,30h
mov ah,02
int 21h
jmp end_loop
print_alpha:
mov dl,al
add dl,55
mov ah,02
int 21h
end_loop:
dec cx
jnz again_1
pop cx
ret
print_4 endp



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
