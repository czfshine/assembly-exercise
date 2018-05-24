; 8086 assembly file
; by:czfshine
; date: 2018/05/17 11:03:49
; 有一个首地址为mem的100个字的数组，
; 试编制程序删除数组中所有为零的项，
; 并将后续项向前压缩，最后将数组的剩余部分补上零
nextw MACRO reg
    inc reg
    inc reg
ENDM

; The Main Data segment
DATA SEGMENT
    mem dw 1,2,3,4,5,6,7,8,9,0,0,0,0,1,0,1,0,1,0,1, 80 dup(2),255,254 ;待压缩的数字
    len equ $-mem
DATA ENDS

STACK SEGMENT
DW 256 DUP(?)
STACK ENDS

fun segment
    ;压缩bx指向的(字）内存段，将所有非零元素向前移，长度为cx
    ;inplace O(n)的算法
    zipmem PROC FAR uses si di cx
        ;两个指针
        xor si,si ; 未压缩数组的末端
        xor di,di ; 非零元素的末端的后一个
        
        one :;开始移动一个
            mov ax,[bx+si]
            cmp ax,0
            je c111
            nc:
                mov [bx+di],ax
                nextw si
                nextw di
                jmp continue
            c111:
                nextw si
            continue:
        loop one
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
    
    lea bx,mem
    mov cx,len
    call zipmem
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START