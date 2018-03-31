; 8086 assembly file
; by:czfshine
; date: 2018/03/31 15:46:49

;逆序输出字符串“BASED ADDRESSING”。

; The Main Data segment
DATA SEGMENT
    string DB 'BASED ADDRESSING';
    len equ $-string
DATA ENDS

;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX

    MOV CX,len
    L1:
        MOV SI,CX
        DEC SI ;;位置
        LEA BX,string
        MOV DL,[BX+SI]
        MOV AH,02H
        INT 21H
    LOOP L1

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START