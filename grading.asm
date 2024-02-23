.model small
.stack 100h
.386
.data
	marks db 60 dup(0)
	ids db 60 dup(0)
	num db 0
	
	m1 db 'Enter the number system you want to input in, h for Hex, b for Binary and d for Decimal: $'
	m11 db 10,13,'Invalid input, Enter again: $'
	m2 db 10,13,'Enter number of students (does not exceed 60 students): $'
	m3 db 10,13,'Invlid number of students, cannot exceed 60, Enter again: $'
	m4 db 10,13,'Enter ID numbers of students one by one: $'
	m51 db 10,13, 'Enter total marks of the subject: $'
	m5 db 10,13, 'REMEMBER! Total marks are $'
	m6 db 10,13,'Enter marks of ID No. $'
	m7 db ': $'        
	m8 db 10,13,'Invalid marks, Enter again: $'
	m9 db 10,13,'*******************Graded Classroom***********************$'
	m10 db 10,13,'ID ',09H,'MARKS',09H,'GRADE$'
	line db 10,13,'$'
	total db 100



.code
;if user chooses decimal number system this function is called
decin proc
mov dx, offset m2
mov ah, 09
int 21h
again1: call input
cmp bl, 60
ja invalid
mov si, offset num
mov [si], bl
jmp next0
invalid: mov dx, offset m3
mov ah,09
int 21h
jmp again1
next0: mov dx, offset m51
mov ah, 09
int 21h
call input
mov si, offset total
mov [si], bl
mov dx, offset m4
mov ah,09
int 21h
mov si, offset ids
mov di, offset num
mov cl, [di]
whil: call input
mov [si], bx
mov dx, offset line
mov ah, 09
int 21h
inc si
dec cl
jnz whil

mov dx, offset m5
mov ah, 09
int 21h
mov si, offset total
mov al, [si]
and ax, 00FFh
mov bx, 10
call display

mov si, offset ids
mov di, offset marks
mov cl, num
marking: mov dx,offset m6
mov ah,09
int 21h

mov al, [si]
and ax, 00FFh
mov bx, 10
call display
mov dx,offset m7
mov ah,09
int 21h

calling: call input
cmp bl, total
ja inv
mov [di], bx
jmp itr
inv:mov dx, offset m8
mov ah,09
int 21h
jmp calling
itr: inc si
inc di
dec cl
jnz marking

ret
decin endp

;if user chooses binary this func is called
binin proc
mov dx, offset m2
mov ah, 09
int 21h
again3: call bin_input
cmp bl, 60
ja invalid2
mov si, offset num
mov [si], bl
jmp next2
invalid2: mov dx, offset m3
mov ah,09
int 21h
jmp again3

next2: mov dx, offset m51
mov ah, 09
int 21h
call bin_input
mov si, offset total
mov [si], bl

mov dx, offset m4
mov ah,09
int 21h
mov si, offset ids
mov di, offset num
mov cl, [di]
whil2: call bin_input
mov [si], bx
mov dx, offset line
mov ah, 09
int 21h
inc si
dec cl
jnz whil2

mov dx, offset m5
mov ah, 09
int 21h
mov si, offset total
mov al, [si]
and ax, 00FFh
mov bx, 10
call display



mov si, offset ids
mov di, offset marks
mov cl, num
marking2: mov dx,offset m6
mov ah,09
int 21h
mov al, [si]
and ax, 00FFh
mov bx, 2
call display
mov dx,offset m7
mov ah,09
int 21h
calling2: call bin_input
cmp bl, total
ja inv2
mov [di], bx
jmp itr2
inv2:mov dx, offset m8
mov ah,09
int 21h
jmp calling2
itr2: inc si
inc di
dec cl
jnz marking2

ret
binin endp


;if user chooses hexadecimal this func is called

hexin proc
mov dx, offset m2
mov ah, 09
int 21h
again2: call hex_input
cmp bl, 60
ja invalid1
mov si, offset num
mov [si], bl
jmp next1
invalid1: mov dx, offset m3
mov ah,09
int 21h
jmp again2

next1: mov dx, offset m51
mov ah, 09
int 21h
call hex_input
mov si, offset total
mov [si], bl

mov dx, offset m4
mov ah,09
int 21h
mov si, offset ids
mov di, offset num
mov cl, [di]
whil1: call hex_input
mov [si], bx
mov dx, offset line
mov ah, 09
int 21h
inc si
dec cl
jnz whil1

