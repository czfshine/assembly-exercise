; 8086 assembly file
; by:czfshine
; date: 2018/05/02 23:52:42

;把B加到A
;A B使用数组形式，
; The Main Data segment
DATA SEGMENT
    A db 8,0ffH,0ffH,0,0,0,0,0,0
    B DB 7,1,0,0,0,0,0,0
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
    
    lea BX,A
    MOV DX,BX
    lea BX,B
    MOV DI,BX

    lea bx,A
    mov al,[bx]
    lea bx,b
    mov ah,[bx]
    cmp al,ah
    ja e
    xchg DX,di
    e:
    lea bx,A
    MOV CX,0
    mov cL,[bx]
    MOV ES,CX
    lea bx,b
    MOV CX,0
    mov cL,[bx]

    inc DX
    inc di

    MOV si,0
    MOV ah,0
    CLC
    L1:
        popf
        mov BX,di
        MOV al,[BX+si]
        mov bx,DX
        ADC AL,[BX+si]
        MOV [BX+si],AL
        INC si
        pushf
        CMP si,cX
    JNZ L1
    MOV BX,SP
    MOV CX,ES
    L2:
        popf
        MOV AL,[BX+SI]
        ADC AL,0
        INC SI
        pushf
        CMP SI,CX
    JNZ L2
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START