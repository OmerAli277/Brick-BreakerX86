[org 0x0100]
jmp start

start_game: db 0

inst: db 'PRESS I TO GO INTO INSTRUCTION BOX'
oldisr: dd 0
colume: dw 0
row: dw 0
incC: db 0
incR: db 0
previous: dw 0
tickcount: db 0
left_edge: dw 3524
right_edge dw 3652
right_: dw 0
left_: dw 0
pre_stack_pos: dw 3580

second: dw 0
minute: db 0
clock: db 0
bonus: dw 0

bricks_start_location: dw 810 , 828 , 846 , 864 , 882 , 900 , 918 , 936 , 1290 , 1308 , 1326 , 1344 , 1362, 1380, 1398 , 1416 , 1770 , 1788 , 1806 , 1824 , 1842 , 1860 , 1878 , 1896
bricks_end_location: dw 822 , 840 , 858 , 876 , 894 , 912 , 930 , 948 , 1302 , 1320 , 1338 , 1356 , 1374 , 1392 , 1414 , 1428 , 1782 , 1800  , 1818 , 1836 ,1854 , 1872 , 1890 , 1908

score: dw 0
total_bricks: dw 24
calculated_location:  dw 0
left_limit dw 0
right_limit dw 0
mid dw 0
left_or_right: db 0
preBall:dw 0

live: db 3
end_of_game: dw 0
StayOnStacker: db 0

counter: dw 0
solid: db 0
solid1: db 0




Lose_str: db 'YOU_LOSE'
Score_str: db 'SCORE'
Lives_str: db 'LIVES'

welcome_str: db 'WELCOME TO BRICK BREAKER'
option_str: db 'PLEASE SELECT OPTIONS'
instructions_str: db 'INSTRUCTION'
play_str: db 'PRESS ENTER TO PLAY GAME'

ttl_live_str: db 'YOUR TOTAL LIVES ARE 3'
bonus_note_str: db 'BONUS AWARDED IF BREAK ALL BRICKS IN 2 MINS' 
solid_base_str: db 'HITTING RED BRICK WILL SOLIDIFY YOUR BASE'

space_bar: db 'PRESS SPACE BAR TO RELEASE BALL'

total_score_str: db 'YOUR TOTAL SCORES :'
lives_remain_str: db 'LIVES REMAINING'
exit_str: db 'PRESS E TO EXIT'
quit_str: db 'PRESS ENTER+Q TO QUIT GAME'
restart_str: db 'PRESS ENTER+R TO RESTART YOUR GAME'

left_arrow: db 'USE RIGHT & LEFT ARROW TO MOVE BAR'

sound:
	push ax
	push bx
	mov al,182
	out 43h,al
	mov ax, 4560
	out 42h,al
	mov al,ah
	out 42h,al
	in al,61h
	or al,00000011
	out 61h,al
	mov bx,2
	pre:
	mov cx,65535
	pre1:
	dec cx
	jne pre1
	dec bx
	jne pre
	in al,61h
	and AL,11111100b
	out 61h,al 
	pop bx
	pop ax
	ret 


start_menu:
	push ax
	call clrscr
	
	mov ax , 690  ; row 6 col 25
	push ax
	mov ax ,welcome_str
	push ax
	mov ax , 24
	push ax
	
	call printstr_B
	
	
	mov ax , 1010
	push ax
	mov ax , option_str
	push ax
	mov ax , 21
	push ax
	
	call printstr
	
	
	mov ax , 1330
	push ax
	mov ax , play_str
	push ax
	mov ax , 24
	push ax
	call printstr
	
	
	
	mov ax , 1650
	push ax
	mov ax , inst
	push ax
	mov ax , 35
	push ax
	call printstr
	
	
	
	pop ax
	ret
	
printnum: 
push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov ax, [bp+4] ; load number in ax
mov bx, 10 ; use base 10 for division
mov cx, 0 ; initialize count of digits
nextdigit: mov dx, 0 ; zero upper half of dividend
div bx ; divide by 10
add dl, 0x30 ; convert digit into ascii value
push dx ; save ascii value on stack
inc cx ; increment count of values
cmp ax, 0 ; is the quotient zero
jnz nextdigit ; if no divide it again
mov di, [bp+6] ; point di to 70th column
nextpos: pop dx ; remove a digit from the stack
mov dh, 0x07 ; use normal attribute
mov [es:di], dx ; print char on screen
add di, 2 ; move to next screen location
loop nextpos ; repeat for all digits on stack
pop di
pop dx
pop cx
pop bx
pop ax

