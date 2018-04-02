; 8086 assembly file
; by:czfshine
; date: 2018/04/02 21:06:03

;从键盘上输入一串字符（用回车键结束，使用10号功能调用。），
;将其中的小写英文字母变换为大写英文字母，其他字符保持不变。
;然后将变换后的字符串显示出来。

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
    MOV SI,1
    MOV AH,02H
    MOV CL,[BX]
    MOV CH,0
    
    L1:
        MOV DL,[bx+SI]

        CMP DL,'a'
        JB L2
        CMP DL,'z'
        JA L2
            SUB DL,20H
    L2:
        INT 21H
        INC SI
    LOOP L1

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START