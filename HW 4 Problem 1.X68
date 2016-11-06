*-----------------------------------------------------------
* Title      :  HW 4 Problem 1
* Written by :  Tom Graham
* Date       :  11/5/16
* Description:  This program fills memory with pattern between
*               $0000A000 and 0000A2FF
*-----------------------------------------------------------

addrStart   EQU $0000A000
addrLast    EQU $0000A2FF
data        EQU $5555AAAA

    ORG    $1000
START:                  ; first instruction of program

* Put program code here
            LEA     addrStart, A0
            LEA     addrLast, A1
            MOVE.L  #data, D0
loop        MOVE.L  D0, (A0)+
            CMPA.L  A1,A0
            BLE     loop    
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
