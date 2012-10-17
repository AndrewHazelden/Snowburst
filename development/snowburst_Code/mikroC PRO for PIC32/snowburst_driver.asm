_PMPWaitBusy:
;snowburst_driver.c,46 :: 		void PMPWaitBusy() {
;snowburst_driver.c,47 :: 		while(PMMODEbits.BUSY);
L_PMPWaitBusy0:
LBU	R2, Offset(PMMODEbits+1)(GP)
EXT	R2, R2, 7, 1
BNE	R2, R0, L__PMPWaitBusy37
NOP	
J	L_PMPWaitBusy1
NOP	
L__PMPWaitBusy37:
J	L_PMPWaitBusy0
NOP	
L_PMPWaitBusy1:
;snowburst_driver.c,48 :: 		}
L_end_PMPWaitBusy:
JR	RA
NOP	
; end of _PMPWaitBusy
_Set_Index:
;snowburst_driver.c,50 :: 		void Set_Index(unsigned short index) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_driver.c,51 :: 		TFT_RS = 0;
LBU	R2, Offset(LATB15_bit+1)(GP)
INS	R2, R0, 7, 1
SB	R2, Offset(LATB15_bit+1)(GP)
;snowburst_driver.c,52 :: 		PMDIN = index;
ANDI	R2, R25, 255
SW	R2, Offset(PMDIN+0)(GP)
;snowburst_driver.c,53 :: 		PMPWaitBusy();
JAL	_PMPWaitBusy+0
NOP	
;snowburst_driver.c,54 :: 		}
L_end_Set_Index:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Set_Index
_Write_Command:
;snowburst_driver.c,56 :: 		void Write_Command( unsigned short cmd ) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_driver.c,57 :: 		TFT_RS = 1;
LBU	R2, Offset(LATB15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATB15_bit+1)(GP)
;snowburst_driver.c,58 :: 		PMDIN = cmd;
ANDI	R2, R25, 255
SW	R2, Offset(PMDIN+0)(GP)
;snowburst_driver.c,59 :: 		PMPWaitBusy();
JAL	_PMPWaitBusy+0
NOP	
;snowburst_driver.c,60 :: 		}
L_end_Write_Command:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Write_Command
_Write_Data:
;snowburst_driver.c,62 :: 		void Write_Data(unsigned int _data) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_driver.c,63 :: 		TFT_RS = 1;
LBU	R2, Offset(LATB15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATB15_bit+1)(GP)
;snowburst_driver.c,64 :: 		PMDIN = _data;
ANDI	R2, R25, 65535
SW	R2, Offset(PMDIN+0)(GP)
;snowburst_driver.c,65 :: 		PMPWaitBusy();
JAL	_PMPWaitBusy+0
NOP	
;snowburst_driver.c,66 :: 		}
L_end_Write_Data:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Write_Data
_Init_ADC:
;snowburst_driver.c,69 :: 		void Init_ADC() {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_driver.c,70 :: 		AD1PCFG = 0xFFFF;
ORI	R2, R0, 65535
SW	R2, Offset(AD1PCFG+0)(GP)
;snowburst_driver.c,71 :: 		PCFG12_bit = 0;
LBU	R2, Offset(PCFG12_bit+1)(GP)
INS	R2, R0, 4, 1
SB	R2, Offset(PCFG12_bit+1)(GP)
;snowburst_driver.c,72 :: 		PCFG13_bit = 0;
LBU	R2, Offset(PCFG13_bit+1)(GP)
INS	R2, R0, 5, 1
SB	R2, Offset(PCFG13_bit+1)(GP)
;snowburst_driver.c,74 :: 		ADC1_Init();
JAL	_ADC1_Init+0
NOP	
;snowburst_driver.c,75 :: 		}
L_end_Init_ADC:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _Init_ADC
snowburst_driver_InitializeTouchPanel:
;snowburst_driver.c,76 :: 		static void InitializeTouchPanel() {
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;snowburst_driver.c,77 :: 		Init_ADC();
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
JAL	_Init_ADC+0
NOP	
;snowburst_driver.c,78 :: 		TFT_Set_Active(Set_Index, Write_Command, Write_Data);
LUI	R27, #hi_addr(_Write_Data+0)
ORI	R27, R27, #lo_addr(_Write_Data+0)
LUI	R26, #hi_addr(_Write_Command+0)
ORI	R26, R26, #lo_addr(_Write_Command+0)
LUI	R25, #hi_addr(_Set_Index+0)
ORI	R25, R25, #lo_addr(_Set_Index+0)
JAL	_TFT_Set_Active+0
NOP	
;snowburst_driver.c,79 :: 		TFT_Init(320, 240);
ORI	R26, R0, 240
ORI	R25, R0, 320
JAL	_TFT_Init+0
NOP	
;snowburst_driver.c,81 :: 		TP_TFT_Init(320, 240, 13, 12);                                  // Initialize touch panel
ORI	R28, R0, 12
ORI	R27, R0, 13
ORI	R26, R0, 240
ORI	R25, R0, 320
JAL	_TP_TFT_Init+0
NOP	
;snowburst_driver.c,82 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
ORI	R25, R0, 1000
JAL	_TP_TFT_Set_ADC_Threshold+0
NOP	
;snowburst_driver.c,84 :: 		PenDown = 0;
SB	R0, Offset(_PenDown+0)(GP)
;snowburst_driver.c,85 :: 		PressedObject = 0;
SW	R0, Offset(_PressedObject+0)(GP)
;snowburst_driver.c,86 :: 		PressedObjectType = -1;
ORI	R2, R0, 65535
SH	R2, Offset(_PressedObjectType+0)(GP)
;snowburst_driver.c,87 :: 		}
L_end_InitializeTouchPanel:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of snowburst_driver_InitializeTouchPanel
snowburst_driver_InitializeObjects:
;snowburst_driver.c,98 :: 		static void InitializeObjects() {
;snowburst_driver.c,99 :: 		Screen1.Color                     = 0x0000;
SH	R0, Offset(_Screen1+0)(GP)
;snowburst_driver.c,100 :: 		Screen1.Width                     = 320;
ORI	R2, R0, 320
SH	R2, Offset(_Screen1+2)(GP)
;snowburst_driver.c,101 :: 		Screen1.Height                    = 240;
ORI	R2, R0, 240
SH	R2, Offset(_Screen1+4)(GP)
;snowburst_driver.c,102 :: 		Screen1.ObjectsCount              = 0;
SB	R0, Offset(_Screen1+6)(GP)
;snowburst_driver.c,104 :: 		}
L_end_InitializeObjects:
JR	RA
NOP	
; end of snowburst_driver_InitializeObjects
snowburst_driver_IsInsideObject:
;snowburst_driver.c,106 :: 		static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
;snowburst_driver.c,107 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
; Width start address is: 16 (R4)
LHU	R4, 0(SP)
; Height start address is: 20 (R5)
LHU	R5, 2(SP)
ANDI	R3, R27, 65535
ANDI	R2, R25, 65535
SLTU	R2, R2, R3
BEQ	R2, R0, L_snowburst_driver_IsInsideObject45
NOP	
J	L_snowburst_driver_IsInsideObject31
NOP	
L_snowburst_driver_IsInsideObject45:
ADDU	R2, R27, R4
; Width end address is: 16 (R4)
ADDIU	R2, R2, -1
ANDI	R3, R2, 65535
ANDI	R2, R25, 65535
SLTU	R2, R3, R2
BEQ	R2, R0, L_snowburst_driver_IsInsideObject46
NOP	
J	L_snowburst_driver_IsInsideObject30
NOP	
L_snowburst_driver_IsInsideObject46:
;snowburst_driver.c,108 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
ANDI	R3, R28, 65535
ANDI	R2, R26, 65535
SLTU	R2, R2, R3
BEQ	R2, R0, L_snowburst_driver_IsInsideObject47
NOP	
J	L_snowburst_driver_IsInsideObject29
NOP	
L_snowburst_driver_IsInsideObject47:
ADDU	R2, R28, R5
; Height end address is: 20 (R5)
ADDIU	R2, R2, -1
ANDI	R3, R2, 65535
ANDI	R2, R26, 65535
SLTU	R2, R3, R2
BEQ	R2, R0, L_snowburst_driver_IsInsideObject48
NOP	
J	L_snowburst_driver_IsInsideObject28
NOP	
L_snowburst_driver_IsInsideObject48:
L_snowburst_driver_IsInsideObject27:
;snowburst_driver.c,109 :: 		return 1;
ORI	R2, R0, 1
J	L_end_IsInsideObject
NOP	
;snowburst_driver.c,107 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
L_snowburst_driver_IsInsideObject31:
L_snowburst_driver_IsInsideObject30:
;snowburst_driver.c,108 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
L_snowburst_driver_IsInsideObject29:
L_snowburst_driver_IsInsideObject28:
;snowburst_driver.c,111 :: 		return 0;
MOVZ	R2, R0, R0
;snowburst_driver.c,112 :: 		}
L_end_IsInsideObject:
JR	RA
NOP	
; end of snowburst_driver_IsInsideObject
_DeleteTrailingSpaces:
;snowburst_driver.c,116 :: 		void DeleteTrailingSpaces(char* str){
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_driver.c,119 :: 		while(1) {
L_DeleteTrailingSpaces6:
;snowburst_driver.c,120 :: 		if(str[0] == ' ') {
LBU	R2, 0(R25)
ANDI	R3, R2, 255
ORI	R2, R0, 32
BEQ	R3, R2, L__DeleteTrailingSpaces50
NOP	
J	L_DeleteTrailingSpaces8
NOP	
L__DeleteTrailingSpaces50:
;snowburst_driver.c,121 :: 		for(i = 0; i < strlen(str); i++) {
; i start address is: 20 (R5)
MOVZ	R5, R0, R0
; i end address is: 20 (R5)
L_DeleteTrailingSpaces9:
; i start address is: 20 (R5)
JAL	_strlen+0
NOP	
ANDI	R3, R5, 255
SEH	R2, R2
SLT	R2, R3, R2
BNE	R2, R0, L__DeleteTrailingSpaces51
NOP	
J	L_DeleteTrailingSpaces10
NOP	
L__DeleteTrailingSpaces51:
;snowburst_driver.c,122 :: 		str[i] = str[i+1];
ANDI	R2, R5, 255
ADDU	R3, R25, R2
ANDI	R2, R5, 255
ADDIU	R2, R2, 1
SEH	R2, R2
ADDU	R2, R25, R2
LBU	R2, 0(R2)
SB	R2, 0(R3)
;snowburst_driver.c,121 :: 		for(i = 0; i < strlen(str); i++) {
ADDIU	R2, R5, 1
ANDI	R5, R2, 255
;snowburst_driver.c,123 :: 		}
; i end address is: 20 (R5)
J	L_DeleteTrailingSpaces9
NOP	
L_DeleteTrailingSpaces10:
;snowburst_driver.c,124 :: 		}
J	L_DeleteTrailingSpaces12
NOP	
L_DeleteTrailingSpaces8:
;snowburst_driver.c,126 :: 		break;
J	L_DeleteTrailingSpaces7
NOP	
L_DeleteTrailingSpaces12:
;snowburst_driver.c,127 :: 		}
J	L_DeleteTrailingSpaces6
NOP	
L_DeleteTrailingSpaces7:
;snowburst_driver.c,128 :: 		}
L_end_DeleteTrailingSpaces:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _DeleteTrailingSpaces
_DrawScreen:
;snowburst_driver.c,130 :: 		void DrawScreen(TScreen *aScreen) {
ADDIU	SP, SP, -28
SW	RA, 0(SP)
;snowburst_driver.c,134 :: 		object_pressed = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
SB	R0, Offset(_object_pressed+0)(GP)
;snowburst_driver.c,135 :: 		order = 0;
SH	R0, 24(SP)
;snowburst_driver.c,136 :: 		CurrentScreen = aScreen;
SW	R25, Offset(_CurrentScreen+0)(GP)
;snowburst_driver.c,138 :: 		if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
ADDIU	R2, R25, 2
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LHU	R2, Offset(_display_width+0)(GP)
BEQ	R2, R3, L__DrawScreen53
NOP	
J	L__DrawScreen34
NOP	
L__DrawScreen53:
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 4
LHU	R2, 0(R2)
ANDI	R3, R2, 65535
LHU	R2, Offset(_display_height+0)(GP)
BEQ	R2, R3, L__DrawScreen54
NOP	
J	L__DrawScreen33
NOP	
L__DrawScreen54:
J	L_DrawScreen15
NOP	
L__DrawScreen34:
L__DrawScreen33:
;snowburst_driver.c,139 :: 		save_bled = TFT_BLED;
LBU	R2, Offset(LATA9_bit+1)(GP)
EXT	R2, R2, 1, 1
SB	R2, 26(SP)
;snowburst_driver.c,140 :: 		save_bled_direction = TFT_BLED_Direction;
LBU	R2, Offset(TRISA9_bit+1)(GP)
EXT	R2, R2, 1, 1
SB	R2, 27(SP)
;snowburst_driver.c,141 :: 		TFT_BLED_Direction = 0;
LBU	R2, Offset(TRISA9_bit+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(TRISA9_bit+1)(GP)
;snowburst_driver.c,142 :: 		TFT_BLED           = 0;
LBU	R2, Offset(LATA9_bit+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(LATA9_bit+1)(GP)
;snowburst_driver.c,143 :: 		TFT_Set_Active(Set_Index, Write_Command, Write_Data);
SW	R25, 20(SP)
LUI	R27, #hi_addr(_Write_Data+0)
ORI	R27, R27, #lo_addr(_Write_Data+0)
LUI	R26, #hi_addr(_Write_Command+0)
ORI	R26, R26, #lo_addr(_Write_Command+0)
LUI	R25, #hi_addr(_Set_Index+0)
ORI	R25, R25, #lo_addr(_Set_Index+0)
JAL	_TFT_Set_Active+0
NOP	
;snowburst_driver.c,144 :: 		TFT_Init(CurrentScreen->Width, CurrentScreen->Height);
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 4
LHU	R3, 0(R2)
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 2
LHU	R2, 0(R2)
ANDI	R26, R3, 65535
ANDI	R25, R2, 65535
JAL	_TFT_Init+0
NOP	
;snowburst_driver.c,145 :: 		TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 13, 12);                                  // Initialize touch panel
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 4
LHU	R3, 0(R2)
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 2
LHU	R2, 0(R2)
ORI	R28, R0, 12
ORI	R27, R0, 13
ANDI	R26, R3, 65535
ANDI	R25, R2, 65535
JAL	_TP_TFT_Init+0
NOP	
;snowburst_driver.c,146 :: 		TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
ORI	R25, R0, 1000
JAL	_TP_TFT_Set_ADC_Threshold+0
NOP	
;snowburst_driver.c,147 :: 		TFT_Fill_Screen(CurrentScreen->Color);
LW	R2, Offset(_CurrentScreen+0)(GP)
LHU	R25, 0(R2)
JAL	_TFT_Fill_Screen+0
NOP	
LW	R25, 20(SP)
;snowburst_driver.c,148 :: 		display_width = CurrentScreen->Width;
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 2
LHU	R2, 0(R2)
SH	R2, Offset(_display_width+0)(GP)
;snowburst_driver.c,149 :: 		display_height = CurrentScreen->Height;
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 4
LHU	R2, 0(R2)
SH	R2, Offset(_display_height+0)(GP)
;snowburst_driver.c,150 :: 		TFT_BLED           = save_bled;
LBU	R3, 26(SP)
LBU	R2, Offset(LATA9_bit+1)(GP)
INS	R2, R3, 1, 1
SB	R2, Offset(LATA9_bit+1)(GP)
;snowburst_driver.c,151 :: 		TFT_BLED_Direction = save_bled_direction;
LBU	R3, 27(SP)
LBU	R2, Offset(TRISA9_bit+1)(GP)
INS	R2, R3, 1, 1
SB	R2, Offset(TRISA9_bit+1)(GP)
;snowburst_driver.c,152 :: 		}
J	L_DrawScreen16
NOP	
L_DrawScreen15:
;snowburst_driver.c,154 :: 		TFT_Fill_Screen(CurrentScreen->Color);
LW	R2, Offset(_CurrentScreen+0)(GP)
LHU	R25, 0(R2)
JAL	_TFT_Fill_Screen+0
NOP	
L_DrawScreen16:
;snowburst_driver.c,157 :: 		while (order < CurrentScreen->ObjectsCount) {
L_DrawScreen17:
LW	R2, Offset(_CurrentScreen+0)(GP)
ADDIU	R2, R2, 6
LBU	R2, 0(R2)
ANDI	R3, R2, 255
LH	R2, 24(SP)
SLT	R2, R2, R3
BNE	R2, R0, L__DrawScreen55
NOP	
J	L_DrawScreen18
NOP	
L__DrawScreen55:
;snowburst_driver.c,158 :: 		}
J	L_DrawScreen17
NOP	
L_DrawScreen18:
;snowburst_driver.c,159 :: 		}
L_end_DrawScreen:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 28
JR	RA
NOP	
; end of _DrawScreen
_Get_Object:
;snowburst_driver.c,161 :: 		void Get_Object(unsigned int X, unsigned int Y) {
;snowburst_driver.c,162 :: 		_object_count = -1;
ORI	R2, R0, 65535
SH	R2, Offset(__object_count+0)(GP)
;snowburst_driver.c,163 :: 		}
L_end_Get_Object:
JR	RA
NOP	
; end of _Get_Object
snowburst_driver_Process_TP_Press:
;snowburst_driver.c,166 :: 		static void Process_TP_Press(unsigned int X, unsigned int Y) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_driver.c,168 :: 		Get_Object(X, Y);
JAL	_Get_Object+0
NOP	
;snowburst_driver.c,171 :: 		if (_object_count != -1) {
LH	R3, Offset(__object_count+0)(GP)
LUI	R2, 65535
ORI	R2, R2, 65535
BNE	R3, R2, L_snowburst_driver_Process_TP_Press59
NOP	
J	L_snowburst_driver_Process_TP_Press19
NOP	
L_snowburst_driver_Process_TP_Press59:
;snowburst_driver.c,172 :: 		}
L_snowburst_driver_Process_TP_Press19:
;snowburst_driver.c,173 :: 		}
L_end_Process_TP_Press:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of snowburst_driver_Process_TP_Press
snowburst_driver_Process_TP_Up:
;snowburst_driver.c,175 :: 		static void Process_TP_Up(unsigned int X, unsigned int Y) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_driver.c,178 :: 		Get_Object(X, Y);
JAL	_Get_Object+0
NOP	
;snowburst_driver.c,181 :: 		if (_object_count != -1) {
LH	R3, Offset(__object_count+0)(GP)
LUI	R2, 65535
ORI	R2, R2, 65535
BNE	R3, R2, L_snowburst_driver_Process_TP_Up62
NOP	
J	L_snowburst_driver_Process_TP_Up20
NOP	
L_snowburst_driver_Process_TP_Up62:
;snowburst_driver.c,182 :: 		}
L_snowburst_driver_Process_TP_Up20:
;snowburst_driver.c,183 :: 		PressedObject = 0;
SW	R0, Offset(_PressedObject+0)(GP)
;snowburst_driver.c,184 :: 		PressedObjectType = -1;
ORI	R2, R0, 65535
SH	R2, Offset(_PressedObjectType+0)(GP)
;snowburst_driver.c,185 :: 		}
L_end_Process_TP_Up:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of snowburst_driver_Process_TP_Up
snowburst_driver_Process_TP_Down:
;snowburst_driver.c,187 :: 		static void Process_TP_Down(unsigned int X, unsigned int Y) {
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_driver.c,189 :: 		object_pressed      = 0;
SB	R0, Offset(_object_pressed+0)(GP)
;snowburst_driver.c,191 :: 		Get_Object(X, Y);
JAL	_Get_Object+0
NOP	
;snowburst_driver.c,193 :: 		if (_object_count != -1) {
LH	R3, Offset(__object_count+0)(GP)
LUI	R2, 65535
ORI	R2, R2, 65535
BNE	R3, R2, L_snowburst_driver_Process_TP_Down65
NOP	
J	L_snowburst_driver_Process_TP_Down21
NOP	
L_snowburst_driver_Process_TP_Down65:
;snowburst_driver.c,194 :: 		}
L_snowburst_driver_Process_TP_Down21:
;snowburst_driver.c,195 :: 		}
L_end_Process_TP_Down:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of snowburst_driver_Process_TP_Down
_Check_TP:
;snowburst_driver.c,197 :: 		void Check_TP() {
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;snowburst_driver.c,198 :: 		if (TP_TFT_Press_Detect()) {
SW	R25, 4(SP)
SW	R26, 8(SP)
JAL	_TP_TFT_Press_Detect+0
NOP	
BNE	R2, R0, L__Check_TP68
NOP	
J	L_Check_TP22
NOP	
L__Check_TP68:
;snowburst_driver.c,200 :: 		if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
LUI	R26, #hi_addr(_Ycoord+0)
ORI	R26, R26, #lo_addr(_Ycoord+0)
LUI	R25, #hi_addr(_Xcoord+0)
ORI	R25, R25, #lo_addr(_Xcoord+0)
JAL	_TP_TFT_Get_Coordinates+0
NOP	
ANDI	R2, R2, 255
BEQ	R2, R0, L__Check_TP69
NOP	
J	L_Check_TP23
NOP	
L__Check_TP69:
;snowburst_driver.c,201 :: 		Process_TP_Press(Xcoord, Ycoord);
LHU	R26, Offset(_Ycoord+0)(GP)
LHU	R25, Offset(_Xcoord+0)(GP)
JAL	snowburst_driver_Process_TP_Press+0
NOP	
;snowburst_driver.c,202 :: 		if (PenDown == 0) {
LBU	R2, Offset(_PenDown+0)(GP)
BEQ	R2, R0, L__Check_TP70
NOP	
J	L_Check_TP24
NOP	
L__Check_TP70:
;snowburst_driver.c,203 :: 		PenDown = 1;
ORI	R2, R0, 1
SB	R2, Offset(_PenDown+0)(GP)
;snowburst_driver.c,204 :: 		Process_TP_Down(Xcoord, Ycoord);
LHU	R26, Offset(_Ycoord+0)(GP)
LHU	R25, Offset(_Xcoord+0)(GP)
JAL	snowburst_driver_Process_TP_Down+0
NOP	
;snowburst_driver.c,205 :: 		}
L_Check_TP24:
;snowburst_driver.c,206 :: 		}
L_Check_TP23:
;snowburst_driver.c,207 :: 		}
J	L_Check_TP25
NOP	
L_Check_TP22:
;snowburst_driver.c,208 :: 		else if (PenDown == 1) {
LBU	R3, Offset(_PenDown+0)(GP)
ORI	R2, R0, 1
BEQ	R3, R2, L__Check_TP71
NOP	
J	L_Check_TP26
NOP	
L__Check_TP71:
;snowburst_driver.c,209 :: 		PenDown = 0;
SB	R0, Offset(_PenDown+0)(GP)
;snowburst_driver.c,210 :: 		Process_TP_Up(Xcoord, Ycoord);
LHU	R26, Offset(_Ycoord+0)(GP)
LHU	R25, Offset(_Xcoord+0)(GP)
JAL	snowburst_driver_Process_TP_Up+0
NOP	
;snowburst_driver.c,211 :: 		}
L_Check_TP26:
L_Check_TP25:
;snowburst_driver.c,212 :: 		}
L_end_Check_TP:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _Check_TP
_Init_MCU:
;snowburst_driver.c,214 :: 		void Init_MCU() {
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;snowburst_driver.c,215 :: 		PMMODE = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R0, Offset(PMMODE+0)(GP)
;snowburst_driver.c,216 :: 		PMAEN  = 0;
SW	R0, Offset(PMAEN+0)(GP)
;snowburst_driver.c,217 :: 		PMCON  = 0;  // WRSP: Write Strobe Polarity bit
SW	R0, Offset(PMCON+0)(GP)
;snowburst_driver.c,218 :: 		PMMODEbits.MODE = 2;     // Master 2
ORI	R3, R0, 2
LHU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R3, 8, 2
SH	R2, Offset(PMMODEbits+0)(GP)
;snowburst_driver.c,219 :: 		PMMODEbits.WAITB = 0;
LBU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R0, 6, 2
SB	R2, Offset(PMMODEbits+0)(GP)
;snowburst_driver.c,220 :: 		PMMODEbits.WAITM = 1;
ORI	R3, R0, 1
LBU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R3, 2, 4
SB	R2, Offset(PMMODEbits+0)(GP)
;snowburst_driver.c,221 :: 		PMMODEbits.WAITE = 0;
LBU	R2, Offset(PMMODEbits+0)(GP)
INS	R2, R0, 0, 2
SB	R2, Offset(PMMODEbits+0)(GP)
;snowburst_driver.c,222 :: 		PMMODEbits.MODE16 = 1;   // 16 bit mode
LBU	R2, Offset(PMMODEbits+1)(GP)
ORI	R2, R2, 4
SB	R2, Offset(PMMODEbits+1)(GP)
;snowburst_driver.c,223 :: 		PMCONbits.CSF = 0;
LBU	R2, Offset(PMCONbits+0)(GP)
INS	R2, R0, 6, 2
SB	R2, Offset(PMCONbits+0)(GP)
;snowburst_driver.c,224 :: 		PMCONbits.PTRDEN = 1;
LBU	R2, Offset(PMCONbits+1)(GP)
ORI	R2, R2, 1
SB	R2, Offset(PMCONbits+1)(GP)
;snowburst_driver.c,225 :: 		PMCONbits.PTWREN = 1;
LBU	R2, Offset(PMCONbits+1)(GP)
ORI	R2, R2, 2
SB	R2, Offset(PMCONbits+1)(GP)
;snowburst_driver.c,226 :: 		PMCONbits.PMPEN = 1;
LBU	R2, Offset(PMCONbits+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(PMCONbits+1)(GP)
;snowburst_driver.c,227 :: 		TP_TFT_Rotate_180(0);
MOVZ	R25, R0, R0
JAL	_TP_TFT_Rotate_180+0
NOP	
;snowburst_driver.c,228 :: 		TFT_Set_Active(Set_Index,Write_Command,Write_Data);
LUI	R27, #hi_addr(_Write_Data+0)
ORI	R27, R27, #lo_addr(_Write_Data+0)
LUI	R26, #hi_addr(_Write_Command+0)
ORI	R26, R26, #lo_addr(_Write_Command+0)
LUI	R25, #hi_addr(_Set_Index+0)
ORI	R25, R25, #lo_addr(_Set_Index+0)
JAL	_TFT_Set_Active+0
NOP	
;snowburst_driver.c,229 :: 		}
L_end_Init_MCU:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _Init_MCU
_Start_TP:
;snowburst_driver.c,231 :: 		void Start_TP() {
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;snowburst_driver.c,232 :: 		Init_MCU();
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
JAL	_Init_MCU+0
NOP	
;snowburst_driver.c,234 :: 		InitializeTouchPanel();
JAL	snowburst_driver_InitializeTouchPanel+0
NOP	
;snowburst_driver.c,237 :: 		TP_TFT_Set_Calibration_Consts(76, 907, 77, 915);    // Set calibration constants
ORI	R28, R0, 915
ORI	R27, R0, 77
ORI	R26, R0, 907
ORI	R25, R0, 76
JAL	_TP_TFT_Set_Calibration_Consts+0
NOP	
;snowburst_driver.c,239 :: 		InitializeObjects();
JAL	snowburst_driver_InitializeObjects+0
NOP	
;snowburst_driver.c,240 :: 		display_width = Screen1.Width;
LHU	R2, Offset(_Screen1+2)(GP)
SH	R2, Offset(_display_width+0)(GP)
;snowburst_driver.c,241 :: 		display_height = Screen1.Height;
LHU	R2, Offset(_Screen1+4)(GP)
SH	R2, Offset(_display_height+0)(GP)
;snowburst_driver.c,242 :: 		DrawScreen(&Screen1);
LUI	R25, #hi_addr(_Screen1+0)
ORI	R25, R25, #lo_addr(_Screen1+0)
JAL	_DrawScreen+0
NOP	
;snowburst_driver.c,243 :: 		}
L_end_Start_TP:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _Start_TP
