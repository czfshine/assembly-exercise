DATA SEGMENT
    STRING1 DB 'ABCDE'
    COUNT 	DW $-STRING1
    STRING2 DB 'ABCDE'
    STRING3 DB 'MATCH$'
    STRING4 DB 'NO MATCH$'
DATA ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATA,SS:STACKS
START:
    MOV AX,DATA
    MOV DS,AX
    MOV es,AX
    LEA SI,STRING1
    LEA DI,STRING2
    MOV CX,COUNT
	CLD
	REPE CMPSB
    JNZ L1
    JCXZ L2
L1:	LEA CX,STRING4
	MOV DX,CX
	MOV AH,9
	INT 21H
	JMP L3
L2:	LEA CX,STRING3
	MOV DX,CX
	MOV AH,9
	INT 21H
L3:
    ;此处输入代码段代码
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START