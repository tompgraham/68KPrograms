*-----------------------------------------------------------
* Title      : HW 4, Question 2
* Written by : Tom Graham
* Date       : 11/5/16
* Description: This program searches for word $ABC5
*-----------------------------------------------------------
addrFirst   EQU $000A0000
addrLast    EQU $000C0000
value       EQU $ABC5
notFound    EQU $FFFF

    ORG    $1000
START:                  ; first instruction of program

* Put program code here
            LEA     addrFirst, A0
            LEA     addrLast, A1
            MOVE.W  #value, D0
            MOVE.W  #notFound, D2
loop        MOVE.L  A0, D1
            CMP.W   D0, D1
            BEQ     save
            CMP.L   (A0)+, A1
            BNE     loop    
            MOVEA.W  D2, A0        
save        MOVE.L A0, TARGET_ADDRESS            

    SIMHALT             ; halt simulator

* Put variables and constants here

TARGET_ADDRESS DS.L 1

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
