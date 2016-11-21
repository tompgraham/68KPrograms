*-----------------------------------------------------------
* Title      :  HW 5
* Written by :  Tom Graham
* Date       :  11/5/16
* Description:  This is a memory test that fills a block of
*               memory with various patterns of data, reads
*               the data back, and notes the address of the
*               last bad address and the number of total
*               bad addresses
*               EC: The SF Movie about giants ants is THEM!
*-----------------------------------------------------------

addrFirst   EQU $00002000
addrLast    EQU $0003FFFF
data1       EQU $FFFF
data2       EQU $AAAA
data3       EQU $0001
count       EQU $0000

    ORG    $1000
START:                  ; first instruction of program

            MOVEA.L #$000A0000, A7
            LEA     addrLast, A1
            MOVE.W  #count, D3
            
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

            
            MOVE.W  D3, BAD_ADDRESS_COUNT ; Save total bad addresses
            MOVE.L  A2, BAD_ADDRESS ; Save recent bad address
            MOVE.W  D4, BAD_ADDRESS_EXPECTED ; Save recent expected data
            MOVE.W  D5, BAD_ADDRESS_RECEIVED ; Save recent data received
            
            
    SIMHALT             ; halt simulator

*VARIABLES

BAD_ADDRESS DS.L 1
BAD_ADDRESS_EXPECTED DS.W 1
BAD_ADDRESS_RECEIVED DS.W 1
BAD_ADDRESS_COUNT DS.W 1

*SUBROUTINES   
 
*Subroutine to perform the test
TEST        JSR     FILL
            JSR     READ
            RTS


*Subroutine to fill address range
FILL        LEA     addrFirst, A0
loop1       MOVE.W  D0, (A0)+
            CMPA.L  A1,A0
            BLE     loop1
            RTS

*Subroutine to compare memory
READ        LEA     addrFirst, A0
loop2       MOVE.W  (A0),D1
            CMP.W   D0, D1
            BEQ     goodAdr ;Doesn't branch when it find a bad address
            
            MOVEA.L  A0, A2
            ADD.W   #1,D3
            MOVE.W  D0, D4
            MOVE.W  D1, D5
            
            
goodAdr     ADD.W   #2,A0   ;moves through the addresses
            CMPA.L  A1, A0
            BLE     loop2
            RTS
            
*Subroutine to rotate test bits and test
TEST2       MOVE.B  #0, D2  
loop3       ADD.W   #1, D2
            JSR     TEST
            ROL.W   #$01, D0
            CMP.B   #16, D2
            BNE     loop3     
            RTS

    END START ;last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
