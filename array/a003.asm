; 8086 assembly file
; by:czfshine
; date: 2018/05/17 11:03:49
;todo
nextw MACRO reg
    inc reg
    inc reg
ENDM

; The Main Data segment
DATA SEGMENT
    mem dw 100 dup(?)
    len equ $-mem
DATA ENDS

STACK SEGMENT
DW 256 DUP(?)
STACK ENDS

fun segment
    ;压缩bx指向的(字）内存段，将所有非零元素向前移，长度为cx
    zipmem PROC FAR
        xor si
        xor di
        l1:
        cmp 0,[bx+si]
        jnc nc
        jc c
        nc:
            nextw si
            nextw di
            mov [bx+di],[bx+si]
            jmp continue
        c :
            nextw si
        continue:
        loop l1
        RET
    zipmem ENDP
fun ends

;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA,SS:STACK
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX
    MOV AX,STACK
    MOV SS,AX
    

    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START