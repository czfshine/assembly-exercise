; 8086 assembly file
; by:czfshine
; date: 2018/04/06 09:41:13

;已知数组A包含15个互不相等的整数，数组B包含20个互不相等的整数。
;试编制一个程序，把既在A中又在B中出现的整数存放于数组C中。

;算法复杂度可达nlogn,但是需要排序函数（todo），所以改用n^2的算法
;显然B比较大，所以从B取数与a比较即可


; The Main Data segment
DATA SEGMENT
    ;todo 大数据类型
    A db 6,5,4,9,8,7,3,2,1,15,13,12,11,14,0,255;16
    alen equ $-A
    ;    can    can't
    B db  8,     101,   5,2,9,6,102,103,104,105, 3,7,4,1,0, 201,202,203,204,205;CD
    blen equ $-B
    _ db 12+32 dup(0);输出好看一点
    C_ db 20 dup(0)
    clen db 0;
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

    ;扫描B中的数放入Al    
    lea bx,B
    mov SI,0

    scana:
        mov al,[bx+si]
        call findBinA
        inc si
        cmp si,blen
    jnz scana

    MOV AH,4CH     ;return
    INT 21H

findBinA:
    push AX
    push bx
    push di
    push es
    push cx

    mov bx,ds
    lea di,a
    add bx,di
    mov es,bx;???!!!!!!!!!!!!!!
    mov DI,0
    xor cx,cx
    mov cl,alen
    cld
    repnz scasb es:[di]
    CMP DI,alen
    jz canfind
    lea di,C_
    mov bl,[clen]
    mov bh,0
    add bx,di
    mov [bx],al
    mov bl,clen
    inc bl
    mov clen,bl
canfind:
    pop cx
    pop es
    pop di
    pop bx
    pop AX
    ret
CODE ENDS
END START