; 8086 assembly file
; by:czfshine
; date: 2018/04/12 10:10:56
;编写一个程序，从键盘输入一个不长于8位的四进制数，
;并将所输入的数以10进制数形式显示出来。
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
    mov di,4
    call inputnumbybase
    mov si,10
    call rebase    

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START