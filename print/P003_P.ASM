
; 8086 assembly file
; by:czfshine
; date: 2018/04/03 12:18:43
;试编制一个程序，把BX寄存器内的二进制数以十进制数的形式在屏幕上显示出来。

INCLUDE BASE.INC
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

    ;00000-65525
    MOV bx,12BCH;4796

    ;use stack

    ;push all

    MOV SI,10 ;BASE
    CALL REBASE
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START
