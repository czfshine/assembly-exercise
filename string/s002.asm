; 8086 assembly file
; by:czfshine
; date: 2018/03/31 16:16:29

;试编写一个程序，要求对键盘输入的小写字母用大写字母显示出来。

; The Main Data segment
DATA SEGMENT
DATA ENDS

;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX

    MOV AH,01H
    INT 21H

    SBB AL,20h
    MOV DL,AL
    MOV AH,02H
    INT 21H

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START