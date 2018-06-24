DATAS SEGMENT
	headLine db 'Please appreciate the song "Life"!$'
	input db 'Enter any key to start music...$'
	crlf db 0dh,0ah,'$'
    MUS_FREQ DW  330,330,349,330,330,349,330,330,349,392 ;前奏
	   DW  440,392,440,392,349,330,349,330,349,330,294  ;往后每2小节为1行
	   DW  3 DUP(262),294,330,349,330,330,349,294,262,294,294,247,247
	   DW  262,262,220,220,247,262,262,294,330,3 DUP(247),262,247
	   DW  220,440,392,349,330,349,392,247,262,349,330
       DW  3 DUP(349),330,294,262,247,294,262
	   DW  30000,262,247,262,262,165,175,196,196,30000,30000
	   DW  30000,4 DUP(220),196,175,220,196,147,165,165,30000,30000
	   DW  175,196,196,165,196,220,220
	   DW  30000,175,220,220,3 DUP(262),294,247,220,220,196,196
	   DW  30000,262,247,3 DUP(262),165,175,196,220,196,175,165
	   DW  3 DUP(175),3 DUP(220),196,175,220,196,196,30000
	   DW  30000,220,247,262,294,262,294,330,330,349,330,294,262,294
	   DW  294,30000,220,220,247,247,262,294,294,3 DUP(262),30000
	   DW  30000,262,247,262,262,165,175,196,30000
	   DW  30000,4 DUP(220),196,175,220,196,147,165,30000,30000,165
	   DW  3 DUP(175),196,196,165,196,220,220
	   DW  30000,175,220,220,262,262,294,247,220,220,196,196
	   DW  30000,262,262,247,262,262,165,175,196,220,196,175,165
	   DW  3 DUP(175),3 DUP(220),196,175,220,196,196,30000
	   
	   ;page 第二页乐谱
	   DW  30000,220,247,262,294,262,294,330,330,349,330,294,262
	   DW  294,220,220,247,247,262,294,294,262,262,262,30000,220,220
	   DW  349,330,349,262,247,247,30000,3 DUP(220),392,349,392,349,330,330,30000,330,330,294
	   DW  262,262,220,220,247,262,220,262,330,330,3 DUP(294),330,294
	   DW  3 DUP(262),294,330,349,330,330,349,294,262,294,294,247,247
	   DW  262,262,220,220,247,262,262,294,330,3 DUP(247),262,247
	   DW  220,440,392,349,330,349,392,247,262,349,330
	   DW  3 DUP(349),330,294,262,247,294,262,30000
	   DW  196,262,262,196,196,392,349,330,349,349,30000,262,262
	   DW  5 DUP(349),330,330,294,262
	   DW  3 DUP(262),-1
	   ;DW  784,698,784,698,3 DUP(659),3 DUP(30000),294,330,349,440,523,587 ;结尾


	MUS_TIME DW 25,13,13,25,13,13,25,13,13,50  ;前奏
	   DW  50,25,4 DUP(6),38,3 DUP(4),50  ;往后每2小节为1行
	   DW  38,13,4 DUP(13),38,2 DUP(6),13,2 DUP(6),13,2 DUP(6)
	   DW  25,4 DUP(6),25,2 DUP(13),13,2 DUP(6),50,2 DUP(13)
	   DW  38,5 DUP(13),38,13,38,6,6
	   DW  38,6,6,13,13,13,6,6,80
	   DW  25,13,6,6,25,13,6,6,50,25,25
	   DW  25,13,6,6,4 DUP(13),13,6,6,25,25,25
	   DW  38,13,38,13,38,13,50
	   DW  25,5 DUP(13),6,6,4 DUP(13),50
	   DW  25,13,6,6,4 DUP(13),50,4 DUP(13)
	   DW  38,6,6,3 DUP(13),6,6,13,13,50,25
	   DW  25,6 DUP(13),38,3 DUP(13),6,13,6
	   DW  25,13,6,6,25,13,6,6,6,13,6,50,25
	   DW  25,13,6,6,25,13,13,75,25
	   DW  25,13,6,6,6 DUP(13),25,25,13,13
	   DW  4 DUP(13),38,13,38,13,50
	   DW  25,10 DUP(13),50
	   DW  8 DUP(13),50,4 DUP(13)
	   DW  38,6,6,3 DUP(13),6,6,13,13,50,25
	   
	   ;page 第二页乐谱
	   DW   25,13,13,13,13,13,13,38,13,13,13,13,13
	   DW   38,6,6,25,13,6,6,6,13,6,50,13,6,6
	   DW   13,13,13,6,6,25,6,6,6,6,13,13,13,6,6,25,6,6,6,6
	   DW    25,6,6,6,6,13,13,13,13,13,6,6,50,13,13
	   DW   38,5 DUP(13),38,6,6,13,6,6,13,13,13
	   DW   25,6,6,6,6,25,13,13,13,6,6,50,13,13
	   DW   38,5 DUP(13),38,13,38,6,6
	   DW   38,6,6,13,13,13,6,6,75,25
	   DW   38,5 DUP(13),13,6,6,50,13,6,6,13,6,6,25,13,6,13,6,6
	   DW   13,13,75,1
	   ;DW  13,6,6,6,13,13,13,50,25,25,13,6,6,6,6,6,6  ;结尾 

		  pos=0;
	gechi db "                         [Begin]                           $";60
		  pos= pos+20
	      dw pos*2
		  db "          whole life the wonder such you bring             $"
		  pos= pos+7
		  DW pos*2
		  db "                 the beauty i can see                      $"
		  pos= pos+6
		  DW pos*2
		  db "              but i keep deep inside on it                 $"
		  pos= pos+14
		  DW pos*2
		  DB "        oh life i feel that i can bring it again           $"
          pos= pos+11
		  DW pos*2
		  DB "        in the world where love will still remain          $"
		  pos= pos+11
		  DW pos*2
		  DB "            choose your words make them wise               $"
		  pos= pos+11
		  DW pos*2
		  DB "         many things have produced where we are            $"
		  pos= pos+13
		  DW pos*2
		  DB "                       i am here                           $"
		  pos= pos+3
		  DW pos*2
		  DB "                     here with you                         $"
		  pos= pos+5
		  DW pos*2
		  DB "        close your eyes let love heal the sorrow           $"
		  pos= pos+13
		  DW pos*2
		  DB "              once again i feel in life                    $"
		  pos= pos+8
		  DW pos*2
		  DB "              i'm sure of this insight                     $"
		  pos= pos+5
		  DW pos*2
		  DB "            and i need you more than ever                  $"
		  pos= pos+12
		  DW pos*2
		  DB "             life's told me so much more                   $"
		  pos= pos+7
		  DW pos*2
		  DB "feel stronger than before of this feeling stay here forever$";60
		  pos= pos+19
		  DW pos*2
		  DB "                 long ago i was blind                      $"
		  pos= pos+9
		  DW pos*2
		  DB "     I thought the love was so waste here to stay          $"
		  pos= pos+12
		  DW pos*2
		  DB "                but we walked all the way                  $"
		  pos= pos+7
		  DW pos*2
		  DB "                 and we said good bye                      $"
		  pos= pos+6
		  DW pos*2
		  DB "          even though i knew i loved you still             $"
		  pos= pos+12
		  DW pos*2
		  DB "    suddenly you were gone and she was in your rounds      $"
		  pos= pos+13
		  DW pos*2
		  DB "                 its picture i remember                    $"
		  pos= pos+11
		  DW pos*2
		  DB "     i was lost could not be saved my life just ran away   $"
          pos= pos+14
		  DW pos*2
		  DB "          i only wish that we could start over             $"
          pos= pos+11
		  DW pos*2
		  DB "             but true love will find its way               $"
		  pos= pos+9
		  DW pos*2
		  DB "               now i love it seemed to stay                $"
          pos= pos+10
		  DW pos*2
		  DB "      i lost it once and now i found the way to live again $"
		  pos= pos+16
		  DW pos*2
		  DB "           oh life i wonder such you bring the beauty      $"
		  pos= pos+10
		  DW pos*2
		  DB "          i can see but i keep deep inside on it           $"
		  pos= pos+20
		  DW pos*2
		  DB "         oh life i feel that i can bring it again          $"
  		  pos= pos+10
		  DW pos*2
          DB "          in the world where love will still remain        $"
	 	  pos= pos+11
		  DW pos*2
          DB "               but true love will find its way             $"
		  pos= pos+11
		  DW pos*2
          DB "                 now i love it seemed to stay              $"
		  pos= pos+14
		  DW pos*2
		  DB "                          [END]                            $"
		  dw 0fffh
	     
	cur dw 0;
	nextpos dw 0;
