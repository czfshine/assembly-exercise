; 8086 assembly include file
; by:czfshine
; date: 2018/04/12 00:34:53
INCLUDE base.inc
INCLUDE until.inc
scan SEGMENT
    table DB 30h dup(-1),0,1,2,3,4,5,6,7,8,9,6 dup(-1),10,11,12,13,14,15,26  dup(-1),10,11,12,13,14,15;66
    len equ $-table;=66

    ov DB 'OverFLow',0DH,0AH,'$';
    ;输入不同进制的值到bx
    ;in: di  base<=16  
    ;out:bx  value,di!=0 success
    inputnumbybase PROC FAR USES AX cx DX ds si
        mov ax,scan
        mov ds,ax
        xor cx,cx
        lea bx,table
    I:
        mov ah,01h
        int 21H
        cmp al,0Dh
        je return

        mov ah,0
        mov si,ax
        mov dh,0
        mov dl,[bx+si]
        cmp dl,-1
        je I

        MOV DX,0
        xchg cx,AX
        mul di
        CMP DX,0
        JNZ o
        CLC
        mov dl,[bx+si]
        add ax,dx
        JC o
        mov cx,ax
        JMP I
    O:
        call CRLF
        mov ah,09h
        lea dx,ov
        int 21H
        mov di,0
    return :
        mov bx,cx
    RET
    inputnumbybase ENDP
scan ENDS