pop es
pop bp
ret 4


; youLose:
	; push ax
	
	; ;call clrscr
	; mov ax , 1990
	; push ax
	; mov ax , Lose_str
	; push ax
	; mov ax , 8
	; push ax
	; call printstr
	
	; ;jmp endgame
	
	; pop ax
; ret

callmee
	
	mov ax , 1990
	push ax
	mov ax , Lose_str
	push ax
	mov ax , 8
	push ax
	call printstr
	
	jmp callmee
	
	pop ax
ret
printstr:
 push bp
mov bp, sp
push es
push ax
push cx
push si
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, [bp+8] ; point di to top left column
mov si, [bp+6] ; point si to string
mov cx, [bp+4] ; load length of string in cx
mov ah, 0x07 ; normal attribute fixed in al
nextchar: 
mov al, [si] ; load next char of string
mov [es:di], ax ; show this char on screen
add di, 2 ; move to next screen location
add si, 1 ; move to next char in string
loop nextchar ; repeat the operation cx times
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 6

printstr_B:
 push bp
mov bp, sp
push es
push ax
push cx
push si
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, [bp+8] ; point di to top left column
mov si, [bp+6] ; point si to string
mov cx, [bp+4] ; load length of string in cx
mov ah, 0x8e ; normal attribute fixed in al
nextchar1: 
mov al, [si] ; load next char of string
mov [es:di], ax ; show this char on screen
add di, 2 ; move to next screen location
add si, 1 ; move to next char in string
loop nextchar1 ; repeat the operation cx times
pop di
pop si
pop cx
pop ax
pop es
pop bp
ret 6

time_str: db 'TIME '
printStrings:
	push ax
	
	mov ax , 280
	push ax
	mov ax , Lives_str
	push ax
	mov ax , 5
	push ax
	call printstr_B
	
	mov ax , 162
	push ax
	mov ax , Score_str
	push ax
	mov ax , 5
	push ax
	call printstr_B
	
	mov ax , 390
	push ax
	mov ax , time_str
	push ax
	mov ax , 5
	push ax
	call printstr_B
	
	pop ax
ret
clrscr: 
	push es
	push ax
	push cx
	push di
	mov ax, 0xb800
	mov es, ax ; point es to video base
	xor di, di ; point di to top left column
	mov ax, 0x0720 ; space char in normal attribute
	mov cx, 2000 ; number of screen locations
	cld ; auto increment mode
	rep stosw ; clear the whole screen
	pop di 
	pop cx
	pop ax
	pop es
ret 
boader:
	push ax
	push es
	push di
	
	mov ax,0xb800
	mov es,ax
	
	mov ah,0x60
	mov al,0x20
	mov di,482
	l1:
		 mov word[es:di],ax
		 add di,2
		 cmp di,636
		 jne l1
	
	cmp byte[cs:solid],1
	jne nnp
		mov ah,0x40
		jmp npp
	nnp:
		mov ah,0x60
	npp:
		mov di,3682
		l2:
			mov word[es:di],ax
			add di,2
			cmp di,3836
			jne l2
	
	mov ah,0x60
	mov al,0x20
	mov di,482
	l3:
		mov word[es:di],ax
		add di,160
		cmp di,3842
		jne l3
		
	mov di,636
	l4:
		mov word[es:di],ax
		add di,160
		cmp di,3996
		jne l4
	pop di
	pop es
	pop ax
ret

brick_remove:
	push es
	push ax
	push dx
	push cx
	push si
	push bx
	
	mov ax,0xb800
	mov es,ax
	
	mov cx , 24
	mov si , 0
	
	mov dx , [cs:calculated_location]
	
check:
	mov ax , word[cs:bricks_start_location + si]
	mov bx , word[cs:bricks_end_location + si]
	add si , 2
	
	cmp dx , ax
	jae checknext
	loop check
	jmp end_ofFunc

checknext:
	cmp dx , bx
	jbe remove
	loop check
	jmp end_ofFunc

remove:	
	cmp ax,846
	jne np
		mov byte[cs:solid],1
	np:
	
	sub si , 2
	
	mov di , word[cs:bricks_start_location + si]
	mov cx , 6
	mov ax , 0x0720
	rep stosw
	call sound
	add word[cs:score] , 5
	dec word[cs:total_bricks]
	mov ax , 174
	push ax
	push word[cs:score]
	call printnum
	
	
