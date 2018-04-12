; 8086 assembly file
; by:czfshine
; date: 2018/04/12 10:46:38
;试编写一段程序，从键盘接收一个-32768-32767间的十进制有符号数，
;并在终端上显示与它等值的二进制数。
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
    mov si,2
    call rebase
    
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START