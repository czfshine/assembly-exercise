; 8086 assembly file
; by:czfshine
; date: 2018/04/06 18:16:31

INCLUDE BASE.INC
include until.inc
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
    
    MOV BX,12345;

    MOV SI,2

    L:
        CALL REBASE
        CALL CRLF
        INC SI
        CMP SI,65
    JNZ L


    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START