end_ofFunc:
	pop bx
	pop si
	pop	cx
	pop dx
	pop ax
	pop es
ret
bricks:
	push es
	push cx
	push bx
	push si
	push di
	
	mov ax, 0xb800
	mov es, ax 	; point es to video base
	mov di,	810	; point di to top left column
	mov si , 0
	mov bx , 0
	
	cld
	
	brickline1:
		cmp di , 936
		ja brickline2
			mov ah , 0x90
			mov al , 0x20
			mov cx , 6
			rep stosw
			mov cx , 3
			mov ax, 0x0720 
			rep stosw
			add si , 2	
			jmp brickline1
	
	brickline2:
		mov di , 1290
	brickline2_print:
		cmp di, 1416
		ja brickline3
			mov ah , 0xe0
			mov al , 0x20
			mov cx , 6
			rep stosw
			mov cx , 3
			mov ax, 0x0720 
			rep stosw
			add si , 2	
			jmp brickline2_print
	
	brickline3:
		mov di, 1770
	brickline2_print3:
		cmp di, 1896
		ja endn
			mov ah , 0x50
			mov al , 0x20
			mov cx , 6
			rep stosw
			mov cx , 3
			mov ax, 0x0720 
			rep stosw
			add si , 2	
			jmp brickline2_print3
	
	endn:
	mov di,846
	mov cx,6
	mov al,0x20
	mov ah,0x40
	rep stosw
	
	pop di
	pop si
	pop bx
	pop cx
	pop es
ret
clearStacker:
	push bp
	mov bp , sp
	push es
	push ax
	push di
	push cx
	
	mov ax , 0xb800
	mov es , ax
	
	mov ax , 0x0720
	mov cx , 13
	mov di , [bp+4]
	
	rep stosw
	mov di,[cs:preBall]
	mov word[es:di],ax
	
	pop cx
	pop di
	pop ax
	pop es
	pop bp
ret	2
printStacker:
	push bp
	mov bp , sp
	push es
	push ax
	push di
	push cx
	
	mov ax , 0xb800
	mov es , ax
	
	mov al , 0x20
	mov ah , 0xb0
	mov cx , 13
	mov di , [bp+4]
	
	mov word[cs:left_limit] , di
	rep stosw
	sub di , 2
	mov word[cs:right_limit] , di
	
	mov ax , word[cs:right_limit]
	sub ax,12
	mov word[cs:mid] , ax
	
	sub ax,160
	mov di,ax
	shr ax,1
	sub ax,1680
	mov cx,ax
	
	cmp byte[cs:StayOnStacker],1
	jne endi
		mov al,'O'
		mov ah,0x07
		mov word[es:di],ax
		mov [cs:preBall],di
		mov word[cs:row],21
		mov word[cs:colume],cx
		mov word[cs:previous],di
		
	endi:
	pop cx
	pop di
	pop ax
	pop es
	pop bp
ret	2
stacker:
	push ax
	push di
	
	cmp word[cs:right_] , 1
	je movRight
	cmp word[cs:left_] , 1
	je movLeft
	
	movRight:
		mov ax, word[cs:pre_stack_pos]
		add ax , 8
		cmp ax , word[cs:right_edge]
		ja exit1
			mov di, word[cs:pre_stack_pos]
			push di
			call clearStacker
			push ax
			call printStacker
			mov word[cs:pre_stack_pos] , ax
			jmp exit1
	
	movLeft:
		mov ax, word[cs:pre_stack_pos]
		sub ax , 8
		cmp ax , word[cs:left_edge]
		jb exit1
			mov di, word[cs:pre_stack_pos]
			push di
			call clearStacker
			push ax
			call printStacker
			mov word[cs:pre_stack_pos] , ax
			jmp exit1
	
	exit1:
		pop di
		pop ax
ret
calculate_position: ;;;;				first push x then push y
	push bp
	mov bp , sp
	push ax
	
	mov al , 80
	mul byte[bp+4]
	add ax , [bp+6]
	shl ax ,1
	
	mov word[cs:calculated_location] , ax
	
	pop ax
	pop bp
	ret 4
