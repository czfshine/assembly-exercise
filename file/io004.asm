; 8086 assembly file
; by:czfshine
; date: 2018/05/10 09:04:42

include FILE.INC
include READ.INC
; The Main Data segment
DATA SEGMENT
    infile db "D:\ABC.txt",0
    infh dw ?
    outfile db "D:\EDF.TXT",0
    outfh dw ?
    ISTR DB 100,?,101 DUP(?)
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


    FOPEN INFH,infile,01h,FILEERROR
    READSTR ISTR   
    FWRITERBUF INFH,ISTR,FILEERROR
    FCLOSE INFH

    ;copy file
    FOPEN INFH,infile,00h,FILEERROR
    ;TODO
    FOPEN outfh,outfile,01H,FILEERROR
    LEA BX,ISTR
    INC BX
    MOV CL,[BX]
    MOV CH,0
    MOV DI,CX
    FREADTOBUF INFH,ISTR,DI,FILEERROR
    FWRITERBUF outfh,ISTR,FILEERROR
    FCLOSE INFH
    FCLOSE outfh

FILEERROR:
    
    ;NOTHING
    MOV AH,4CH     ;return
    INT 21H
CODE ENDS
END START