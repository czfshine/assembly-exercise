; 8086 assembly file
; by:czfshine
; date: 2018/04/12 10:54:02

;从键盘输入一个有符号的十进制数，
;然后在下一行用16进制形式输出此数
; The Main Data segment

include scan.inc
DATA SEGMENT
DATA ENDS

;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX
    mov di,10
    call inputnumbybase
    cmp di,1
    jne put
    neg bx
put:
    mov si,16
    call rebase
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START