nextposition:
	push ax
	push bx
	push cx
	
	mov al,[cs:incC]
	mov ah,[cs:incR]
	mov bx,[cs:colume]
	mov cx,[cs:row]

	cmp word[cs:colume],3
	jne nextcond4
		mov al,1
		jmp rowCheck3
	nextcond4:
		cmp word[cs:colume],77
		jne rowCheck3
			mov al,0
			
	rowCheck3:
		cmp word[cs:row],4
		jne nextcond5
			mov ah,1
			jmp printingLocation1
		nextcond5:
			cmp word[cs:row],22
			jne printingLocation1
				mov ah,0
	
	printingLocation1:
		cmp al,1
		jne nextcond6
			add bx,1
			jmp rowCheck4
		nextcond6:
			sub bx,1
			
		rowCheck4:
			cmp ah,1
			jne nextcond7
				add cx,1
				jmp calculatelocation1
			nextcond7:
				sub cx,1
	calculatelocation1:
		push bx ;colume
		push cx ;row
		call calculate_position
		
	pop cx
	pop bx
	pop ax
ret
left_right:
	push ax
	
	mov ax , word[cs:calculated_location]
	cmp ax , [cs:mid]
	ja check_right
	
	cmp ax , [cs:left_limit]
	jb endit
	mov byte[cs:left_or_right] , 0
	jmp endit
	
	check_right:
	cmp ax , [cs:right_limit]
	ja endit
	mov byte[cs:left_or_right] , 1
	jmp endit
	
	endit:
	pop ax
ret

ball:
	push es
	push ax
	push bx
	push cx
	push di
	
	mov ax,0xb800
	mov es,ax
	
	mov di,[cs:previous]
	mov word[es:di],0x0720
	call nextposition
	mov di,[cs:calculated_location]
	mov ax,word[es:di]
	cmp ah,0x07
	je R
		cmp ah,0xb0
		je n
		call brick_remove
		jmp n1
		n:
			call left_right
			cmp byte[cs:left_or_right],1
			jne n3
				mov byte[cs:incC],1
				jmp n1
			n3:
				mov byte[cs:incC],0
		n1:
		cmp byte[cs:incR],1
		jne r1
			mov byte[cs:incR],0
			jmp R
		r1:
			cmp byte[cs:incR],0
			jne R
				mov byte[cs:incR],1
	R:
	cmp word[cs:colume],3
	jne nextcond
		mov byte[cs:incC],1
		jmp rowCheck
	nextcond:
		cmp word[cs:colume],77
		jne rowCheck
			mov byte[cs:incC],0
			
	rowCheck:
		cmp word[cs:row],4
		jne nextcond1
			mov byte[cs:incR],1
			jmp printingLocation
		nextcond1:
			cmp byte[cs:solid],0
			jne solid12
				cmp word[cs:row],22
				jne printingLocation
					mov byte[cs:StayOnStacker],1 
					mov ax,word[cs:mid]
	
					sub ax,160
					mov di,ax
					shr ax,1
					sub ax,1680
					mov cx,ax

					mov al,'O'
					mov ah,0x07
					mov word[es:di],ax
					mov [cs:preBall],di
					mov word[cs:row],21
					mov word[cs:colume],cx
					mov word[cs:previous],di
					sub byte[cs:live],1
					cmp byte[cs:live],0
					;call print_lives
					jne endii
						;push cs
						;jmp far endgame;;;;;;;;;;;;;;;;;;;
					jmp endii
			solid12:
				cmp word[cs:row],23
				jne printingLocation
					mov byte[incR],0
	printingLocation:
		cmp byte[cs:incC],1
		jne nextcond2
			add word[cs:colume],1
			jmp rowCheck1
		nextcond2:
			sub word[cs:colume],1
			
		rowCheck1:
			cmp byte[cs:incR],1
			jne nextcond3
				add word[cs:row],1
				jmp calculatelocation
			nextcond3:
				sub word[cs:row],1
		calculatelocation:
		mov ax,word[cs:row]
		mov bx,80
		mul bx
		add ax,word[cs:colume]
		shl ax,1
		mov di,ax
		mov word[cs:previous],ax
		
	mov ah,0x07
	mov al,'O'
	mov word[es:di],ax
	
	endii:
	pop di
	pop cx
	pop bx
	pop ax
	pop es
