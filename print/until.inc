; 8086 assembly include file
; by:czfshine
; date: 2018/04/06 18:18:43

UNTIL SEGMENT
    ;
    CRLF PROC FAR uses ax DX

        mov ah,02h
        mov Dl,13
        int 21h
        mov Dl,10
        int 21h
        RET
    CRLF ENDP
UNTIL ENDS