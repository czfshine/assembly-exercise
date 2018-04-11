; 8086 assembly file
; by:czfshine
; date: 2018/04/07 11:08:52

; The Main Data segment

include div.inc
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
    
    mov dx,1111H
    mov ax,2222H
    mov bx,3
    call div32

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START