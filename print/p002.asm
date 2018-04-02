; 8086 assembly file
; by:czfshine
; date: 2018/04/02 23:01:49

;试编制一个程序，把BX寄存器内的二进制数以八进制数的形式在屏幕上显示出来。

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


    MOV BX,12BCH
    ; 12bch
    ; 11274
    ;0001 0010 1011 1100
    ;xx0 001 001 010 111 100
    ;0 1 1 2 7 4

    MOV CL,BH
    AND CL,10000000B;
    MOV DL,CL
    mov CL,7
    shr dl,cl
    CALL S1H
    mov CL,1
    SHL BX,CL

    mov ax,5

    S:
    MOV CL,BH
    AND CL,11100000B;
    MOV DL,CL
    mov CL,5
    shr dl,cl
    CALL S1H
    dec ax
    mov CL,3
    SHL BX,CL
    cmp bx ,0
    JNZ  S

    mov cx,ax
    mov dl ,0
    L1:
        CALL S1H

    loop l1
    MOV AH,4CH     ;return
    INT 21H


S1H:;PARM DL
    PUSH DX
    PUSH AX

    CMP DL,9
    JA S1H_1
    ADD DL,'0'
    JMP S1H_S

    S1H_1:
    SUB DL,0AH
    ADD DL,'A'

    S1H_S:
    MOV AH,02H
    INT 21H

    POP AX
    POP DX
RET

CODE ENDS
END START