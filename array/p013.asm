; 8086 assembly file
; by:czfshine
; date: 2018/05/17 10:09:50
;在附加段中，有一个首地址为LIST和未经排序的字数组。
;在数组的第一个字中，存放着该数组的长度，数组的首地址已存放在DI寄存器中，
;AX寄存器中存放着一个数。要求编制一个程序：
;在数组中查找该数，如果找到此数，则把它从数组中删除。
; The Main Data segment
DATA SEGMENT
     LIST DW 8,1,2,3,4,5,6,7,8
DATA ENDS

STACK SEGMENT
DW 256 DUP(?)
STACK ENDS

fun segment
    ;寻找di指向的缓冲区内与ax相同的数据，并删除
    findandremove PROC FAR
        mov bx,di
        mov cx,[bx]
        mov dx,di
        inc di
        inc di
        REPNE scasw
        cmp cx,0
        je return 
        mov si,[bx]
        sub si,cx
        shl si,1
        loop2:
            mov dx,[bx+si+2]
            mov [bx+si],dx
            inc si
            inc si
            dec cx
            cmp cx,0
        jnz loop2
        mov si,[bx]
        dec si
        mov [bx],si
    return :
        RET
    findandremove ENDP
fun ENDS

;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA,SS:STACK,ES:DATA
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX
    MOV ES,AX
    MOV AX,STACK
    MOV SS,AX
    LEA DI,LIST
    MOV AX,5
    CALL findandremove

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START