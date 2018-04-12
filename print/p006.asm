; 8086 assembly file
; by:czfshine
; date: 2018/04/12 00:12:26
;试编写一段程序，从键盘接收一个0-65535间的十进制无符号数，
;并在终端上显示与它等值的二进制数。

; The Main Data segment

include scan.inc
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

    mov di,16
    call inputnumbybase

    cmp di,0
    je return1
    
    call CRLF
    MOV SI,2
    CALL REBASE
    CALL CRLF
return1:
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START