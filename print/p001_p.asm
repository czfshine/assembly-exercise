; 8086 assembly file
; by:czfshine
; date: 2018/04/06 12:08:09

; The Main Data segment
include phex.inc

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

    MOV BX,12BCH;
    call phex

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START