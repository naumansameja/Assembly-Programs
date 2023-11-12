; This Program takes input in hexadecimal and prints it in decimal.
dosseg
.model small
.stack 100h
.386
.data
prompt db "Please enter a number in hexadecimal, press enter to end the input : $"
decimal db "Your number in decimal is : $"
new_line db 10,13,"$"
.code
main proc
mov ax,@data
mov ds,ax
; prompt the user to input the number
; number can be upto 4 digits in hexadecimal

mov dx,offset prompt
mov ah,09
int 21h

; takes input in bx
call take_input
mov dx, offset new_line
mov ah,09
int 21h
mov dx,offset decimal
mov ah,09
int 21h

; moves the input number from bx to ax
mov ax,bx
; uses bx as divisor
mov bx,10
call get_num
mov ah,4ch
int 21h


main endp
take_input proc
mov cx,4
mov bx,0
input_loop:
mov ah,01
int 21h
;in case user ends input early by pressing enter
cmp al,13
je end_input
; if the number is above 39h, it means it is an alphabet
cmp al,39h
ja alpha
; else it  is a number (below 10)
sub al,30h
jmp exit

alpha:
sub al,37h

exit:
rol bx,4
and al,0fh
add bl,al
dec cx
jnz input_loop

end_input:
ret


take_input endp
get_num proc
mov cx,0
fill_loop:
mov dx,0
div bx
push dx
inc cx
cmp ax,0
jne fill_loop

output_loop:
pop dx
call print_num
dec cx
jnz output_loop

ret
get_num endp


print_num proc
add dx,30h
mov ah,02
int 21h
ret
print_num endp

; get_num proc
; mov cx,0
; again:
; mov dx,0
; div bx
; push dx
; inc cx
; cmp ax,0
; jne again

; print_loop:
; pop dx
; call print_num
; dec cx 
; jnz print_loop
; ret
; get_num endp

; print_num proc
; add dx,30h
; cmp dx,39h
; jbe exitp
; add dx,7h
; exitp:
; mov ah,02
; int 21h
; ret
; print_num endp

end main
