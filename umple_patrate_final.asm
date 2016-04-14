
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

push_all macro
        push cx              ;push all macros
        push dx 
endm

pop_all macro           ;pop all macros
        pop dx
        pop cx
endm 

FILL    MACRO ROW_START,COL_START,ROW_END,COL_END 

        LOCAL START,AGAIN
        push_all
        MOV   DX,ROW_START
START:  MOV   CX,COL_START
AGAIN:  MOV   AH,0CH
        MOV   AL,02
        INT   10H
        INC   CX
        CMP   CX,COL_END
        JNE   AGAIN
        INC   DX
        CMP   DX,ROW_END
        JNE   START
        pop_all
ENDM


SQUARE MACRO CLMN
LOCAL U
LOCAL U1
LOCAL U2
LOCAL U3 


;PUSH_ALL



;square 1
MOV CX,CLMN
MOV DX,10
U:
MOV AH,0CH
MOV AL,02
INT 10H
inc CX
CMP CX,CLMN+10
JNZ U  


;square 2
MOV CX,CLMN
MOV DX,10
U1:
MOV AH,0CH
MOV AL,02
INT 10H
inc dX
CMP dX,20
JNZ U1  


;square 3
MOV CX,CLMN
MOV DX,20
U2:
MOV AH,0CH
MOV AL,02
INT 10H
inc CX
CMP CX,CLMN+10
JNZ U2 


;square 4
MOV CX,CLMN+10
MOV DX,20
U3:
MOV AH,0CH
MOV AL,02
INT 10H
DEC DX
CMP DX,9
JNZ U3

;POP_ALL

ENDM 

;mouse initialisation
initmouse macro
        mov ax,0
        int 33h
endm 


;get mouse coordinates
getmouse macro 

LOCAL L
LOCAL L1
LOCAL L2
LOCAL L3
LOCAL L4
LOCAL M
LOCAL M1
LOCAL M2
LOCAL M3
LOCAL M4
LOCAL M5
LOCAL M6
LOCAL M7

push_all

      ;push all registers
L:
mov ax,1    ;show mouse
int 33h

mov ax,3    ;get position
int 33h
cmp bx,1
jne L  

;case position in square 1 -> fill square 1
CMP CX,25h
JB L1  
JMP X
L1:
FILL 10,10,20,20

JMP EN


X:
;case position in square 2 -> fill square 2
CMP CX,45h
JB L2
JMP XX
L2:
FILL 10,25,20,35

JMP EN


XX:
;case position in square 3 -> fill square 3
CMP CX,65h
Jb L3
JMP XXX
L3:
FILL 10,40,20,50

JMP EN

XXX:
;case position in square 4 -> fill square 4
CMP CX,85h 
JB L4
L4:
FILL 10,55,20,65

JMP EN


pop_all
en:

ENDM

wait_for_key macro

INITMOUSE 
GETMOUSE
ENDM    




.data           

.CODE  

MAIN PROC FAR

mov ax,@data
mov ds,ax 

MOV AH,00
MOV AL,13H
INT 10H

;draw the 4 squares
SQUARE 10
SQUARE 25
SQUARE 40
SQUARE 55  
;mouse coordinates; fill square  
wait_for_key 

;producing sound
mov dl, 07h
mov ah, 2 
int 21h 

int 20h
 

END MAIN  

ret




