; 8086 assembly include file
; by:czfshine
; date: 2018/04/06 18:04:58

base SEGMENT
    ;改变进制输出
    ;bx,si
    rebase PROC FAR USES AX CX DX
        XOR CX,CX
        MOV AX,BX
        p:
            MOV DX,0
            DIV SI ;dx ax / 10 = ax......dx
            push dx
            inc cl
            cmp ax ,0
        jnz p 

        ;pop & print
        mov ah,02h
        pr:
            pop dx
            add dl,'0'
            int 21H
        loop pr
    RET
    rebase ENDP
base ENDS