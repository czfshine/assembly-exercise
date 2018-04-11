; 8086 assembly file
; by:czfshine
; date: 2018/04/12 00:12:26
;试编写一段程序，从键盘接收一个0-65535间的十进制无符号数，
;并在终端上显示与它等值的二进制数。

; The Main Data segment

INCLUDE base.inc
INCLUDE until.inc
DATA SEGMENT
    ov DB 'OverFLow',0DH,0AH,'$';
DATA ENDS

STACK SEGMENT
DW 256 DUP(?)
STACK ENDS
;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA,SS:STACK
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX
    MOV AX,STACK
    MOV SS,AX

    xor bx,bx
    mov si,10
    
    I:
        mov ah,01h
        int 21H
        cmp al,0Dh
        je r
        cmp al,'0'
        jb I
        cmp al,'9'
        ja I
        sub al,30h
        mov ah,0
        MOV DX,0
        xchg bx,AX
        mul si
        CMP DX,0
        JNZ o
        CLC
        add bx,ax
        JC o
        JMP I
    R:  
        call CRLF
        MOV SI,2
        CALL REBASE
        CALL CRLF
        JMP RETURN
    O:
        call CRLF
        mov ah,09h
        lea dx,ov
        int 21H
        jmp return 

RETURN:
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START