*-----------------------------------------------------------
* Title      : HW 4, Question 2
* Written by : Tom Graham
* Date       : 11/5/16
* Description: This program searches for word $ABC5
*-----------------------------------------------------------
addrFirst   EQU $000A0000
addrLast    EQU $000C0000
value       EQU $ABC5

    ORG    $1000
START:                  ; first instruction of program

* Put program code here
            LEA     addrFirst, A0
            LEA     addrLast, A1
            MOVE.L  #value, D0
loop        MOVE.L  (A0)+, D1
            CMP.W   D0, D1
            BNE     loop            
            

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
