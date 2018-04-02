; 8086 assembly file
; by:czfshine
; date: 2018/04/02 21:13:56

;试编制一个程序：从键盘输入一行字符，
;要求第一个键入的字符必须是空格符，
;如不是，则退出程序；
;如是，则开始接收键入的字符并顺序存放在首地址为buffer的缓冲区中（空格符不存入），
;直到接收到第二个空格符时退出程序。

; The Main Data segment
DATA SEGMENT
    max db 255
    len byte  0
    buf DB 255 DUP(?)
DATA ENDS

;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX

    LEA BX,buf
    MOV SI,0

    MOV AH,01H
    INT 21H
    CMP AL,' '
    JNZ return

    S:
        INT 21h ;AH=01;
        CMP AL,' '
        JZ return
        INC SI
        MOV [BX+SI],AL
    JMP S


return:
    mov AX,SI
    MOV len,AL
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START