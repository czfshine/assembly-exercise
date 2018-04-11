; 8086 assembly include file
; by:czfshine
; date: 2018/04/07 11:03:50

divt SEGMENT
    YH DW 8000h
    YL DW 0000H
    ;32位除以16位不带溢出版
    ;被除数DX,AX 除数BX
    ;商DX,AX，余数CX
    div32 PROC FAR USES BX DI SI DS
        mov SI,DX
        MOV DI,AX

        mov ax,divt
        mov ds,ax

        xor dx,dx
        xor ax,ax ;R1

        xor cx,cx ;r2

        L:
        ;将被除数最高位左移送入R2，其余位数均左移
            SHL DI,1
            RCL SI,1
            RCL CX,1

            CMP cx,BX
            jb E

                or DX,YH
                OR AX,YL
                SUB CX,BX
            E:
                SHR YH,1
                RCR YL,1
            
            CMP YH,0
        JNZ l
            CMP YL,0
        JNZ L
        ;Ok
        RET
    div32 ENDP
divt ENDS