ret 
call_instruction_menu: db 0
instruction_menu:
	push ax
	call clrscr
	
	
	mov ax , 370 ; row 6 col 25
	push ax
	mov ax ,instructions_str
	push ax
	mov ax , 11
	push ax
	call printstr_B
	
	mov ax , 690  ; row 6 col 25
	push ax
	mov ax , ttl_live_str
	push ax
	mov ax , 22
	push ax
	
	call printstr
	
	mov ax , 1010
	push ax
	mov ax , play_str
	push ax
	mov ax , 24
	push ax
	call printstr
	
	
	
	mov ax , 1330
	push ax
	mov ax , solid_base_str
	push ax
	mov ax , 41
	push ax
	call printstr
	
	
	mov ax , 1650
	push ax
	mov ax , bonus_note_str
	push ax
	mov ax , 43
	push ax
	call printstr
	
		
	mov ax , 1970
	push ax
	mov ax , space_bar
	push ax
	mov ax , 31
	push ax
	call printstr
	
	
	mov ax , 2290
	push ax
	mov ax , left_arrow
	push ax
	mov ax , 34
	push ax
	call printstr
	
	mov ax , 2610
	push ax
	mov ax , exit_str
	push ax
	mov ax , 15
	push ax
	call printstr
	
	pop ax
	ret
	
kbisr: 
	push ax
	push es
	
	mov word[cs:right_] , 0
	mov word[cs:left_] , 0
	mov ax, 0xb800
	mov es, ax 
	
	in al, 0x60 ; read a char from keyboard port
	
	cmp byte[start_game] , 0
	jne main_game
	
	cmp al , 0x1c
	jne cmp_instruction
	mov byte[start_game] , 1
	jmp exit
	
cmp_instruction:
	cmp al , 0x17
	jne exit
	mov byte[call_instruction_menu] , 1
	
	cmp byte[start_game] , 1
	jne exit
main_game:
	cmp al, 0x4b ; left arrow
	jne nextcmp ; no, try next comparison
		mov word[cs:left_] , 1
		call stacker ; 
		jmp exit ; leave interrupt routine
	nextcmp: 
		cmp al, 0x4d ; right arrow
		jne nextcmp2  ; no, leave interrupt routine
			mov word[cs:right_] , 1
			call stacker
			jmp exit
	nextcmp2: 
		cmp al, 0xad ; has the A key released
		jne nextcmp3 ; no, try next comparison
		;leave interrupt routine
		jmp exit
	nextcmp3: 
		cmp al, 0xab ; has the D key released
		jne nextcmp4 ; no, chain to old ISR
		jmp exit 
	nextcmp4:
		cmp al,0x39
		jne nextcmp5
			mov byte[cs:StayOnStacker],0
		jmp exit
	nextcmp5:
		cmp al,0xb9
		jne exitcmp
		jmp exit
		
	exitcmp: 
		cmp al,0x12
		jne quitcmp
		mov byte[cs:end_game] , 1
		jmp exit
	quitcmp:
		cmp al , 0x10
		jne restartcmp
		mov byte[cs:quit] , 1
		jmp exit
	restartcmp:
		cmp al , 0x13
		jne nomatch
		mov byte[cs:restart] , 1
		jmp exit
	nomatch: 
		pop es
		pop ax
		jmp far [cs:oldisr] 
	exit:
		mov al, 0x20
		out 0x20, al 
	pop es
	pop ax 
iret 

timer: 
	cmp byte[cs:start_game],1
	jne pp
		inc byte[cs:clock]
		cmp byte[cs:clock],18
		jne ppp
			add word[cs:second],1
			mov byte[cs:clock],0
		ppp:
		cmp byte[cs:solid],1
		jne po
			inc byte[cs:solid1]
			cmp byte[cs:solid1],180
			jne po
				mov byte[cs:solid],0
		po:
		inc word[cs:bonus]
		cmp word[cs:bonus],2160
		jnbe pk
			cmp word[cs:total_bricks],0
			jne pk
				add word[cs:score],50
		pk:
		push ax
		mov ax , 402
		push ax
		mov ax , word[cs:second]
		push ax
		call printnum
		pop ax
	pp:
	cmp byte[cs:StayOnStacker],0
	jne endof
	cmp byte[cs:start_game] , 1
	jne endof
		inc byte[cs:tickcount]
		cmp byte[cs:tickcount], 2
		jne endof
			call ball
			call boader
			mov byte[cs:tickcount],0
			;jmp endiii
		endof:
		;cmp byte[cs:live],0
		;jne endiii
			;call youLose
		;endiii:
		mov al, 0x20
		out 0x20, al ; end of interrupt
iret ; return from interrupt 

