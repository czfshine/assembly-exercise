; 8086 assembly file
; by:czfshine
; date: 2018/03/31 16:32:37

;从键盘上输入一个字符串（以“#”作为结束输入标记），然后对其中的非数字字符计数，并显示计数结果
;TODO >10
; The Main Data segment
DATA SEGMENT
DATA ENDS

;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX
    
    MOV BX,0
    MOV AH,01H
    L1:
        INT 21H

        cmp al,'#'
        jz L2
        cmp al,'0'
        jb count
        cmp al,'9'
        ja count
        jmp L1
    count:
        INC BX
        JMP L1
    L2:
        MOV DL,BL
        ADD DL,'0'
        MOV AH,02H
        INT 21H

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START