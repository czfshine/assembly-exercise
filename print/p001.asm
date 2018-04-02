; 8086 assembly file
; by:czfshine
; date: 2018/04/02 22:34:09
;试编制一个程序，把BX寄存器内的二进制数以十六进制数的形式在屏幕上显示出来。
; The Main Data segment
DATA SEGMENT
DATA ENDS

STACK SEGMENT
   DW 256 DUP(?);
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

    MOV AL,Bh
    CALL B2H

    MOV AL,BL
    CALL B2H

    MOV AH,4CH     ;return
    INT 21H

B2H: ;PARM: AL
    PUSH AX
    PUSH CX
    PUSH DX
    
    MOV dL,AL
    MOV CL,4
    SHR DL,CL
    CALL S1H
    MOV DL,AL
    AND DL,00001111B
    CALL S1H

    

    POP DX
    POP CX
    POP AX
RET

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