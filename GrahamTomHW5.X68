*-----------------------------------------------------------
* Title      :  HW 4 Problem 1
* Written by :  Tom Graham
* Date       :  11/5/16
* Description:  This program fills memory with pattern between
*               $0000A000 and 0000A2FF
*-----------------------------------------------------------

addrFirst   EQU $00002000
addrLast    EQU $0003FFFF
data1       EQU $FFFF
data2       EQU $AAAA
data3       EQU $0001
count       EQU $0000

    ORG    $1000
START:                  ; first instruction of program

            LEA     addrLast, A1
            MOVE.W  #count, D2
            
            MOVE.W  #data1, D0 ;Test pattern 1
            JSR     TEST
            NOT     D0
            JSR     TEST
            
            MOVE.W  #data2, D0 ;Test pattern 2
            JSR     TEST
            NOT     D0
            JSR     TEST
            
            MOVE.W  #data3, D0 ; Test pattern 3
            JSR     TEST2
            MOVE.W  #data3, D0
            NOT     D0
            JSR     TEST2

            MOVE.L  A3, BAD_ADDRESS
            MOVE.W  D2, BAD_ADDRESS_COUNT
            
    SIMHALT             ; halt simulator

*VARIABLES

BAD_ADDRESS DS.L 1
BAD_ADDRESS_COUNT DS.W 1

*SUBROUTINES   
 
*Subroutine to perform the test
TEST        JSR     FILL
            JSR     READ
            RTS


*Subroutine to fill address range

FILL        LEA     addrFirst, A0
loop1       MOVE.W  D0, (A0)+
            CMPA.W  A1,A0
            BNE     loop1
            RTS

*Subroutine to compare memory
READ        LEA     addrFirst, A0
loop2       MOVE.W  (A0),D1
            CMP.W   D0, D1
            BEQ     goodAdr ;Doesn't branch when it find a bad address
            MOVEA.L  A0, A2
            ADD.W   #1,D2
goodAdr     ADD.W   #2,A0   ;moves through the addresses
            CMPA.W  A1, A0
            BNE     loop2
            RTS
            
*Subroutine to rotate test bits and test
TEST2       MOVE.B  #0, D3  
loop3       ADD.W   #1, D3
            JSR     TEST
            ROL.W   #$01, D0
            CMP.B   #16, D3
            BNE     loop3     
            RTS

    END    $400        ;last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
