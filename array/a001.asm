; 8086 assembly file
; by:czfshine
; date: 2018/04/03 13:43:26

; The Main Data segment
DATA SEGMENT
    M db 1,2,-3,4,-5,6,7,-8,9,-10,8,6,8,6,81,5,45,68,65,65;
    len equ $ -M
    p db len dup(?)
    lenp dw 0
    n db len dup(?)
    lenn dw 0
DATA ENDS

STACK SEGMENT
DW 256 DUP(?)
TOP LABEL WORD 
STACK ENDS
;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA,SS:STACK
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX
    MOV AX,STACK
    MOV SS,AX
    LEA SP,TOP
    lea bx,M    
    mov si,0
    s:
        mov dl,[bx+si]
        cmp dl,0

        jg hig
        jl lo
        jmp en
        hig:
            push bx
            push si
            lea bx,p
            mov si,lenp
            mov dl,[bx+si]
            inc si
            mov lenp,si
            pop si
            pop bx
            jmp en
        
        lo:
            push bx
            push si
            lea bx,n
            mov si,lenn
            mov dl,[bx+si]
            inc si
            mov lenn,si
            pop si
            pop bx
            jmp en
    en:
        inc si
        cmp si,len
        jnz s

    mov Bx,lenp
    CALL s2210

    MOV DL,','
    MOV AH,02h
    INT 21H
    MOV BX,lenn
    CALL S2210
    
    MOV AH,4CH     ;return
    INT 21H
s2210: 
;Show 2 to 10 
;parm bx
;SEE P003
;use stack

    push SI
    PUSH cx
    PUSH AX
    PUSH BX
    PUSH DX

    ;push all
    MOV SI,10 ;BASE


    mov cx,0;
    MOV AX,BX
    p2:
        MOV DX,0
        DIV SI ;dx ax / 10 = ax......dx
        push dx
        inc cl
        cmp ax ,0
    jnz p2 

    ;pop & print
    mov ah,02h
    pr:
        pop dx
        add dl,'0'
        int 21H
    loop pr
    
    pop  dx
    pop bx
    pop ax
    pop cx
    pop si

    
ret

CODE ENDS
END START