; 8086 assembly include file
; by:czfshine
; date: 2018/04/06 11:59:12

phexs SEGMENT
;打印十六进制数
;参数在bx
phex PROC FAR
    PUSH AL
    MOV AL,Bh
    CALL B2H
    MOV AL,BL
    CALL B2H
    POP AL
    RET
phex ENDP
;
S1H PROC NEAR
 PUSH DX
    PUSH AX

    CMP DL,9
    JA S1H_1
    ADD DL,'0'
    JMP S1H_S

    S1H_1:
    SUB DL,0AH
    ADD DL,'A'

    S1H_S:
    MOV AH,02H
    INT 21H

    POP AX
    POP DX
    RET
S1H ENDP

;
B2H PROC NEAR
    PUSH AX
    PUSH CX
    PUSH DX
    
    MOV dL,AL
    MOV CL,4
    SHR DL,CL
    CALL S1H
    MOV DL,AL
    AND DL,00001111B
    CALL S1H
    POP DX
    POP CX
    POP AX
    RET
B2H ENDP

phexs ENDS