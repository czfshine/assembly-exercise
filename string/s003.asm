; 8086 assembly file
; by:czfshine
; date: 2018/03/31 16:29:15

;编写程序，从键盘接收一个小写字母，然后找出它的前导字符和后续字符，再按顺序显示这三个字符。

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

    DEC AL
    MOV DL,AL
    MOV AH,02H
    INT 21H

    
    INC AL
    MOV DL,AL
    MOV AH,02H
    INT 21H
    INC AL
    MOV DL,AL
    MOV AH,02H
    INT 21H


    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START