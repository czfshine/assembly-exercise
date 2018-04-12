; 8086 assembly file
; by:czfshine
; date: 2018/04/12 10:07:36

;编写一个程序，从键盘输入一个0～65535之间的10进制无符号数，
;然后以16进制和四进制数形式显示出所输入的数。
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

    mov si,16
    call rebase

    call crlf
    
    mov si,4
    call rebase

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START