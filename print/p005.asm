; 8086 assembly file
; by:czfshine
; date: 2018/04/03 12:40:28
;试编写一段程序，从键盘接收一个四位的十六进制数(大写）（todo:大小写)，
;并在终端上显示与它等值的二进制数。
; The Main Data segment
DATA SEGMENT
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

    ;input -> BX
    mov ah,01h
    mov Bx,0
    mov cx,4h   
    mov dx,0
    L1:
        push cx
        mov cl,4
        shl bx,cl
        pop cx
        int 21H
        CMP AL,40h
        JB  NUM
        sub al,'A'
        add al,10
        JMP OK
        NUM:
        sub al,'0'
        OK:
        mov dl,al
        add bx,dx
    loop L1

    mov cx,16
    mov ah,02h
    mov si,1000000000000000B
    L2:
        mov dx,bx
        and dx,si
        cmp dx,0
        jz zore
        mov dl,'1'
        jmp print
        zore :
        mov dl,'0'
        print :
        int 21H
        shr si,1
    loop L2




    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START