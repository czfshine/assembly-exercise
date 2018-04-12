; 8086 assembly include file
; by:czfshine
; date: 2018/04/12 00:34:53
INCLUDE base.inc
INCLUDE until.inc
scan SEGMENT
    table DB 30h dup(-1),0,1,2,3,4,5,6,7,8,9,6 dup(-1),10,11,12,13,14,15,26  dup(-1),10,11,12,13,14,15
    len equ $-table;
    ov DB 'OverFLow',0DH,0AH,'$';

    ;输入不同进制的值到bx
    ;in: di  base<=16  
    ;out:bx  value,di==0 success+ di==1 success neg
    inputnumbybase PROC FAR USES AX cx DX ds si bp
        mov ax,scan
        mov ds,ax
        xor bp,bp
        xor cx,cx
        lea bx,table
    I:
        mov ah,01h
        int 21H
        cmp al,0Dh
        je okret

        cmp al,'-'
        je negnum

        mov ah,0
        mov si,ax
        mov dh,0
        mov dl,[bx+si]
        cmp dl,-1
        je I

        MOV DX,0
        xchg cx,AX
        imul di
        CMP DX,0
        JNZ o
        CLC
        mov dl,[bx+si]
        cmp bp,1
        jne ok
        add ax,dx
        dec ax
        or ax,ax
        js o
        inc ax
        jmp lo
    ok:
        add ax,dx
        JC o
    lo:
        mov cx,ax
        JMP I
    negnum:
        mov bp,1
        jmp I
    O:
        call CRLF
        mov ah,09h
        lea dx,ov
        int 21H
        jmp return 
    okret:
        mov di,bp
    return :
        mov bx,cx
    RET
    inputnumbybase ENDP
scan ENDS