DATAS ENDS

STACKS SEGMENT stack
	db 1000H dup(?)
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
	
	music	proc	far
    MOV AX,DATAS
    MOV DS,AX
    
    ;提示输入
    lea dx,headline
    mov ah,9
    int 21h
    lea dx,crlf
    mov ah,9
    int 21h
    lea dx,input
    mov ah,9
    int 21h
    MOV AH,1
	INT 21H
	
	;初始化
	lea si,mus_freq
	MOV nextpos,SI
	lea bp,ds:mus_time
	
	;mov ax,20
	;call print
	;MOV AX,MUSLEN
	;call print
	;
	;mov dl,0dh
	;mov ah,2
	;int 21h
	;mov dl,0ah
	;mov ah,2
	;int 21h
	;
	;MOV AX,TIMELEN
	;call print
	;
	;jmp end_mus
	
	push ax
	lea ax,gechi
	mov CUR,AX
	pop ax

	freq:
		mov di,[si]
		cmp di,-1	;乐谱最后用-1作为结束条件
		je end_mus	;若歌曲播放完，则退出程序
		
		mov ax,di	
		shr ax,1
		add di,ax	;将音符频率放入di
		
		mov bx,ds:[bp]	;将音符的持续时间放入bx
		call soundf		;调用子程序发出音调
		CALL showlineword
		add si,2
		add bp,2
		jmp freq
		
	end_mus:		;歌曲播放完毕，退出程序
	    MOV AH,4CH
	    INT 21H
    music	endp
    
    WAITF	PROC	FAR
    	PUSH AX
		WAITF1:
			IN AL,61H
			AND AL,10H
			CMP AL,AH
			JE WAITF1
			MOV AH,AL
			LOOP WAITF1
			POP AX
			RET
	WAITF	ENDP
	
	SOUNDF	PROC	FAR
		push ax
		push bx
		push cx
		push dx
		push di
		mov al,0b6h
		out 43h,al
		mov dx,12h
		mov ax,348ch
		div di
		out 42h,al
		mov al,ah
		out 42h,al
		in al,61h
		mov ah,al
		or al,3
		out 61h,al
		wait1:
			mov cx,11000
			call waitf
			dec bx
			jnz wait1
			mov al,ah
			out 61h,al
			pop di
			pop dx
			pop cx
			pop bx
			pop ax
		RET
	SOUNDF	ENDP
	
	print	proc	far
		push ax
		push cx
		push dx
		push si
		mov cx,0
		mov si,10
		lop1:
			mov dx,0
			div si
			push dx
			inc cx
			cmp ax,0
			je output
			jmp lop1
			
		output:
			pop dx
			add dl,30h
			mov ah,2
			int 21h
			loop output
			
		pop si
		pop dx
		pop cx
		pop ax
		ret
	print	endp
	
	
	;si:当前音符
	showlineword PROC FAR uses  ax bx cx dx 
		mov ax,nextpos
		cmp si,ax
		jne SHOW_return

		MOV BX,cur
		MOV DX,BX
		MOV AH,09
		INT 21h
		MOV AH,02;
		MOV DL,0ah
		INT 21h
		MOV DL,0dh
		INT 21h

		ADD BX,60
		MOV CX,[BX]
		lea AX,mus_freq
		ADD AX,CX
		MOV nextpos,AX

		INC BX
		INC BX
		MOV CUR,BX

	SHOW_return:
		RET
	showlineword ENDP
CODES ENDS
    END music
