; 8086 assembly file
; by:czfshine
; date: 2018/04/02 21:32:46

;试编写一段程序，要求比较两个字符串string1和string2所含字符是否相等，
;如相等则显示“MATCH”,
;若不相同则显示“NO MATCH”。

; The Main Data segment
DATA SEGMENT
    string1 DB 255,?,255 dup(?) ;
    string2 DB 255,?,255 dup(?) ;

    mat DB 'MATCH',0DH,0AH,'$';
    nmat DB 'NO MATCH',0DH,0AH,'$';
DATA ENDS

;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX

    LEA DX,string1
    MOV AH,0AH
    INT 21H

    MOV AH,02H
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H

    LEA DX,string2
    MOV AH,0AH
    INT 21H

    
    MOV AH,02H
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H

    ;;下面循环里面没有特殊功能的寄存器：
    ;  DI ,DX, 第一个字符串
    ; SP,BP 第二个字符串
    ; ah,al 当前两个字符（或长度)

    ;比较长度
    LEA DI,string1
    LEA SP,string2
    MOV SI,1

    MOV BX,DI
    MOV AH,[BX+SI]

    MOV BX,SP
    MOV AL,[BX+SI]

    CMP AL,AH
    JNZ NOTMATCH

    MOV CH,0
    MOV CL,AL

    MOV DX,2;
    MOV BP,2;

    L0:
        MOV BX,DI
        MOV SI,DX
        MOV AH,[BX+SI]

        MOV BX,SP
        MOV SI,BP
        MOV AL,[BX+SI]
        CMP AL,AH
        JNZ NOTMATCH

        INC DX;
        INC BP;
    LOOP L0

MATCH:
    LEA dx,mat
    jmp print
NOTMATCH:
    LEA dx,nmat
print:
    MOV ah,09h
    int 21h
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START