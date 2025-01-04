.model small
.stack 100h
.data
    msj1 db "Introduceti numarul caruia doriti sa ii calculati factorialul",10,"$"
    msj2 db "!=$"
    zeroMsj db "0!=1$"
    

.code
;description
citireNumar PROC
    mov ax,@data
    mov ds,ax 
    xor bx,bx
    push bx
    mov cx,10
    citireCifra:
        mov ah,01h
        int 21h
        cmp al,13
            je numarCitit
        sub al,48
        mov bl,al
        pop ax 
        mul cx  
        add ax,bx 
        push ax
        jmp citireCifra
    numarCitit:
        pop ax
        ret
citireNumar ENDP

;description
afisareNumar PROC
    mov bx,10 
    xor cx,cx
    descompunere:
        xor dx,dx 
        div bx 
        push dx
        inc cx 
        cmp ax,0 
            je afisare
        jmp descompunere
    afisare:
        mov ah,02h
        pop dx 
        add dx,48 
        int 21h 
        loop afisare
        ret  
afisareNumar ENDP

;description
factorial PROC
    mov bx,ax 
    xor ax,ax 
    inc ax
    push ax
    xor cx,cx 
    inc cx 
    for:
        cmp cx,bx 
            ja finish
        pop ax
        mul cx 
        push ax
        inc cx
    jmp for

    finish:
    pop ax
    ret
factorial ENDP
main:
    mov ax,@data
    mov ds,ax
    mesaj MACRO msj
        mov ah,09h
        lea dx,msj 
        int 21h
    ENDM
    mesaj msj1
    call citireNumar
    cmp ax,0
        je zero 
    jmp notZero
    zero:
        mesaj zeroMsj 
        jmp stop
    notZero:
    push ax
    call afisareNumar
    mesaj msj2
    pop ax 
    call factorial
    call afisareNumar
   
    stop:
    mov ah,4ch
    int 21h
end main
