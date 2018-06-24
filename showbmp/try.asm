data segment
    file db '1.bmp',00
    head db 54 dup(0) ;位图头信息部分00h-35h

    color db 1024 dup(0) ;调色板信息部分36h-0435h
    datas db 64000 dup(0) ;图片数据信息部分,0436h-fa36h
    error1 db 'failed to open file!',24h
    error2 db 'failed to read file!',24h
data ends

stacks segment stack
    dw 100 dup(0)
    top label word
stacks ends

setcolor MACRO id,r,g,b
    mov al,id
    mov dx,03c8h
    out dx,al

    mov dx,03c9h
    mov al,r
    out dx,al ;dx=端口号
    mov al,g
    out dx,al
    mov al,b
    out dx,al
ENDM

code segment
    assume cs:code,ss:stacks,ds:data
main proc far
    mov ax,data
    mov ds,ax
    mov ax,stacks
    mov ss,ax
    lea sp,top
    ;只读方式打开文件
    mov ah,3dh
    mov al,00h
    lea dx,file
    int 21h
    jc openError
    
    ;将文件读入内存从bmphead开始的数据缓冲区
    mov bx,ax ;bx=文件代号
    mov ah,3fh
    mov cx,0fe36h ;cx=读取的字节数,即图片文件大小
    lea dx,head
    int 21h
    jc readError

    ;设置显示模式256色,320×200像素
    mov ax,0013h
    int 10h


    ;设置调色板,输出(OUT)色彩索引号,共写256次
    mov cx,256
    mov bl,0
    mov di,0
    L1:
        mov al,bl
        mov dx,03c8h
        out dx,al

        mov dx,03c9h
        mov al,cl
        out dx,al ;dx=端口号
        mov al,cl
        out dx,al
        mov al,0
        out dx,al

        add di,4
        inc bl
    loop L1

    setcolor 0 0 63 0
    setcolor 1 63 0 0

    ;向显存地址写入数据
    mov ax,0a000h ;显存地址(0A000:0000~0A000:0F9FF)
    mov es,ax
    ;位图中图像由底向上自左向右存储,
    ;而显示屏上要求从上至下
    mov di,63680d ;320*199
    lea si,datas ;故从底写至上,写图像索引号及RGB数据
    mov bx,200

    loop2:
        mov cx,320
        loop1:
            mov al,bl
            add al,cl
            and al ,00000001B
            mov es:[di],al 
            inc di
        loop loop1
        sub di,640 ;写上一行,320+320
        dec bx
        cmp bx,0
    jnz loop2
    jmp exit
openError:
    lea dx,error1
    mov ah,9
    int 21h
    jmp exit
readError:
    lea dx,error2
    mov ah,9
    int 21h
exit:
    mov ah,07h
    int 21h
    mov ah,4ch
    int 21h
main endp
code ends
end main
