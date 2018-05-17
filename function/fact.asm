; 8086 assembly file
; by:czfshine
; date: 2018/05/16 21:35:08

; The Main Data segment
DATA SEGMENT
DATA ENDS

STACK SEGMENT
DW 256 DUP(?)
STACK ENDS


;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA,SS:STACK
     ;计算x的阶乘，压入y中
    FACT PROC  C uses ax dx, 
                x:word,y:word ;void fact(short x,short&y){
        mov ax,2              ;     if(x<2){
        cmp x,ax              ;         y=1;
        jb exit1              ;         return ;}
        xor ax,ax             ;     short yy=0;
        push ax;返回值        ;
        mov ax,x              ;     short xx=x-1
        dec ax                ;
        push ax;参数          ;
        call FACT             ;     fact(xx,yy);
        ;平衡栈               ;      
        pop ax                ;     
        pop ax ;返回值         ;
        mul x                 ;
        mov y,ax              ;     y=x*yy;
        ret                   ;     return;}
    exit1:
        mov y,1
        RET
    FACT ENDP
START:                ;entry point
    MOV AX,DATA
    MOV DS,AX
    MOV AX,STACK
    MOV SS,AX
    
    xor ax,ax
    push ax ;返回值
    mov ax,6
    push ax ;参数
    call FACT
    pop ax
    pop ax;返回值
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START