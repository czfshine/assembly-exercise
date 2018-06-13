; 8086 assembly file
; by:czfshine
; date: 2018/06/12 16:18:56

;数字输出的辅助函数
basedata SEGMENT
    chart db '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    _     db 'abcdefghijklmnopqrstuvwxyz@#'
basedata ENDS
base SEGMENT
    ;改变进制输出
    ;bx,si
    rebase PROC FAR USES AX bx CX DX Ds
        MOV AX,baseDATA
        MOV DS,AX
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
            lea bx,chart
            add bx,dx
            mov dl,[bx]
            int 21H
        loop pr
    RET
    rebase ENDP
base ENDS
SHOW32BITBY16 MACRO POS
    PUSH DI
    PUSH SI
    PUSH BX  
    lea di,POS
    mov si,16 ;十六进制显示
    mov bx,[di+2] ;取32位大小的高16位
    call rebase 
    mov bx,[di] ;取32位大小的低16位
    call rebase
    POP BX
    pop SI
    POP DI
ENDM

showdata segment
    
showdata ENDS

show segment
    ;输出Dx指向的字符串，以$结尾，并换行
    printstrln_ PROC FAR USES ax dx
        mov ah,09h
        int 21H
        mov ah,02
        mov dl,0dh
        int 21H
        mov dl,0ah
        int 21H
        RET
    printstrln_ ENDP

    ;输出换行
    CRLF PROC FAR uses AX DX
        mov ah,02
        mov dl,0dh
        int 21H
        mov dl,0ah
        int 21H
        RET
    CRLF ENDP
    printstrln MACRO strpos
        push dx
        lea dx,strpos
        call printstrln_
        pop dx
    ENDM

    printstr MACRO strpos
        push dx
        lea dx,strpos
        mov ah,09h
        int 21H
        pop dx
    ENDM
show ENDS

setcolor MACRO id,r,g,b
    mov al,id
    mov dx,03c8h
    out dx,al

    mov dx,03c9h
    mov al,r
    shr al,1
    shr al,1
    out dx,al
    mov al,g
    shr al,1
    shr al,1
    out dx,al
    mov al,b
    shr al,1
    shr al,1
    out dx,al
ENDM

; The Main Data segment
DATA SEGMENT
    filenamez db '256.bmp',00
    filehandle dw 0;

    s_filesize   db "File size:   $"
    S_IMGWIDTH   DB "IMAGE WIDTH: $"
    S_IMGHEIGHT  DB "IMAGE HEIGHT:$"
    S_DEPTH      DB "IAMGE DEPTH: $"
    S_COLORCOUNT DB "COLOR COUNT: $"
    S_DIPSIZE    DB "DIPB SIZE:   $"
    S_IMGSTART   DB "IMAGE START: $"

    BITMAPINFOHEADER equ 40

    head label far
    ;文件头 14
    magic_number dw 0 ;文件的magic number 一般是BM， 2
                        ;如果不是说明可能不是BMP图片
    size_ dd 0 ;文件大小 4
    dd 0; 4字节的保留位，不管 4
    rapos dd 0;图像数据的偏移地址 4
    ;dib头，只读取基本的 BITMAPINFOHEADER 40字节
    dibsize dd 0;dib 头的大小 4
    imgwidth dd 0 ;图片宽度 4
    imgheight dd 0; 图片高度 4
    dw 0 ; 平面数，有效值为1 2
    bits dw 0; 图像深度 1 2 4 8 16 24 32  2
    DD 4
    DD 4
    DD 4
    DD 4
    COLOER_SIZE DD 0; 调色板大小 4
    DD 4

    colortable db 256 DUP(0,0,0,0);颜色表256个rgba数据
    colortablelen DW 0;颜色表大小 1 16 256 or COLORSIZE

    line db 321 DUP(0);
DATA ENDS