print_lives:
	push ax
	push es
	
	mov ax , 0xb800
	mov es , ax
	mov cx , 3
	mov ax , 0x0720
	mov di , 292
	rep stosw
	
	mov cl , byte[cs:live]
	mov ch , 0
	mov ah , 0x07
	mov al , '*'
	mov di , 292
	rep stosw
	
	pop es
	pop ax
ret

oldtmr: dd 0
end_game: db 0
start:
	
	xor ax, ax
	mov es, ax ; point es to IVT base
	
	mov ax, [es:9*4]
	mov [oldisr], ax ; save offset of old routine
	mov ax, [es:9*4+2]
	mov [oldisr+2], ax ; save segment of old routine
	
	mov ax, [es:8*4]
	mov [oldtmr], ax ; save offset of old routine
	mov ax, [es:8*4+2]
	mov [oldtmr+2], ax ; save segment of old routine
	
	cli ; disable interrupts
		mov word [es:9*4], kbisr 
		mov [es:9*4+2], cs 
		mov word [es:8*4],timer
		mov [es:8*4+2],cs
	sti ; enable interrupts
	
	call start_menu
menu_loop:
	cmp byte[call_instruction_menu] , 1
	je instruction
	cmp byte[start_game] , 0
	je menu_loop
	cmp byte[end_game] , 1
	je endgame
start_game_here:
	mov byte[restart] , 0
	mov byte[quit] , 0
	call clrscr
	call printStrings
	call print_lives
	mov ax , 174
	push ax
	push word[score]
	call printnum
	call boader
	call bricks
	mov byte[StayOnStacker],1
	call stacker
game_inner_loop:
		; mov ax , 402
		; push ax
		; mov ax , [second]
		; push ax
		; call printnum
	
	cmp word[total_bricks] , 0
	je endgame ;;;;abhi impliment karna
	cmp byte[end_game] , 1
	je endgame
	cmp byte[live] , 0
	je endgame
	jmp game_inner_loop
instruction:
	call instruction_menu
again_ins
	cmp byte[start_game] , 1
	je start_game_here
	jne again_ins
	
endgame:
mov byte[start_game] , 0
call last_menu
call clrscr
cmp byte[restart] , 1
je start_game_here
mov ax , [oldisr]
mov bx , [oldisr+2]
mov cx , [oldtmr]
mov dx , [oldtmr+2]
cli 
mov [es:9*4] , ax
mov [es:9*4+2], bx
mov [es:8*4] , cx
mov [es:8*4+2], dx
sti

mov ax , 0x4c00
int 0x21


restart: db 0
quit: db 0
variable: dw 0



last_menu:
;mov byte[start_game] , 1
	push ax
		call clrscr
		
	cmp byte[live] , 1
	jne check_win
	mov ax , 1990
	push ax
	mov ax , Lose_str
	push ax
	mov ax , 8
	push ax
	call printstr_B
check_win:
	cmp word[total_bricks] , 0
	jne no_results
	mov ax , 1990
	push ax
	mov ax , Lose_str
	push ax
	mov ax , 8
	push ax
	call printstr_B
	
no_results:
	
			
		call last_menu_display
	
	
what_nxt:
		cmp byte[cs:restart] , 1
		je do_restart
		cmp byte[cs:quit] , 1
		je go_quit
		jmp what_nxt

go_quit:
		pop ax
		ret
		
do_restart:
		pop ax
		mov word[second] , 0
		mov byte[clock] , 0
		mov byte[start_game] , 1
		mov word[total_bricks] , 24
		mov byte[live] , 3
		mov word[score] , 0
		mov byte[end_game] , 0
		mov word[bonus] , 0
		ret
		
last_menu_display
	push ax
	
	mov ax , 690  ; row 6 col 25
	push ax
	mov ax ,total_score_str
	push ax
	mov ax , 17
	push ax
	call printstr
	
	
	mov ax , 728 ; row 6 col 25
	push ax
	push word[score]
	call printnum
	
	
	mov ax , 1330  ; row 6 col 25
	push ax
	mov ax ,lives_remain_str
	push ax
	mov ax , 15
	push ax
	call printstr
	
	mov ax , 1392 ; row 6 col 25
	push ax
	push word[live]
	call printnum
	
	
	mov ax , 1650  ; row 6 col 25
	push ax
	mov ax ,restart_str
	push ax
	mov ax , 34
	push ax
	call printstr
	
	
	mov ax , 1970  ; row 6 col 25
	push ax
	mov ax , quit_str
	push ax
	mov ax , 26
	push ax
	call printstr
	
	pop ax
	ret