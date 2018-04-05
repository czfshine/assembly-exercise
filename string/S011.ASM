; 8086 assembly file
; by:czfshine
; date: 2018/04/05 21:03:54

;在内存区域0B800:0000-0B800:0FFFF（都是16进制数）内
;查找首地址为SOURCE的串（SOURCE的首字节为串长度），
;如果找到，则把AL的第0位置0，否则将该位置置1

; The Main Data segment
DATA SEGMENT
    SOURCE DB 'CZFSHINE',0DH,0AH,'$';
    len equ $-SOURCE
DATA ENDS

STACK SEGMENT
DW 256 DUP(?)
STACK ENDS
;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA,SS:STACK
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX
    MOV AX,STACK
    MOV SS,AX
    

    MOV AX,0B800h
    MOV ES,AX
    MOV di,0

    MOV CX,0FFFh
    cld
    
    mov al,SOURCE
    FIND:
        
        REPNZ SCASb es:[di]
        cmp al,es:[di]
        jnz can_t_find ;end of CX
        
            ;find source[0] in es:[di]
            push di
            inc di
            sub CX,di ;cx:剩下的字符数
            push CX;;over flow
            
            CMP CX,len
            JB can_t_find ;剩下长度不够，肯定找不到

            MOV CX,len;接下来的比较次数
            ;cmp source[0-len] and es:[di->di+len]

            lea si,source
            lea DX,SOURCE
            ADD DX,len;字符串结束位置

            repz cmpsb ds:[si],es:[di]

            cmp DX,si;一样就找到
            JZ FIND_IT
            POP CX;从上一个相等的地方开始从来
            POP di
    JMP FIND

can_t_find:
    and al,11111110B
    jmp return
FIND_IT:
    or al,00000001b
return:
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START