STACK SEGMENT
DW 256 DUP(?)
STACK ENDS
;entry code segment
CODE SEGMENT
    ASSUME CS:CODE ,DS:DATA,SS:STACK
    Main PROC FAR      ;entry point
    MOV AX,DATA
    MOV DS,AX
    MOV AX,STACK
    MOV SS,AX

    ;;open&read filehead 
    mov ah,3dh
    mov al,00h ;只读
    lea dx,filenamez
    int 21h
    jc open_e

    mov filehandle,ax 
    ;读文件头
    mov bx,filehandle ;
    mov ah,3fh
    mov cx,54; 54个字节
    mov dx,head
    int 21h

    ;文件校验=================================================
    cmp magic_number,4d42h;'BM'
    jnz type_e ;文件类型错误

    call SHOWINFO

    lea bx,dibsize
    mov bl,[bx]
    cmp bl,BITMAPINFOHEADER;文件头应该是40
    jnz imgtype_e
    lea bx,bits
    mov bl,[bx]
    cmp bl,8  ;图像深度是8位
    jnz depth_e
    ;===============================================================

    ;设置显示模式
    mov ax,0013h
    int 10h

    CALL readcolortable

    mov cx,colortablelen;颜色表长度为2^bits
    mov si,0  ;rgb: colortable[si+2] colortable[si+1] colortable[si]  +4
    mov bx,0  ;颜色号 +1
    writecolorloop:
        PUSH CX         
        setcolor bl colortable[si+2]   colortable[si+1]  colortable[si]    
        inc si
        inc si
        inc si
        inc si

        inc bl
        POP CX
    loop writecolorloop

    lea bx,imgwidth
    mov cx,[bx]
    cmp cx,320
    ja bigimg_e

    lea bx,imgheight
    mov cx,[bx];高度
    cmp cx,200
    ja bigimg_e

    mov dx,0a000h
    mov es,dx
    mov di,320*199
    writelineloop:
        ;读一行数据
        push cx
        mov cx,320;
        mov bx,filehandle ;
        mov ah,3fh
        lea dx,line
        lea si,line
        int 21h
        jc readline_e
        ;显示一行像素值
        ;si 一行像素数据的首地址
        ;di 显存的首地址
        ;es 显存的段地址
        ;ds 像素数据的段地址
        ;bp 写入的长度，<=320
        MOV BP,320
        call writeline
        sub di,320
        pop cx
    loop writelineloop
    open_e:
    type_e:
    imgtype_e:
    depth_e:
    readcolor_e:
    bigimg_e:
    readline_e:
    TOOBIGBITS_E:
        MOV AH,4CH     ;return
        INT 21H
    RET
    Main ENDP

    SHOWINFOITEM MACRO STRING,NUM
        printstr STRING
        SHOW32BITBY16 NUM
        CALL CRLF
    ENDM
    ;显示文件信息
    SHOWINFO PROC FAR
        SHOWINFOITEM s_filesize size_
        SHOWINFOITEM S_DIPSIZE dibsize
        SHOWINFOITEM S_IMGSTART rapos
        SHOWINFOITEM S_IMGWIDTH imgwidth
        SHOWINFOITEM S_IMGHEIGHT imgheight
        SHOWINFOITEM S_DEPTH bits
        SHOWINFOITEM S_COLORCOUNT COLOER_SIZE
        RET
    SHOWINFO ENDP

    ;显示一行像素值
    ;si 一行像素数据的首地址
    ;di 显存的首地址
    ;es 显存的段地址
    ;ds 像素数据的段地址
    ;dx 写入的长度，<=320
    writeline PROC FAR uses cx si di ds es dx  bp
        mov cx,bp
        rep movsb 
        cmp cx,0
        jnz nothing
        nothing:
        RET
    writeline ENDP
    ;读取颜色表
    readcolortable PROC FAR uses bx cx ax dx di
        lea bx,COLOER_SIZE
        mov cx,[bx]
        cmp cx,0
        ;读颜色表
        mov bx,filehandle ;
        mov ah,3fh
        lea dx,colortable
        jz fullcolor
        mov colortablelen,CX;
        shl cx,1
        shl cx,1 ;乘以4 rgba位
        int 21h
        jc readcolor_e
        RET

        fullcolor:
        MOV CX,bits
        CMP CX,8
        JA TOOBIGBITS_E
        MOV DI,1
        SHL DI,cl
        MOV CX,di
        mov colortablelen,cx
        shl cx,1
        shl cx,1
        INT 21H;READFILE
        RET
    readcolortable ENDP
CODE ENDS
END MAIN