mov dx, offset m5
mov ah, 09
int 21h
mov si, offset total
mov al, [si]
and ax, 00FFh
mov bx, 10
call display


mov si, offset ids
mov di, offset marks
mov cl, num
marking1: mov dx,offset m6
mov ah,09
int 21h
mov al, [si]
and ax, 00FFh
mov bx, 16
call display
mov dx,offset m7
mov ah,09
int 21h
calling1: call hex_input
cmp bl, total
ja inv1
mov [di], bx
jmp itr1
inv1:mov dx, offset m8
mov ah,09
int 21h
jmp calling1
itr1: inc si
inc di
dec cl
jnz marking1

ret
hexin endp





input proc
push cx
mov bx,0
first1: mov ah,01
int 21h
cmp al, 13
je exit
and ax, 000Fh
loff:push ax
mov ax, 10
mul bx
pop bx
add bx, ax
jmp first1
exit: pop cx
ret
input endp

hex_input proc
push cx

mov bx, 0
mov cx, 2
fro: mov ah, 01
int 21h
cmp al, 13
je exiit
cmp al, 39h
ja alph
sub al, 30h
jmp itt
alph: sub al, 37h
itt: shl bl, 4
and al, 0Fh
or bl, al
dec cx
jnz fro
exiit: pop cx
ret
hex_input endp


bin_input proc
push cx

mov bx, 0
mov cx, 8
fro1: mov ah, 01
int 21h
cmp al, 13
je ext
sub al, 30h
shl bl, 1
and al,0Fh
or bl, al
dec cx
jnz fro1

ext: pop cx
ret
bin_input endp


display proc
push cx
mov cx,0

aa:
mov dx,0
div bx
push dx
inc cx
cmp ax,0
jne aa

printingloop:
pop dx
cmp dx, 9
ja alfa1
add dx,30h
mov ah,02
int 21h
jmp brak
alfa1:
add dx, 37h
mov ah,02
int 21h
brak: dec cx
jnz printingloop

pop cx
ret
display endp

sorting proc
mov cl, num
dec cl
sort1:mov si, offset marks
mov di, offset ids
mov ch, num
dec ch
sort2: mov al, [si]
mov bl, [si+1]
cmp al, bl
jae nxt1
mov [si], bl
mov [si+1], al
mov al, [di]
xchg al, [di+1]
mov [di], al
nxt1: inc si
inc di
dec ch
jnz sort2
dec cl
jnz sort1
ret 
sorting endp

show proc
mov si, offset num
mov cl, [si]
mov si, offset ids
mov di, offset marks
mov dx, offset m10
mov ah, 09
int 21h
letsgo:mov dx, offset line
mov ah,09
int 21h
mov al, [si]
and ax, 00FFh
mov bx, 10
call display
mov dx, 09h
mov ah, 02
int 21h
mov al, [di]
and ax, 00FFh
mov bx, 10
call display
mov dx, 09h
mov ah, 02
int 21h
mov bl, [di]
call get_grade
mov ah,02
int 21h
inc si
inc di
dec cl
jnz letsgo

ret
show endp

;bl marks
;
;Percentage to get the grade ((marks x 100) / total)

get_grade proc
mov al, bl
mov bl, 100
mul bl
mov bx, offset total
mov dx, [bx]
mov bx, dx
and bx, 00FFh
mov dx, 0
div bx
mov bx, ax
cmp bx,85
jae agrade
cmp bx, 75
jae bgrade
cmp bx, 65
jae cgrade
cmp bx, 50
jae dgrade
mov dl, 'F'
jmp away0
agrade:mov dl, 'A'
jmp away0
bgrade:mov dl, 'B'
jmp away0
cgrade:mov dl, 'C'
jmp away0
dgrade:mov dl, 'D'
away0:
ret
get_grade endp


main proc

 mov ax, @data
 mov ds, ax
 mov dx, offset m1
 mov ah, 09
 int 21h
 again: mov ah, 01
 int 21h
 or al, 20h
 cmp al, 'h'
 je hexa
 cmp al, 'b'
 je binr
 cmp al, 'd'
 je dec1
 mov dx, offset line
 mov ah,09
 int 21h
 mov dx, offset m11
 mov ah,09
 int 21h
 jmp again
 hexa: call hexin
 jmp uganda
 binr: call binin
 jmp uganda
 dec1: call decin
 uganda: call sorting
 call show


mov ah,4ch
int 21h

main endp

end main









