; 8086 assembly file
; by:czfshine
; date: 2018/05/24 10:24:42

; The Main Data segment
DATA SEGMENT
    A dw 1;
    B dw 2;
    C dw 3;
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
    

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START