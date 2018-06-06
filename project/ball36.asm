DATAS SEGMENT
MESG DB 'WELCOME TO 7/36 SYSTERM','$'
BALL DB 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
     DB 19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36
COUNT DB 36
NUM DB 7 DUP(0)
CRLF DB 0DH,0AH,'$'
DATAS ENDS
;数据段
;BALL 是36个球
;COUNT 是剩余的球的数量
;NUM 抽出来的球
;MESG 提示信息
;CRLF 回车换行
STACKS SEGMENT
       DW 100 DUP(?)
TOP LABEL WORD
STACKS ENDS

CODES SEGMENT
      ASSUME CS:CODES,SS:STACKS,DS:DATAS
MAIN  PROC FAR

      MOV AX,STACKS
      MOV SS,AX
      LEA SP,TOP
      PUSH DS
      SUB AX,AX
      PUSH AX
      MOV AX,DATAS
      MOV DS,AX


      LEA DX,MESG
      MOV AH,09H
      INT 21H
      LEA DX,CRLF
      MOV AH,09H
      INT 21H
    
      MOV BX,OFFSET BALL
      PUSH BX
      MOV BX,OFFSET COUNT
      PUSH BX
      MOV BX,OFFSET NUM
      PUSH BX
      ;数据进栈

      XOR AX,AX
      MOV DI,0 ;抽选计数
   L1:XOR SI,SI
      CALL FAR PTR ROLLB  ;ROLLB 抽选球下标
      CALL FAR PTR DELETE ;DELETE 删除选中的球
      MOV AL,BALL[SI]
      MOV NUM[DI],AL  ;将选中的球存入NUM中
      INC DI
      CMP DI,7
      JNE L1

      XOR SI,SI
      CALL FAR PTR SHOW ;打印球
      MOV AH,4CH
      INT 21H
      RET
 MAIN ENDP
 CODES ENDS

 CODE2 SEGMENT
       ASSUME CS:CODE2
 ROLLB PROC FAR
       PUSH BP
       MOV BP,SP
       PUSH AX
       PUSH DX
       PUSH CX
  NEXT:MOV SI,[BP+8] ;COUNT
       MOV AH,2CH
       INT 21H    ;获取随机数
       CMP DL,[SI];大于剩余球数就重新获取 
       JA NEXT 
       AND DX,00FFH;保留末八位,即DL
       MOV SI,DX;将抽中的数字存在SI，进行参数传递
       POP CX
       POP DX
       POP AX
       POP BP
       RETF
 ROLLB ENDP
 CODE2 ENDS

 CODE3 SEGMENT
       ASSUME CS:CODE3
DELETE PROC FAR
       PUSH BP
       MOV BP,SP
       PUSH AX
       PUSH BX
       PUSH DX
       PUSH CX
       MOV DI,SI ;将上面抽中的数字存在DI
       PUSH SI
       MOV SI,[BP+0AH] ;BALL
       MOV BX,[BP+8] ;COUNT

       MOV AX,[BX]
       SUB AX,DI;计算删除元素要移动几次
       ADD SI,DI;指向抽中的BALL[DI]
       MOV BX,SI
       INC BX  ;BX指向BALL[DI+1]
    L2:MOV DX,[BX]
       MOV [SI],DX;用BALL[DI+1]覆盖掉BALL[DI]
       INC SI
       INC BX;移动指针
       DEC AX;计数
       JNZ L2

       XOR AX,AX
       MOV SI,[BP+8]
       MOV AX,[SI]
       DEC AX
       MOV [SI],AX;删除完毕，剩余球的数量COUNT-1

       POP SI
       POP CX
       POP DX
       POP BX
       POP AX
       POP BP
       RETF
 DELETE ENDP
 CODE3 ENDS

 CODE4 SEGMENT
       ASSUME CS:CODE4
  SHOW PROC FAR
       PUSH BP
       MOV BP,SP
       PUSH AX
       PUSH DX
       PUSH CX
       PUSH DI
       MOV SI,[BP+6];指向NUM
       XOR DI,DI
   ;输出两位数
    L3:MOV DL,[SI]
       MOV AL,DL
       CBW
       MOV CL,10
       DIV CL
       MOV BL,AH
       MOV DL,AL
       ADD DL,30H
       MOV AH,02H
       INT 21H
       MOV DL,BL
       ADD DL,30H
       MOV AH,02H
       INT 21H
       MOV DL,' '
       MOV AH,02H
       INT 21H
       INC DI
       CMP DI,7
       JNE L3
       POP DI
       POP CX
       POP DX
       POP AX
       POP BP
       RETF
  SHOW ENDP
 CODE4 ENDS
 END MAIN

