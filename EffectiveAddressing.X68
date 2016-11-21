*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    
UNKNOWN_DATA MACRO
    PRINT_ADDRESS_DATA
    PRINT <''>,ENDL
    ADVANCE_POINTER 2 *advance a word

    ENDM

PRINT   MACRO
* print the text string
* use ENDL as second argument to add return and linefeed
* Thanks to Chuck Kelly for this: http://www.easy68k.com/EASy68Kforum/viewtopic.php?t=622
   SECTION   TEXT
MSG\@   DC.B   \1
   IFARG   2
     IFC     '\2','ENDL'
      DC.B   $D,$A
     ENDC
   ENDC
   DC.B   0
   SECTION   CODE
   
   MOVEM.L   D0/A1,-(SP)
   LEA      MSG\@,A1
   MOVE.B   #14,D0
   TRAP   #15
   MOVEM.L   (SP)+,D0/A1
   ENDM


JumpTable3Bits MACRO
* Takes in 1 Argument: The Jump Table Name
*
*
* Outputs a jump table with 16 entries (4 bits) with the name <Arg1>_jmpt
\1_jmpt
               JMP         \1_code000
               JMP         \1_code001
               JMP         \1_code010
               JMP         \1_code011
               JMP         \1_code100
               JMP         \1_code101
               JMP         \1_code110
               JMP         \1_code111
    ENDM

JMP_INSTRUCTION_SIZE EQU 6
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

    LEA mode_jmpt, A2

    MOVE.W #0,D0

    MULU    #JMP_INSTRUCTION_SIZE, D0
    
    JSR     (A2,D0)
    JumpTable3Bits mode

    **D1, D2: Current mode, current register
    **D2, D3: Source Register, Source Mode
    **D4, D5: Dest Register, Dest Mode

mode_code000  *Data Register Direct
    LEA     data_register_jmpt, A2
    MOVE.W  D1,D0
    MULU    #JMP_INSTRUCTION_SIZE, D0
    JSR     (A2,D0)
    RTS
mode_code001  *Address Register Direct
    LEA     address_register_jmpt, A2
    MOVE.W  D1,D0
    MULU    #JMP_INSTRUCTION_SIZE, D0
    JSR     (A2,D0)
    RTS
mode_code010  *Address Register Indirect
    LEA     address_register_jmpt, A2
    MOVE.W  D1,D0
    MULU    #JMP_INSTRUCTION_SIZE, D0
    PRINT <'('>
    JSR     (A2,D0)
    PRINT <')'>
    RTS
mode_code011  *Address Register Indirect with PostIncrement
    LEA     address_register_jmpt, A2
    MOVE.W  D1,D0
    MULU    #JMP_INSTRUCTION_SIZE, D0
    PRINT <'('>
    JSR     (A2,D0)
    PRINT <') +'>
    RTS
mode_code100  *Address Register with PreIncrement
    LEA     address_register_jmpt, A2
    MOVE.W  D1,D0
    MULU    #JMP_INSTRUCTION_SIZE, D0
    PRINT <'-('>
    JSR     (A2,D0)
    PRINT <')'>
    RTS
mode_code101  *Not supported, Should never get here
mode_code110  *Address Register Indirect with Index
mode_code111  *Special Addressing Modes
    LEA     spmode_jmpt, A2
    MOVE.W  D1,D0
    MULU    #JMP_INSTRUCTION_SIZE, D0
    JSR     (A2,D0)
    RTS
    JumpTable3Bits spmode

spmode_code000 *Absolute Short
spmode_code001 *Absolute Long
spmode_code010 *Should never get here
spmode_code011 *Not supported, Should never get here
spmode_code100 *Should never get here
spmode_code101 *Program Counter Indirect with Displacement
spmode_code110 *Should never get here
spmode_code111 *Immediate

    JumpTable3Bits data_register

data_register_code000
    PRINT <'D0'>
    RTS
data_register_code001
    PRINT <'D1'>
    RTS
data_register_code010
    PRINT <'D2'>
    RTS
data_register_code011
    PRINT <'D3'>
    RTS
data_register_code100
    PRINT <'D4'>
    RTS
data_register_code101
    PRINT <'D5'>
    RTS
data_register_code110
    PRINT <'D6'>
    RTS
data_register_code111
    PRINT <'D7'>
    RTS

    JumpTable3Bits address_register

address_register_code000
    PRINT <'A0'>
    RTS
address_register_code001
    PRINT <'A1'>
    RTS
address_register_code010
    PRINT <'A2'>
    RTS
address_register_code011
    PRINT <'A3'>
    RTS
address_register_code100
    PRINT <'A4'>
    RTS
address_register_code101
    PRINT <'A5'>
    RTS
address_register_code110
    PRINT <'A6'>
    RTS
address_register_code111
    PRINT <'A7'>
    RTS

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*Effective Addresss Jump Tables*



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
