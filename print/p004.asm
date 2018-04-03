; 8086 assembly file
; by:czfshine
; date: 2018/04/03 12:36:16

;从键盘上输入2个一位数，求出它们的和（假设和不超过1位）。


; The Main Data segment
DATA SEGMENT
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
    
    mov aH,01h
    int 21H
    mov cl,al
    sub cl,'0'

    mov aH,01h
    int 21H
    mov bl,al
    sub bl,'0'

    add cl,bl

    mov dl,cl
    add dl,'0'
    mov ah,02H
    int 21H

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START