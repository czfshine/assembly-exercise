; 8086 assembly file
; by:czfshine
; date: 2018/05/17 10:47:16

; The Main Data segment
DATA SEGMENT
    len equ 100DH
DATA ENDS

STACK SEGMENT
DW 256 DUP(?)
STACK ENDS

fun segment

    ;把ax和dx里较小的数送入ax内
    minw PROC FAR
        cmp ax,dx
        jl return
        mov ax,dx 
        return:
        RET
    minw ENDP
    ;寻找以es开头的，长度为cx的字数组中的最小偶数
    findminodd PROC FAR
        mov ax,0ffffh
        xor si,si
        mov bx,es
        l1:
            mov dx,[bx+si]
            test dx,0001H
            jnz continue
            call minw
        continue:
            inc si
            inc si
        loop l1
        RET
    findminodd ENDP
fun ends
;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA,SS:STACK
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX
    MOV AX,STACK
    MOV SS,AX
    mov es,ax
    mov cx,len
    call findminodd
    ;结果在ax
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START