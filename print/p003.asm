; 8086 assembly file
; by:czfshine
; date: 2018/04/03 12:18:43
;试编制一个程序，把BX寄存器内的二进制数以十进制数的形式在屏幕上显示出来。
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


    mov cx,0;
    MOV AX,BX
    p:
        MOV DX,0
        DIV SI ;dx ax / 10 = ax......dx
        push dx
        inc cl
        cmp ax ,0
    jnz p 

    ;pop & print
    mov ah,02h
    pr:
        pop dx
        add dl,'0'
        int 21H
    loop pr

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START