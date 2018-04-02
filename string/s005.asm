; 8086 assembly file
; by:czfshine
; date: 2018/03/31 17:04:48

;从键盘上输入一串字符（用回车键结束，使用10号功能调用。）放在STRING中，
;试编制一个程序测试字符串中是否存在数字。
;如有，则把CL的第5位置1，否则将该位置置0。

; The Main Data segment
DATA SEGMENT
    buf DB 80,?,80 dup(?) ;
DATA ENDS

;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX

    LEA DX,buf
    MOV AH,0AH
    INT 21H

    LEA BX,buf
    INC BX
    MOV CL,[BX]
    MOV CH,0
    MOV SP,0
    L1:
        MOV SI,CX
        MOV DL,[BX+SI]
        CMP DL,'0'
        JB L0
        CMP DL,'9'
        JA L0
        OR CL,00010000B
        JMP L2
    L0:
    LOOP L1
    L2:
    
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START