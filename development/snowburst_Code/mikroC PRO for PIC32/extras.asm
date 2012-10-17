_IsCollision:
;extras.c,6 :: 		unsigned int Button_Left, unsigned int Button_Top, unsigned int Button_Width, unsigned int Button_Height) {
;extras.c,10 :: 		if( ((Shape_X + Shape_Width) >= Button_Left )               &&              ((Shape_X) <= (Button_Left + Button_Width-1)) &&
; Button_Left start address is: 16 (R4)
LHU	R4, 0(SP)
; Button_Top start address is: 20 (R5)
LHU	R5, 2(SP)
; Button_Width start address is: 24 (R6)
LHU	R6, 4(SP)
; Button_Height start address is: 28 (R7)
LHU	R7, 6(SP)
ADDU	R2, R25, R27
ANDI	R3, R2, 65535
ANDI	R2, R4, 65535
SLTU	R2, R3, R2
BEQ	R2, R0, L__IsCollision10
NOP	
J	L__IsCollision8
NOP	
L__IsCollision10:
ADDU	R2, R4, R6
; Button_Left end address is: 16 (R4)
; Button_Width end address is: 24 (R6)
ADDIU	R2, R2, -1
ANDI	R3, R25, 65535
ANDI	R2, R2, 65535
SLTU	R2, R2, R3
BEQ	R2, R0, L__IsCollision11
NOP	
J	L__IsCollision7
NOP	
L__IsCollision11:
;extras.c,15 :: 		((Shape_Y + Shape_Height) >= Button_Top )                   &&               ((Shape_Y) <= (Button_Top + Button_Height-1))  ) {
ADDU	R2, R26, R28
ANDI	R3, R2, 65535
ANDI	R2, R5, 65535
SLTU	R2, R3, R2
BEQ	R2, R0, L__IsCollision12
NOP	
J	L__IsCollision6
NOP	
L__IsCollision12:
ADDU	R2, R5, R7
; Button_Top end address is: 20 (R5)
; Button_Height end address is: 28 (R7)
ADDIU	R2, R2, -1
ANDI	R3, R26, 65535
ANDI	R2, R2, 65535
SLTU	R2, R2, R3
BEQ	R2, R0, L__IsCollision13
NOP	
J	L__IsCollision5
NOP	
L__IsCollision13:
L__IsCollision4:
;extras.c,22 :: 		return 1;
ORI	R2, R0, 1
J	L_end_IsCollision
NOP	
;extras.c,10 :: 		if( ((Shape_X + Shape_Width) >= Button_Left )               &&              ((Shape_X) <= (Button_Left + Button_Width-1)) &&
L__IsCollision8:
L__IsCollision7:
;extras.c,15 :: 		((Shape_Y + Shape_Height) >= Button_Top )                   &&               ((Shape_Y) <= (Button_Top + Button_Height-1))  ) {
L__IsCollision6:
L__IsCollision5:
;extras.c,28 :: 		return 0;
MOVZ	R2, R0, R0
;extras.c,31 :: 		}
L_end_IsCollision:
JR	RA
NOP	
; end of _IsCollision
_UART1_Write_Line:
;extras.c,34 :: 		void UART1_Write_Line(char *uart_text) {
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;extras.c,35 :: 		UART1_Write_Text(uart_text);
SW	R25, 4(SP)
JAL	_UART1_Write_Text+0
NOP	
;extras.c,36 :: 		UART1_Write(13);
ORI	R25, R0, 13
JAL	_UART1_Write+0
NOP	
;extras.c,37 :: 		UART1_Write(10);
ORI	R25, R0, 10
JAL	_UART1_Write+0
NOP	
;extras.c,38 :: 		}
L_end_UART1_Write_Line:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _UART1_Write_Line
_UART1_Write_Variable:
;extras.c,42 :: 		void UART1_Write_Variable(int var) {
ADDIU	SP, SP, -24
SW	RA, 0(SP)
;extras.c,44 :: 		IntToStr(var, var_txt);
SW	R25, 4(SP)
SW	R26, 8(SP)
ADDIU	R2, SP, 12
MOVZ	R26, R2, R0
JAL	_IntToStr+0
NOP	
;extras.c,45 :: 		UART1_Write_Text(var_txt);
ADDIU	R2, SP, 12
MOVZ	R25, R2, R0
JAL	_UART1_Write_Text+0
NOP	
;extras.c,46 :: 		UART1_Write(13);
ORI	R25, R0, 13
JAL	_UART1_Write+0
NOP	
;extras.c,47 :: 		UART1_Write(10);
ORI	R25, R0, 10
JAL	_UART1_Write+0
NOP	
;extras.c,48 :: 		}
L_end_UART1_Write_Variable:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 24
JR	RA
NOP	
; end of _UART1_Write_Variable
_UART1_Write_Long_Variable:
;extras.c,51 :: 		void UART1_Write_Long_Variable(long var){
ADDIU	SP, SP, -32
SW	RA, 0(SP)
;extras.c,53 :: 		LongToStr(var, var_txt);
SW	R25, 4(SP)
SW	R26, 8(SP)
ADDIU	R2, SP, 12
MOVZ	R26, R2, R0
JAL	_LongToStr+0
NOP	
;extras.c,54 :: 		UART1_Write_Text(var_txt);
ADDIU	R2, SP, 12
MOVZ	R25, R2, R0
JAL	_UART1_Write_Text+0
NOP	
;extras.c,55 :: 		UART1_Write(13);
ORI	R25, R0, 13
JAL	_UART1_Write+0
NOP	
;extras.c,56 :: 		UART1_Write(10);
ORI	R25, R0, 10
JAL	_UART1_Write+0
NOP	
;extras.c,57 :: 		}
L_end_UART1_Write_Long_Variable:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 32
JR	RA
NOP	
; end of _UART1_Write_Long_Variable
_UART1_Write_Label_Var:
;extras.c,60 :: 		void UART1_Write_Label_Var(char *uart_text, int var ) {
ADDIU	SP, SP, -24
SW	RA, 0(SP)
;extras.c,63 :: 		UART1_Write_Text(uart_text);
SW	R25, 4(SP)
SW	R26, 8(SP)
JAL	_UART1_Write_Text+0
NOP	
;extras.c,64 :: 		IntToStr(var, var_txt);
ADDIU	R2, SP, 12
SEH	R25, R26
MOVZ	R26, R2, R0
JAL	_IntToStr+0
NOP	
;extras.c,65 :: 		UART1_Write_Text(var_txt);
ADDIU	R2, SP, 12
MOVZ	R25, R2, R0
JAL	_UART1_Write_Text+0
NOP	
;extras.c,66 :: 		UART1_Write(13);
ORI	R25, R0, 13
JAL	_UART1_Write+0
NOP	
;extras.c,67 :: 		UART1_Write(10);
ORI	R25, R0, 10
JAL	_UART1_Write+0
NOP	
;extras.c,68 :: 		}
L_end_UART1_Write_Label_Var:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 24
JR	RA
NOP	
; end of _UART1_Write_Label_Var
_UART1_Write_Label_Long_Var:
;extras.c,72 :: 		void UART1_Write_Label_Long_Var(char *uart_text, long var){
ADDIU	SP, SP, -32
SW	RA, 0(SP)
;extras.c,75 :: 		UART1_Write_Text(uart_text);
SW	R25, 4(SP)
SW	R26, 8(SP)
JAL	_UART1_Write_Text+0
NOP	
;extras.c,76 :: 		LongToStr(var, var_txt);
ADDIU	R2, SP, 12
MOVZ	R25, R26, R0
MOVZ	R26, R2, R0
JAL	_LongToStr+0
NOP	
;extras.c,77 :: 		UART1_Write_Text(var_txt);
ADDIU	R2, SP, 12
MOVZ	R25, R2, R0
JAL	_UART1_Write_Text+0
NOP	
;extras.c,78 :: 		UART1_Write(13);
ORI	R25, R0, 13
JAL	_UART1_Write+0
NOP	
;extras.c,79 :: 		UART1_Write(10);
ORI	R25, R0, 10
JAL	_UART1_Write+0
NOP	
;extras.c,80 :: 		}
L_end_UART1_Write_Label_Long_Var:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 32
JR	RA
NOP	
; end of _UART1_Write_Label_Long_Var
_UART1_Write_Label_Float_Var:
;extras.c,83 :: 		void UART1_Write_Label_Float_Var(char *uart_text, float var){
ADDIU	SP, SP, -32
SW	RA, 0(SP)
;extras.c,86 :: 		UART1_Write_Text(uart_text);
SW	R25, 4(SP)
SW	R26, 8(SP)
JAL	_UART1_Write_Text+0
NOP	
;extras.c,87 :: 		FloatToStr(var, var_txt);
ADDIU	R2, SP, 12
MOVZ	R25, R26, R0
MOVZ	R26, R2, R0
JAL	_FloatToStr+0
NOP	
;extras.c,88 :: 		UART1_Write_Text(var_txt);
ADDIU	R2, SP, 12
MOVZ	R25, R2, R0
JAL	_UART1_Write_Text+0
NOP	
;extras.c,89 :: 		UART1_Write(13);
ORI	R25, R0, 13
JAL	_UART1_Write+0
NOP	
;extras.c,90 :: 		UART1_Write(10);
ORI	R25, R0, 10
JAL	_UART1_Write+0
NOP	
;extras.c,91 :: 		}
L_end_UART1_Write_Label_Float_Var:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 32
JR	RA
NOP	
; end of _UART1_Write_Label_Float_Var
