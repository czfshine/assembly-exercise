; 8086 assembly file
; by:czfshine
; date: 2018/04/05 20:30:48

;试编写一段程序，要求在长度为100H字节的数组中，
;找出大于61H的无符号数的个数并存入字节单元UP中，
;找出小于2FH的无符号数的个数并存入字节单元DOWN中。

; The Main Data segment
DATA SEGMENT

    UP DB 0
    DOWN DB 0

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

    xor dx,dx;dh==up dl ==down

    mov ax,078DH
    MOV es,ax;
    MOV DI,0000H;
    mov CX,100H
    L:
        mov AL,es:[DI]
        cmp al,61H
        ja add_up
        cmp al,2FH
        jb add_down
    ok:
        INC DI
        CMP DI,CX
    jnz L
    JMP return

    add_up:
        inc dh
        jmp ok
    add_down:
        inc dl
        jmp ok
    mov up,dh
    mov DOWN,dl

RETURN:
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START