_main:
;snowburst_main.c,202 :: 		void main() {
;snowburst_main.c,204 :: 		int i = 0;
;snowburst_main.c,205 :: 		int flake_size = 0;
;snowburst_main.c,209 :: 		Start_TP();
JAL	_Start_TP+0
NOP	
;snowburst_main.c,212 :: 		Start_UART();
JAL	_Start_UART+0
NOP	
;snowburst_main.c,215 :: 		Init_Sprites();
JAL	_Init_Sprites+0
NOP	
;snowburst_main.c,218 :: 		TFT_Fill_Screen(sky_color);
LH	R25, Offset(_sky_color+0)(GP)
JAL	_TFT_Fill_Screen+0
NOP	
;snowburst_main.c,221 :: 		file_loaded = 0;
SB	R0, Offset(_file_loaded+0)(GP)
;snowburst_main.c,222 :: 		MP3_Start();
JAL	_MP3_Start+0
NOP	
;snowburst_main.c,225 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVZ	R27, R0, R0
ORI	R26, R0, 65535
LUI	R25, #hi_addr(_TFT_defaultFont+0)
ORI	R25, R25, #lo_addr(_TFT_defaultFont+0)
JAL	_TFT_Set_Font+0
NOP	
;snowburst_main.c,231 :: 		UART1_Write_Line("Starting Snowburst.");
LUI	R25, #hi_addr(?lstr1_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr1_snowburst_main+0)
JAL	_UART1_Write_Line+0
NOP	
;snowburst_main.c,233 :: 		TP_TFT_Press_Detect();
JAL	_TP_TFT_Press_Detect+0
NOP	
;snowburst_main.c,234 :: 		TP_TFT_Press_Detect();
JAL	_TP_TFT_Press_Detect+0
NOP	
;snowburst_main.c,236 :: 		while (1){
L_main0:
;snowburst_main.c,238 :: 		TFT_Fill_Screen(sky_color);
LH	R25, Offset(_sky_color+0)(GP)
JAL	_TFT_Fill_Screen+0
NOP	
;snowburst_main.c,241 :: 		ShowTitles();
JAL	_ShowTitles+0
NOP	
;snowburst_main.c,244 :: 		InitGame();
JAL	_InitGame+0
NOP	
;snowburst_main.c,246 :: 		while (!game_over) {
L_main2:
LH	R2, Offset(_game_over+0)(GP)
BEQ	R2, R0, L__main146
NOP	
J	L_main3
NOP	
L__main146:
;snowburst_main.c,249 :: 		if( (frame_counter % 20) == 0){
LW	R3, Offset(_frame_counter+0)(GP)
ORI	R2, R0, 20
DIVU	R3, R2
MFHI	R2
BEQ	R2, R0, L__main147
NOP	
J	L_main4
NOP	
L__main147:
;snowburst_main.c,250 :: 		UART1_Write_Label_Long_Var("Frame: ", frame_counter);
LW	R26, Offset(_frame_counter+0)(GP)
LUI	R25, #hi_addr(?lstr2_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr2_snowburst_main+0)
JAL	_UART1_Write_Label_Long_Var+0
NOP	
;snowburst_main.c,251 :: 		}
L_main4:
;snowburst_main.c,255 :: 		if(play_next_song){
LH	R2, Offset(_play_next_song+0)(GP)
BNE	R2, R0, L__main149
NOP	
J	L_main5
NOP	
L__main149:
;snowburst_main.c,257 :: 		GetNextSong();
JAL	_GetNextSong+0
NOP	
;snowburst_main.c,258 :: 		}
J	L_main6
NOP	
L_main5:
;snowburst_main.c,259 :: 		else if( (frame_counter % 2) == 0){
LW	R2, Offset(_frame_counter+0)(GP)
ANDI	R2, R2, 1
BEQ	R2, R0, L__main150
NOP	
J	L_main7
NOP	
L__main150:
;snowburst_main.c,261 :: 		Play_MP3_Chunk();
JAL	_Play_MP3_Chunk+0
NOP	
;snowburst_main.c,262 :: 		}
L_main7:
L_main6:
;snowburst_main.c,266 :: 		GetInput();
JAL	_GetInput+0
NOP	
;snowburst_main.c,269 :: 		MoveFlakes();
JAL	_MoveFlakes+0
NOP	
;snowburst_main.c,272 :: 		TappedFlake();
JAL	_TappedFlake+0
NOP	
;snowburst_main.c,275 :: 		ClearFlake();
JAL	_ClearFlake+0
NOP	
;snowburst_main.c,278 :: 		RenderScreen();
JAL	_RenderScreen+0
NOP	
;snowburst_main.c,281 :: 		if(muteSound){
LH	R2, Offset(_muteSound+0)(GP)
BNE	R2, R0, L__main152
NOP	
J	L_main8
NOP	
L__main152:
;snowburst_main.c,282 :: 		Delay_ms(25);
LUI	R24, 10
ORI	R24, R24, 11306
L_main9:
ADDIU	R24, R24, -1
BNE	R24, R0, L_main9
NOP	
;snowburst_main.c,283 :: 		}
L_main8:
;snowburst_main.c,286 :: 		SavePrevValues();
JAL	_SavePrevValues+0
NOP	
;snowburst_main.c,287 :: 		}
J	L_main2
NOP	
L_main3:
;snowburst_main.c,290 :: 		ShowGameOver();
JAL	_ShowGameOver+0
NOP	
;snowburst_main.c,291 :: 		}
J	L_main0
NOP	
;snowburst_main.c,293 :: 		}
L_end_main:
L__main_end_loop:
J	L__main_end_loop
NOP	
; end of _main
_MoveFlakes:
;snowburst_main.c,296 :: 		void MoveFlakes(){
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;snowburst_main.c,297 :: 		int i = 0;
SW	R25, 4(SP)
;snowburst_main.c,299 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1); i++){
; i start address is: 20 (R5)
MOVZ	R5, R0, R0
; i end address is: 20 (R5)
L_MoveFlakes11:
; i start address is: 20 (R5)
SEH	R2, R5
SLTI	R2, R2, 3
BNE	R2, R0, L__MoveFlakes155
NOP	
J	L_MoveFlakes12
NOP	
L__MoveFlakes155:
;snowburst_main.c,301 :: 		flakes[i].y += flakes[i].speed;
SEH	R3, R5
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R4, R2, 2
ADDIU	R2, R2, 16
LH	R3, 0(R2)
LH	R2, 0(R4)
ADDU	R2, R2, R3
SH	R2, 0(R4)
;snowburst_main.c,304 :: 		if( (long)(flakes[i].y+flakes[i].height+flakes[i].speed) > (long)(240-snow_height-STATUS_TEXT_HEIGHT)){
SEH	R3, R5
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R4, R2, R3
ADDIU	R2, R4, 2
LH	R3, 0(R2)
ADDIU	R2, R4, 14
LH	R2, 0(R2)
ADDU	R3, R3, R2
ADDIU	R2, R4, 16
LH	R2, 0(R2)
ADDU	R2, R3, R2
SEH	R4, R2
LW	R3, Offset(_snow_height+0)(GP)
ORI	R2, R0, 240
SUBU	R2, R2, R3
ADDIU	R2, R2, -25
SLT	R2, R2, R4
BNE	R2, R0, L__MoveFlakes156
NOP	
J	L_MoveFlakes14
NOP	
L__MoveFlakes156:
;snowburst_main.c,306 :: 		flakeMissed(i);
SH	R5, 8(SP)
SEH	R25, R5
JAL	_flakeMissed+0
NOP	
LH	R5, 8(SP)
;snowburst_main.c,308 :: 		}
L_MoveFlakes14:
;snowburst_main.c,299 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1); i++){
ADDIU	R2, R5, 1
SEH	R5, R2
;snowburst_main.c,310 :: 		}
; i end address is: 20 (R5)
J	L_MoveFlakes11
NOP	
L_MoveFlakes12:
;snowburst_main.c,311 :: 		}
L_end_MoveFlakes:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _MoveFlakes
_Start_UART:
;snowburst_main.c,314 :: 		void Start_UART(){
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;snowburst_main.c,317 :: 		UART1_Init(256000);             // INITIALIZE UART MODULE AT 256000 BAUD
SW	R25, 4(SP)
LUI	R25, 3
ORI	R25, R25, 59392
JAL	_UART1_Init+0
NOP	
;snowburst_main.c,318 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
LUI	R24, 40
ORI	R24, R24, 45226
L_Start_UART15:
ADDIU	R24, R24, -1
BNE	R24, R0, L_Start_UART15
NOP	
;snowburst_main.c,319 :: 		}
L_end_Start_UART:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _Start_UART
_RenderScreen:
;snowburst_main.c,322 :: 		void RenderScreen(){
ADDIU	SP, SP, -24
SW	RA, 0(SP)
;snowburst_main.c,323 :: 		int i = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
;snowburst_main.c,325 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1); i++){
; i start address is: 28 (R7)
MOVZ	R7, R0, R0
; i end address is: 28 (R7)
L_RenderScreen17:
; i start address is: 28 (R7)
SEH	R2, R7
SLTI	R2, R2, 3
BNE	R2, R0, L__RenderScreen159
NOP	
J	L_RenderScreen18
NOP	
L__RenderScreen159:
;snowburst_main.c,327 :: 		DrawFlake(flakes[i].frame, flakes[i].x, flakes[i].y, flakes[i].scale);
SEH	R3, R7
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R6, R2, R3
ADDIU	R2, R6, 10
LH	R5, 0(R2)
ADDIU	R2, R6, 2
LH	R4, 0(R2)
LH	R3, 0(R6)
ADDIU	R2, R6, 8
LH	R2, 0(R2)
SH	R7, 20(SP)
SEH	R28, R5
SEH	R27, R4
SEH	R26, R3
SEH	R25, R2
JAL	_DrawFlake+0
NOP	
LH	R7, 20(SP)
;snowburst_main.c,330 :: 		flakes[i].frame++;
SEH	R3, R7
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 8
LH	R2, 0(R3)
ADDIU	R2, R2, 1
SH	R2, 0(R3)
;snowburst_main.c,332 :: 		if(flakes[i].frame > 13){
SEH	R3, R7
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 8
LH	R2, 0(R2)
SEH	R2, R2
SLTI	R2, R2, 14
BEQ	R2, R0, L__RenderScreen160
NOP	
J	L_RenderScreen20
NOP	
L__RenderScreen160:
;snowburst_main.c,333 :: 		flakes[i].frame = 1;
SEH	R3, R7
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 8
ORI	R2, R0, 1
SH	R2, 0(R3)
;snowburst_main.c,334 :: 		}
L_RenderScreen20:
;snowburst_main.c,325 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1); i++){
ADDIU	R2, R7, 1
SEH	R7, R2
;snowburst_main.c,335 :: 		}
; i end address is: 28 (R7)
J	L_RenderScreen17
NOP	
L_RenderScreen18:
;snowburst_main.c,338 :: 		DrawSnowFall();
JAL	_DrawSnowFall+0
NOP	
;snowburst_main.c,341 :: 		RenderScore();
JAL	_RenderScore+0
NOP	
;snowburst_main.c,343 :: 		}
L_end_RenderScreen:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 24
JR	RA
NOP	
; end of _RenderScreen
_InitGame:
;snowburst_main.c,345 :: 		void InitGame(){
;snowburst_main.c,347 :: 		score = 0;
SW	R0, Offset(_score+0)(GP)
;snowburst_main.c,349 :: 		prev_score = 0;
SW	R0, Offset(_prev_score+0)(GP)
;snowburst_main.c,352 :: 		snow_height = 0;
SW	R0, Offset(_snow_height+0)(GP)
;snowburst_main.c,355 :: 		game_over = 0;
SH	R0, Offset(_game_over+0)(GP)
;snowburst_main.c,356 :: 		}
L_end_InitGame:
JR	RA
NOP	
; end of _InitGame
_FlakeReset:
;snowburst_main.c,358 :: 		void FlakeReset(int flake_number){
ADDIU	SP, SP, -36
SW	RA, 0(SP)
;snowburst_main.c,359 :: 		int offset = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
;snowburst_main.c,360 :: 		int top_clear_flake_pos = 0;
;snowburst_main.c,362 :: 		int small_speed_boost = 0;
;snowburst_main.c,363 :: 		int large_speed_boost = 0;
; large_speed_boost start address is: 12 (R3)
MOVZ	R3, R0, R0
;snowburst_main.c,367 :: 		if(score > 20000){
LW	R2, Offset(_score+0)(GP)
SLTI	R2, R2, 20001
BEQ	R2, R0, L__FlakeReset163
NOP	
J	L_FlakeReset21
NOP	
L__FlakeReset163:
; large_speed_boost end address is: 12 (R3)
;snowburst_main.c,368 :: 		small_speed_boost = 2;
; small_speed_boost start address is: 28 (R7)
ORI	R7, R0, 2
;snowburst_main.c,369 :: 		large_speed_boost = 1;
; large_speed_boost start address is: 24 (R6)
ORI	R6, R0, 1
;snowburst_main.c,370 :: 		}
; large_speed_boost end address is: 24 (R6)
; small_speed_boost end address is: 28 (R7)
J	L_FlakeReset22
NOP	
L_FlakeReset21:
;snowburst_main.c,371 :: 		else if(score > 10000){
; large_speed_boost start address is: 12 (R3)
LW	R2, Offset(_score+0)(GP)
SLTI	R2, R2, 10001
BEQ	R2, R0, L__FlakeReset164
NOP	
J	L_FlakeReset23
NOP	
L__FlakeReset164:
;snowburst_main.c,372 :: 		small_speed_boost = 2;
; small_speed_boost start address is: 28 (R7)
ORI	R7, R0, 2
;snowburst_main.c,373 :: 		}
SEH	R6, R3
; small_speed_boost end address is: 28 (R7)
J	L_FlakeReset24
NOP	
L_FlakeReset23:
;snowburst_main.c,374 :: 		else if(score > 5000){
LW	R2, Offset(_score+0)(GP)
SLTI	R2, R2, 5001
BEQ	R2, R0, L__FlakeReset165
NOP	
J	L_FlakeReset25
NOP	
L__FlakeReset165:
;snowburst_main.c,375 :: 		small_speed_boost = 1;
; small_speed_boost start address is: 16 (R4)
ORI	R4, R0, 1
;snowburst_main.c,376 :: 		}
SEH	R7, R4
; large_speed_boost end address is: 12 (R3)
; small_speed_boost end address is: 16 (R4)
SEH	R2, R3
J	L_FlakeReset26
NOP	
L_FlakeReset25:
;snowburst_main.c,378 :: 		small_speed_boost = 0;
; small_speed_boost start address is: 16 (R4)
MOVZ	R4, R0, R0
;snowburst_main.c,379 :: 		large_speed_boost = 0;
; large_speed_boost start address is: 8 (R2)
MOVZ	R2, R0, R0
; small_speed_boost end address is: 16 (R4)
; large_speed_boost end address is: 8 (R2)
SEH	R7, R4
;snowburst_main.c,380 :: 		}
L_FlakeReset26:
; large_speed_boost start address is: 8 (R2)
; small_speed_boost start address is: 28 (R7)
SEH	R6, R2
; large_speed_boost end address is: 8 (R2)
; small_speed_boost end address is: 28 (R7)
L_FlakeReset24:
; small_speed_boost start address is: 28 (R7)
; large_speed_boost start address is: 24 (R6)
; large_speed_boost end address is: 24 (R6)
; small_speed_boost end address is: 28 (R7)
L_FlakeReset22:
;snowburst_main.c,385 :: 		TFT_Set_Pen(sky_color, 1);
; large_speed_boost start address is: 24 (R6)
; small_speed_boost start address is: 28 (R7)
SH	R25, 20(SP)
ORI	R26, R0, 1
LH	R25, Offset(_sky_color+0)(GP)
JAL	_TFT_Set_Pen+0
NOP	
;snowburst_main.c,388 :: 		TFT_Set_Brush(1, sky_color, 0, TOP_TO_BOTTOM, sky_color, sky_color);
MOVZ	R28, R0, R0
MOVZ	R27, R0, R0
LH	R26, Offset(_sky_color+0)(GP)
ORI	R25, R0, 1
LH	R2, Offset(_sky_color+0)(GP)
ADDIU	SP, SP, -4
SH	R2, 2(SP)
LH	R2, Offset(_sky_color+0)(GP)
SH	R2, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
LH	R25, 20(SP)
;snowburst_main.c,394 :: 		top_clear_flake_pos = flakes[flake_number].y-flakes[flake_number].speed;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R4, R2, R3
ADDIU	R2, R4, 2
LH	R3, 0(R2)
ADDIU	R2, R4, 16
LH	R2, 0(R2)
SUBU	R2, R3, R2
; top_clear_flake_pos start address is: 32 (R8)
SEH	R8, R2
;snowburst_main.c,395 :: 		if(top_clear_flake_pos < 0){
SEH	R2, R2
SLTI	R2, R2, 0
BNE	R2, R0, L__FlakeReset166
NOP	
J	L__FlakeReset131
NOP	
L__FlakeReset166:
;snowburst_main.c,396 :: 		top_clear_flake_pos = 0;
MOVZ	R8, R0, R0
; top_clear_flake_pos end address is: 32 (R8)
;snowburst_main.c,397 :: 		}
J	L_FlakeReset27
NOP	
L__FlakeReset131:
;snowburst_main.c,395 :: 		if(top_clear_flake_pos < 0){
;snowburst_main.c,397 :: 		}
L_FlakeReset27:
;snowburst_main.c,400 :: 		TFT_Rectangle(flakes[flake_number].x,top_clear_flake_pos, flakes[flake_number].x+flakes[flake_number].width, flakes[flake_number].y+flakes[flake_number].height);
; top_clear_flake_pos start address is: 32 (R8)
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R5, R2, R3
ADDIU	R2, R5, 2
LH	R3, 0(R2)
ADDIU	R2, R5, 14
LH	R2, 0(R2)
ADDU	R4, R3, R2
LH	R3, 0(R5)
ADDIU	R2, R5, 12
LH	R2, 0(R2)
ADDU	R2, R3, R2
SH	R7, 20(SP)
SH	R6, 22(SP)
SH	R25, 24(SP)
SEH	R28, R4
SEH	R27, R2
SEH	R26, R8
; top_clear_flake_pos end address is: 32 (R8)
SEH	R25, R3
JAL	_TFT_Rectangle+0
NOP	
LH	R25, 24(SP)
LH	R6, 22(SP)
LH	R7, 20(SP)
;snowburst_main.c,403 :: 		flakes[flake_number].x = ((320 + 32)/ NUMBER_OF_FLAKES) * flake_number + ( getRandom(120) - 60);
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
SW	R2, 32(SP)
ORI	R2, R0, 117
MUL	R2, R2, R25
SH	R2, 28(SP)
SH	R25, 20(SP)
ORI	R25, R0, 120
JAL	_GetRandom+0
NOP	
LH	R25, 20(SP)
ADDIU	R3, R2, -60
LH	R2, 28(SP)
ADDU	R3, R2, R3
LW	R2, 32(SP)
SH	R3, 0(R2)
;snowburst_main.c,406 :: 		if(  flakes[flake_number].x < 0){
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
LH	R2, 0(R2)
SEH	R2, R2
SLTI	R2, R2, 0
BNE	R2, R0, L__FlakeReset167
NOP	
J	L_FlakeReset28
NOP	
L__FlakeReset167:
;snowburst_main.c,407 :: 		flakes[flake_number].x = 0;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
SH	R0, 0(R2)
;snowburst_main.c,408 :: 		}
L_FlakeReset28:
;snowburst_main.c,409 :: 		if(  flakes[flake_number].x > 290){
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
LH	R2, 0(R2)
SEH	R2, R2
SLTI	R2, R2, 291
BEQ	R2, R0, L__FlakeReset168
NOP	
J	L_FlakeReset29
NOP	
L__FlakeReset168:
;snowburst_main.c,410 :: 		flakes[flake_number].x = 290;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R3, R2, R3
ORI	R2, R0, 290
SH	R2, 0(R3)
;snowburst_main.c,411 :: 		}
L_FlakeReset29:
;snowburst_main.c,414 :: 		flakes[flake_number].y = 0;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 2
SH	R0, 0(R2)
;snowburst_main.c,416 :: 		flakes[flake_number].prev_x = flakes[flake_number].x;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 4
LH	R2, 0(R2)
SH	R2, 0(R3)
;snowburst_main.c,417 :: 		flakes[flake_number].prev_y = flakes[flake_number].y;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 6
ADDIU	R2, R2, 2
LH	R2, 0(R2)
SH	R2, 0(R3)
;snowburst_main.c,420 :: 		flakes[flake_number].frame = getRandom(13);
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 8
SW	R2, 28(SP)
SH	R25, 20(SP)
ORI	R25, R0, 13
JAL	_GetRandom+0
NOP	
LH	R25, 20(SP)
LW	R3, 28(SP)
SH	R2, 0(R3)
;snowburst_main.c,424 :: 		flakes[flake_number].scale = getRandom(2);
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 10
SW	R2, 28(SP)
SH	R25, 20(SP)
ORI	R25, R0, 2
JAL	_GetRandom+0
NOP	
LH	R25, 20(SP)
LW	R3, 28(SP)
SH	R2, 0(R3)
;snowburst_main.c,427 :: 		if(flakes[flake_number].scale == 1){
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 10
LH	R2, 0(R2)
SEH	R3, R2
ORI	R2, R0, 1
BEQ	R3, R2, L__FlakeReset169
NOP	
J	L_FlakeReset30
NOP	
L__FlakeReset169:
;snowburst_main.c,428 :: 		flakes[flake_number].width = 32;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 12
ORI	R2, R0, 32
SH	R2, 0(R3)
;snowburst_main.c,429 :: 		flakes[flake_number].height = 32;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 14
ORI	R2, R0, 32
SH	R2, 0(R3)
;snowburst_main.c,430 :: 		}
J	L_FlakeReset31
NOP	
L_FlakeReset30:
;snowburst_main.c,432 :: 		flakes[flake_number].width = 64;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 12
ORI	R2, R0, 64
SH	R2, 0(R3)
;snowburst_main.c,433 :: 		flakes[flake_number].height = 64;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 14
ORI	R2, R0, 64
SH	R2, 0(R3)
;snowburst_main.c,434 :: 		}
L_FlakeReset31:
;snowburst_main.c,443 :: 		if (flakes[flake_number].scale  == 1){
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 10
LH	R2, 0(R2)
SEH	R3, R2
ORI	R2, R0, 1
BEQ	R3, R2, L__FlakeReset170
NOP	
J	L_FlakeReset32
NOP	
L__FlakeReset170:
; large_speed_boost end address is: 24 (R6)
;snowburst_main.c,445 :: 		flakes[flake_number].speed = getRandom(4)+small_speed_boost;
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 16
SW	R2, 28(SP)
ORI	R25, R0, 4
JAL	_GetRandom+0
NOP	
ADDU	R3, R2, R7
; small_speed_boost end address is: 28 (R7)
LW	R2, 28(SP)
SH	R3, 0(R2)
;snowburst_main.c,446 :: 		}
J	L_FlakeReset33
NOP	
L_FlakeReset32:
;snowburst_main.c,449 :: 		flakes[flake_number].speed = getRandom(3)+large_speed_boost;
; large_speed_boost start address is: 24 (R6)
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 16
SW	R2, 28(SP)
ORI	R25, R0, 3
JAL	_GetRandom+0
NOP	
ADDU	R3, R2, R6
; large_speed_boost end address is: 24 (R6)
LW	R2, 28(SP)
SH	R3, 0(R2)
;snowburst_main.c,450 :: 		}
L_FlakeReset33:
;snowburst_main.c,452 :: 		}
L_end_FlakeReset:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 36
JR	RA
NOP	
; end of _FlakeReset
_SavePrevValues:
;snowburst_main.c,455 :: 		void SavePrevValues(){
;snowburst_main.c,459 :: 		frame_counter++;
LW	R2, Offset(_frame_counter+0)(GP)
ADDIU	R2, R2, 1
SW	R2, Offset(_frame_counter+0)(GP)
;snowburst_main.c,462 :: 		prev_snow_height = snow_height;
LW	R2, Offset(_snow_height+0)(GP)
SW	R2, Offset(_prev_snow_height+0)(GP)
;snowburst_main.c,465 :: 		prev_score = score;
LW	R2, Offset(_score+0)(GP)
SW	R2, Offset(_prev_score+0)(GP)
;snowburst_main.c,469 :: 		prev_muteSound = muteSound;
LH	R2, Offset(_muteSound+0)(GP)
SH	R2, Offset(_prev_muteSound+0)(GP)
;snowburst_main.c,472 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1);i++){
; i start address is: 16 (R4)
MOVZ	R4, R0, R0
; i end address is: 16 (R4)
L_SavePrevValues34:
; i start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 3
BNE	R2, R0, L__SavePrevValues172
NOP	
J	L_SavePrevValues35
NOP	
L__SavePrevValues172:
;snowburst_main.c,473 :: 		flakes[i].prev_x = flakes[i].x;
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 4
LH	R2, 0(R2)
SH	R2, 0(R3)
;snowburst_main.c,474 :: 		flakes[i].prev_y = flakes[i].y;
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 6
ADDIU	R2, R2, 2
LH	R2, 0(R2)
SH	R2, 0(R3)
;snowburst_main.c,472 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1);i++){
ADDIU	R2, R4, 1
SEH	R4, R2
;snowburst_main.c,475 :: 		}
; i end address is: 16 (R4)
J	L_SavePrevValues34
NOP	
L_SavePrevValues35:
;snowburst_main.c,476 :: 		}
L_end_SavePrevValues:
JR	RA
NOP	
; end of _SavePrevValues
_FlakeMissed:
;snowburst_main.c,478 :: 		void FlakeMissed(int flake_number)
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_main.c,482 :: 		if(flakes[flake_number].scale == 1){
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 10
LH	R2, 0(R2)
SEH	R3, R2
ORI	R2, R0, 1
BEQ	R3, R2, L__FlakeMissed174
NOP	
J	L_FlakeMissed37
NOP	
L__FlakeMissed174:
;snowburst_main.c,485 :: 		if(snow_height > 120){
LW	R2, Offset(_snow_height+0)(GP)
SLTI	R2, R2, 121
BEQ	R2, R0, L__FlakeMissed175
NOP	
J	L_FlakeMissed38
NOP	
L__FlakeMissed175:
;snowburst_main.c,487 :: 		snow_height+=3;
LW	R2, Offset(_snow_height+0)(GP)
ADDIU	R2, R2, 3
SW	R2, Offset(_snow_height+0)(GP)
;snowburst_main.c,488 :: 		}
J	L_FlakeMissed39
NOP	
L_FlakeMissed38:
;snowburst_main.c,491 :: 		snow_height+=7;
LW	R2, Offset(_snow_height+0)(GP)
ADDIU	R2, R2, 7
SW	R2, Offset(_snow_height+0)(GP)
;snowburst_main.c,492 :: 		}
L_FlakeMissed39:
;snowburst_main.c,494 :: 		}
J	L_FlakeMissed40
NOP	
L_FlakeMissed37:
;snowburst_main.c,496 :: 		else if(flakes[flake_number].scale ==2){
SEH	R3, R25
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 10
LH	R2, 0(R2)
SEH	R3, R2
ORI	R2, R0, 2
BEQ	R3, R2, L__FlakeMissed176
NOP	
J	L_FlakeMissed41
NOP	
L__FlakeMissed176:
;snowburst_main.c,498 :: 		if(snow_height > 120){
LW	R2, Offset(_snow_height+0)(GP)
SLTI	R2, R2, 121
BEQ	R2, R0, L__FlakeMissed177
NOP	
J	L_FlakeMissed42
NOP	
L__FlakeMissed177:
;snowburst_main.c,500 :: 		snow_height+=7;
LW	R2, Offset(_snow_height+0)(GP)
ADDIU	R2, R2, 7
SW	R2, Offset(_snow_height+0)(GP)
;snowburst_main.c,501 :: 		}
J	L_FlakeMissed43
NOP	
L_FlakeMissed42:
;snowburst_main.c,504 :: 		snow_height+=15;
LW	R2, Offset(_snow_height+0)(GP)
ADDIU	R2, R2, 15
SW	R2, Offset(_snow_height+0)(GP)
;snowburst_main.c,505 :: 		}
L_FlakeMissed43:
;snowburst_main.c,507 :: 		}
L_FlakeMissed41:
L_FlakeMissed40:
;snowburst_main.c,509 :: 		FlakeReset(flake_number);
JAL	_FlakeReset+0
NOP	
;snowburst_main.c,511 :: 		}
L_end_FlakeMissed:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _FlakeMissed
_TappedFlake:
;snowburst_main.c,514 :: 		void TappedFlake(){
ADDIU	SP, SP, -24
SW	RA, 0(SP)
;snowburst_main.c,517 :: 		int tapped_flake_size = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
;snowburst_main.c,521 :: 		if( Pen_Down && (abs(X_Drag_Distance) < 10)  ){
LBU	R2, Offset(_Pen_Down+0)(GP)
BNE	R2, R0, L__TappedFlake180
NOP	
J	L__TappedFlake134
NOP	
L__TappedFlake180:
LH	R25, Offset(_X_Drag_Distance+0)(GP)
JAL	_abs+0
NOP	
SEH	R2, R2
SLTI	R2, R2, 10
BNE	R2, R0, L__TappedFlake181
NOP	
J	L__TappedFlake133
NOP	
L__TappedFlake181:
L__TappedFlake132:
;snowburst_main.c,524 :: 		for(i=0;i<NUMBER_OF_FLAKES;i++){
; i start address is: 32 (R8)
MOVZ	R8, R0, R0
; i end address is: 32 (R8)
L_TappedFlake47:
; i start address is: 32 (R8)
SEH	R2, R8
SLTI	R2, R2, 3
BNE	R2, R0, L__TappedFlake182
NOP	
J	L_TappedFlake48
NOP	
L__TappedFlake182:
;snowburst_main.c,527 :: 		if(IsCollision (X_Coord-TAP_RADIUS, Y_Coord-TAP_RADIUS, TAP_RADIUS*2, TAP_RADIUS*2, flakes[i].x, flakes[i].y, flakes[i].width, flakes[i].height) ){
SEH	R3, R8
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R3, R2, R3
ADDIU	R2, R3, 14
LH	R7, 0(R2)
ADDIU	R2, R3, 12
LH	R6, 0(R2)
ADDIU	R2, R3, 2
LH	R5, 0(R2)
LH	R4, 0(R3)
LHU	R2, Offset(_Y_Coord+0)(GP)
ADDIU	R3, R2, -15
LHU	R2, Offset(_X_Coord+0)(GP)
ADDIU	R2, R2, -15
SH	R8, 20(SP)
ORI	R28, R0, 30
ORI	R27, R0, 30
ANDI	R26, R3, 65535
ANDI	R25, R2, 65535
ADDIU	SP, SP, -8
SH	R7, 6(SP)
SH	R6, 4(SP)
SH	R5, 2(SP)
SH	R4, 0(SP)
JAL	_IsCollision+0
NOP	
ADDIU	SP, SP, 8
LH	R8, 20(SP)
BNE	R2, R0, L__TappedFlake184
NOP	
J	L_TappedFlake50
NOP	
L__TappedFlake184:
;snowburst_main.c,530 :: 		if(flakes[i].scale == 1){
SEH	R3, R8
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 10
LH	R2, 0(R2)
SEH	R3, R2
ORI	R2, R0, 1
BEQ	R3, R2, L__TappedFlake185
NOP	
J	L_TappedFlake51
NOP	
L__TappedFlake185:
;snowburst_main.c,532 :: 		score+= 50;
LW	R2, Offset(_score+0)(GP)
ADDIU	R2, R2, 50
SW	R2, Offset(_score+0)(GP)
;snowburst_main.c,533 :: 		}
J	L_TappedFlake52
NOP	
L_TappedFlake51:
;snowburst_main.c,536 :: 		score+= 25;
LW	R2, Offset(_score+0)(GP)
ADDIU	R2, R2, 25
SW	R2, Offset(_score+0)(GP)
;snowburst_main.c,537 :: 		}
L_TappedFlake52:
;snowburst_main.c,542 :: 		FlakeReset(i);
SH	R8, 20(SP)
SEH	R25, R8
JAL	_FlakeReset+0
NOP	
LH	R8, 20(SP)
;snowburst_main.c,544 :: 		}
L_TappedFlake50:
;snowburst_main.c,524 :: 		for(i=0;i<NUMBER_OF_FLAKES;i++){
ADDIU	R2, R8, 1
SEH	R8, R2
;snowburst_main.c,546 :: 		}
; i end address is: 32 (R8)
J	L_TappedFlake47
NOP	
L_TappedFlake48:
;snowburst_main.c,521 :: 		if( Pen_Down && (abs(X_Drag_Distance) < 10)  ){
L__TappedFlake134:
L__TappedFlake133:
;snowburst_main.c,550 :: 		}
L_end_TappedFlake:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 24
JR	RA
NOP	
; end of _TappedFlake
_DrawFlake:
;snowburst_main.c,553 :: 		void DrawFlake(int frame, int x, int y, int scale){
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;snowburst_main.c,555 :: 		switch (frame) {
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
J	L_DrawFlake53
NOP	
;snowburst_main.c,556 :: 		case 0:
L_DrawFlake55:
;snowburst_main.c,557 :: 		TFT_Image(x, y, snowflake1_bmp, scale);
LUI	R2, #hi_addr(_snowflake1_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake1_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,558 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,560 :: 		case 1:
L_DrawFlake56:
;snowburst_main.c,561 :: 		TFT_Image(x, y, snowflake1_bmp, scale);
LUI	R2, #hi_addr(_snowflake1_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake1_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,562 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,564 :: 		case 2:
L_DrawFlake57:
;snowburst_main.c,565 :: 		TFT_Image(x, y, snowflake2_bmp, scale);
LUI	R2, #hi_addr(_snowflake2_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake2_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,566 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,568 :: 		case 3:
L_DrawFlake58:
;snowburst_main.c,569 :: 		TFT_Image(x, y, snowflake3_bmp, scale);
LUI	R2, #hi_addr(_snowflake3_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake3_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,570 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,572 :: 		case 4:
L_DrawFlake59:
;snowburst_main.c,573 :: 		TFT_Image(x, y, snowflake4_bmp, scale);
LUI	R2, #hi_addr(_snowflake4_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake4_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,574 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,576 :: 		case 5:
L_DrawFlake60:
;snowburst_main.c,577 :: 		TFT_Image(x, y, snowflake5_bmp, scale);
LUI	R2, #hi_addr(_snowflake5_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake5_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,578 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,580 :: 		case 6:
L_DrawFlake61:
;snowburst_main.c,581 :: 		TFT_Image(x, y, snowflake6_bmp, scale);
LUI	R2, #hi_addr(_snowflake6_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake6_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,582 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,584 :: 		case 7:
L_DrawFlake62:
;snowburst_main.c,585 :: 		TFT_Image(x, y, snowflake7_bmp, scale);
LUI	R2, #hi_addr(_snowflake7_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake7_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,586 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,588 :: 		case 8:
L_DrawFlake63:
;snowburst_main.c,589 :: 		TFT_Image(x, y, snowflake8_bmp, scale);
LUI	R2, #hi_addr(_snowflake8_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake8_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,590 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,592 :: 		case 9:
L_DrawFlake64:
;snowburst_main.c,593 :: 		TFT_Image(x, y, snowflake9_bmp, scale);
LUI	R2, #hi_addr(_snowflake9_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake9_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,594 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,596 :: 		case 10:
L_DrawFlake65:
;snowburst_main.c,597 :: 		TFT_Image(x, y, snowflake10_bmp, scale);
LUI	R2, #hi_addr(_snowflake10_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake10_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,598 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,600 :: 		case 11:
L_DrawFlake66:
;snowburst_main.c,601 :: 		TFT_Image(x, y, snowflake11_bmp, scale);
LUI	R2, #hi_addr(_snowflake11_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake11_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,602 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,604 :: 		case 12:
L_DrawFlake67:
;snowburst_main.c,605 :: 		TFT_Image(x, y, snowflake12_bmp, scale);
LUI	R2, #hi_addr(_snowflake12_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake12_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,606 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,608 :: 		case 13:
L_DrawFlake68:
;snowburst_main.c,609 :: 		TFT_Image(x, y, snowflake13_bmp, scale);
LUI	R2, #hi_addr(_snowflake13_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake13_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,610 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,612 :: 		case 14:
L_DrawFlake69:
;snowburst_main.c,613 :: 		TFT_Image(x, y, snowflake14_bmp, scale);
LUI	R2, #hi_addr(_snowflake14_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake14_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,614 :: 		break;
J	L_DrawFlake54
NOP	
;snowburst_main.c,616 :: 		default:
L_DrawFlake70:
;snowburst_main.c,617 :: 		TFT_Image(x, y, snowflake1_bmp, scale);
LUI	R2, #hi_addr(_snowflake1_bmp+0)
ORI	R2, R2, #lo_addr(_snowflake1_bmp+0)
SEH	R25, R26
SEH	R26, R27
MOVZ	R27, R2, R0
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,619 :: 		}
J	L_DrawFlake54
NOP	
L_DrawFlake53:
SEH	R2, R25
BNE	R2, R0, L__DrawFlake188
NOP	
J	L_DrawFlake55
NOP	
L__DrawFlake188:
SEH	R3, R25
ORI	R2, R0, 1
BNE	R3, R2, L__DrawFlake190
NOP	
J	L_DrawFlake56
NOP	
L__DrawFlake190:
SEH	R3, R25
ORI	R2, R0, 2
BNE	R3, R2, L__DrawFlake192
NOP	
J	L_DrawFlake57
NOP	
L__DrawFlake192:
SEH	R3, R25
ORI	R2, R0, 3
BNE	R3, R2, L__DrawFlake194
NOP	
J	L_DrawFlake58
NOP	
L__DrawFlake194:
SEH	R3, R25
ORI	R2, R0, 4
BNE	R3, R2, L__DrawFlake196
NOP	
J	L_DrawFlake59
NOP	
L__DrawFlake196:
SEH	R3, R25
ORI	R2, R0, 5
BNE	R3, R2, L__DrawFlake198
NOP	
J	L_DrawFlake60
NOP	
L__DrawFlake198:
SEH	R3, R25
ORI	R2, R0, 6
BNE	R3, R2, L__DrawFlake200
NOP	
J	L_DrawFlake61
NOP	
L__DrawFlake200:
SEH	R3, R25
ORI	R2, R0, 7
BNE	R3, R2, L__DrawFlake202
NOP	
J	L_DrawFlake62
NOP	
L__DrawFlake202:
SEH	R3, R25
ORI	R2, R0, 8
BNE	R3, R2, L__DrawFlake204
NOP	
J	L_DrawFlake63
NOP	
L__DrawFlake204:
SEH	R3, R25
ORI	R2, R0, 9
BNE	R3, R2, L__DrawFlake206
NOP	
J	L_DrawFlake64
NOP	
L__DrawFlake206:
SEH	R3, R25
ORI	R2, R0, 10
BNE	R3, R2, L__DrawFlake208
NOP	
J	L_DrawFlake65
NOP	
L__DrawFlake208:
SEH	R3, R25
ORI	R2, R0, 11
BNE	R3, R2, L__DrawFlake210
NOP	
J	L_DrawFlake66
NOP	
L__DrawFlake210:
SEH	R3, R25
ORI	R2, R0, 12
BNE	R3, R2, L__DrawFlake212
NOP	
J	L_DrawFlake67
NOP	
L__DrawFlake212:
SEH	R3, R25
ORI	R2, R0, 13
BNE	R3, R2, L__DrawFlake214
NOP	
J	L_DrawFlake68
NOP	
L__DrawFlake214:
SEH	R3, R25
ORI	R2, R0, 14
BNE	R3, R2, L__DrawFlake216
NOP	
J	L_DrawFlake69
NOP	
L__DrawFlake216:
J	L_DrawFlake70
NOP	
L_DrawFlake54:
;snowburst_main.c,622 :: 		}
L_end_DrawFlake:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _DrawFlake
_Init_Sprites:
;snowburst_main.c,628 :: 		void Init_Sprites(){
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;snowburst_main.c,629 :: 		int random_x = 0;
SW	R25, 4(SP)
;snowburst_main.c,630 :: 		int i = 0;
;snowburst_main.c,632 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1);i++){
; i start address is: 16 (R4)
MOVZ	R4, R0, R0
; i end address is: 16 (R4)
L_Init_Sprites71:
; i start address is: 16 (R4)
SEH	R2, R4
SLTI	R2, R2, 3
BNE	R2, R0, L__Init_Sprites218
NOP	
J	L_Init_Sprites72
NOP	
L__Init_Sprites218:
;snowburst_main.c,636 :: 		flakes[i].x = ((320 + 32)/ NUMBER_OF_FLAKES) * i + getRandom(32);
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
SW	R2, 12(SP)
ORI	R2, R0, 117
MUL	R2, R2, R4
SH	R2, 8(SP)
ORI	R25, R0, 32
JAL	_GetRandom+0
NOP	
LH	R3, 8(SP)
ADDU	R3, R3, R2
LW	R2, 12(SP)
SH	R3, 0(R2)
;snowburst_main.c,637 :: 		flakes[i].y = getRandom(5) * 48;
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 2
SW	R2, 8(SP)
ORI	R25, R0, 5
JAL	_GetRandom+0
NOP	
ORI	R3, R0, 48
MUL	R3, R2, R3
LW	R2, 8(SP)
SH	R3, 0(R2)
;snowburst_main.c,640 :: 		flakes[i].prev_x = flakes[i].x;
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 4
LH	R2, 0(R2)
SH	R2, 0(R3)
;snowburst_main.c,641 :: 		flakes[i].prev_y = flakes[i].y;
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 6
ADDIU	R2, R2, 2
LH	R2, 0(R2)
SH	R2, 0(R3)
;snowburst_main.c,645 :: 		flakes[i].frame = getRandom(13);
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 8
SW	R2, 8(SP)
ORI	R25, R0, 13
JAL	_GetRandom+0
NOP	
LW	R3, 8(SP)
SH	R2, 0(R3)
;snowburst_main.c,649 :: 		flakes[i].scale = getRandom(2);
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 10
SW	R2, 8(SP)
ORI	R25, R0, 2
JAL	_GetRandom+0
NOP	
LW	R3, 8(SP)
SH	R2, 0(R3)
;snowburst_main.c,652 :: 		if(flakes[i].scale == 1){
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 10
LH	R2, 0(R2)
SEH	R3, R2
ORI	R2, R0, 1
BEQ	R3, R2, L__Init_Sprites219
NOP	
J	L_Init_Sprites74
NOP	
L__Init_Sprites219:
;snowburst_main.c,653 :: 		flakes[i].width = 32;
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 12
ORI	R2, R0, 32
SH	R2, 0(R3)
;snowburst_main.c,654 :: 		flakes[i].height = 32;
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 14
ORI	R2, R0, 32
SH	R2, 0(R3)
;snowburst_main.c,655 :: 		}
J	L_Init_Sprites75
NOP	
L_Init_Sprites74:
;snowburst_main.c,657 :: 		flakes[i].width = 64;
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 12
ORI	R2, R0, 64
SH	R2, 0(R3)
;snowburst_main.c,658 :: 		flakes[i].height = 64;
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R3, R2, 14
ORI	R2, R0, 64
SH	R2, 0(R3)
;snowburst_main.c,659 :: 		}
L_Init_Sprites75:
;snowburst_main.c,663 :: 		flakes[i].speed = getRandom(4);
SEH	R3, R4
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R2, R2, R3
ADDIU	R2, R2, 16
SW	R2, 8(SP)
ORI	R25, R0, 4
JAL	_GetRandom+0
NOP	
LW	R3, 8(SP)
SH	R2, 0(R3)
;snowburst_main.c,632 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1);i++){
ADDIU	R2, R4, 1
SEH	R4, R2
;snowburst_main.c,666 :: 		}
; i end address is: 16 (R4)
J	L_Init_Sprites71
NOP	
L_Init_Sprites72:
;snowburst_main.c,668 :: 		}
L_end_Init_Sprites:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _Init_Sprites
_DrawSnowFall:
;snowburst_main.c,671 :: 		void DrawSnowFall(){
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;snowburst_main.c,673 :: 		long screen_snow_height = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
;snowburst_main.c,674 :: 		long prev_screen_snow_height = 0;
;snowburst_main.c,677 :: 		if(snow_height > (long)(240-64-STATUS_TEXT_HEIGHT)){
LW	R2, Offset(_snow_height+0)(GP)
SLTI	R2, R2, 152
BEQ	R2, R0, L__DrawSnowFall221
NOP	
J	L_DrawSnowFall76
NOP	
L__DrawSnowFall221:
;snowburst_main.c,678 :: 		game_over = 1;
ORI	R2, R0, 1
SH	R2, Offset(_game_over+0)(GP)
;snowburst_main.c,679 :: 		}
L_DrawSnowFall76:
;snowburst_main.c,681 :: 		if( (prev_muteSound != muteSound) || (snow_height != prev_snow_height) || (score != prev_score) || (frame_counter < 1) ){
LH	R3, Offset(_muteSound+0)(GP)
LH	R2, Offset(_prev_muteSound+0)(GP)
BEQ	R2, R3, L__DrawSnowFall222
NOP	
J	L__DrawSnowFall140
NOP	
L__DrawSnowFall222:
LW	R3, Offset(_prev_snow_height+0)(GP)
LW	R2, Offset(_snow_height+0)(GP)
BEQ	R2, R3, L__DrawSnowFall223
NOP	
J	L__DrawSnowFall139
NOP	
L__DrawSnowFall223:
LW	R3, Offset(_prev_score+0)(GP)
LW	R2, Offset(_score+0)(GP)
BEQ	R2, R3, L__DrawSnowFall224
NOP	
J	L__DrawSnowFall138
NOP	
L__DrawSnowFall224:
LW	R2, Offset(_frame_counter+0)(GP)
SLTIU	R2, R2, 1
BEQ	R2, R0, L__DrawSnowFall225
NOP	
J	L__DrawSnowFall137
NOP	
L__DrawSnowFall225:
J	L_DrawSnowFall79
NOP	
L__DrawSnowFall140:
L__DrawSnowFall139:
L__DrawSnowFall138:
L__DrawSnowFall137:
;snowburst_main.c,684 :: 		if(  ((score % (long)500) == 0) && (score>(long)50)){
LW	R3, Offset(_score+0)(GP)
ORI	R2, R0, 500
DIV	R3, R2
MFHI	R2
BEQ	R2, R0, L__DrawSnowFall226
NOP	
J	L__DrawSnowFall142
NOP	
L__DrawSnowFall226:
LW	R2, Offset(_score+0)(GP)
SLTI	R2, R2, 51
BEQ	R2, R0, L__DrawSnowFall227
NOP	
J	L__DrawSnowFall141
NOP	
L__DrawSnowFall227:
L__DrawSnowFall135:
;snowburst_main.c,689 :: 		if (snow_height>64){
LW	R2, Offset(_snow_height+0)(GP)
SLTI	R2, R2, 65
BEQ	R2, R0, L__DrawSnowFall228
NOP	
J	L_DrawSnowFall83
NOP	
L__DrawSnowFall228:
;snowburst_main.c,691 :: 		snow_height-=50;
LW	R2, Offset(_snow_height+0)(GP)
ADDIU	R2, R2, -50
SW	R2, Offset(_snow_height+0)(GP)
;snowburst_main.c,692 :: 		}
J	L_DrawSnowFall84
NOP	
L_DrawSnowFall83:
;snowburst_main.c,695 :: 		snow_height-=7;
LW	R2, Offset(_snow_height+0)(GP)
ADDIU	R2, R2, -7
SW	R2, Offset(_snow_height+0)(GP)
;snowburst_main.c,696 :: 		}
L_DrawSnowFall84:
;snowburst_main.c,701 :: 		UART1_Write_Line("You lowered the snowbank.");
LUI	R25, #hi_addr(?lstr3_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr3_snowburst_main+0)
JAL	_UART1_Write_Line+0
NOP	
;snowburst_main.c,704 :: 		if(snow_height<0){
LW	R2, Offset(_snow_height+0)(GP)
SLTI	R2, R2, 0
BNE	R2, R0, L__DrawSnowFall229
NOP	
J	L_DrawSnowFall85
NOP	
L__DrawSnowFall229:
;snowburst_main.c,705 :: 		snow_height=0;
SW	R0, Offset(_snow_height+0)(GP)
;snowburst_main.c,706 :: 		}
L_DrawSnowFall85:
;snowburst_main.c,708 :: 		screen_snow_height = (long)240-snow_height-STATUS_TEXT_HEIGHT;
LW	R3, Offset(_snow_height+0)(GP)
ORI	R2, R0, 240
SUBU	R2, R2, R3
ADDIU	R4, R2, -25
; screen_snow_height start address is: 20 (R5)
MOVZ	R5, R4, R0
;snowburst_main.c,709 :: 		prev_screen_snow_height = (long)240-prev_snow_height-STATUS_TEXT_HEIGHT;
LW	R3, Offset(_prev_snow_height+0)(GP)
ORI	R2, R0, 240
SUBU	R2, R2, R3
ADDIU	R2, R2, -25
; prev_screen_snow_height start address is: 12 (R3)
MOVZ	R3, R2, R0
;snowburst_main.c,714 :: 		if(screen_snow_height<0){
SLTI	R2, R4, 0
BNE	R2, R0, L__DrawSnowFall230
NOP	
J	L__DrawSnowFall143
NOP	
L__DrawSnowFall230:
; screen_snow_height end address is: 20 (R5)
;snowburst_main.c,715 :: 		screen_snow_height=0;
; screen_snow_height start address is: 16 (R4)
MOVZ	R4, R0, R0
; screen_snow_height end address is: 16 (R4)
;snowburst_main.c,716 :: 		}
J	L_DrawSnowFall86
NOP	
L__DrawSnowFall143:
;snowburst_main.c,714 :: 		if(screen_snow_height<0){
MOVZ	R4, R5, R0
;snowburst_main.c,716 :: 		}
L_DrawSnowFall86:
;snowburst_main.c,719 :: 		if(prev_screen_snow_height<0){
; screen_snow_height start address is: 16 (R4)
SLTI	R2, R3, 0
BNE	R2, R0, L__DrawSnowFall231
NOP	
J	L__DrawSnowFall144
NOP	
L__DrawSnowFall231:
; prev_screen_snow_height end address is: 12 (R3)
;snowburst_main.c,720 :: 		prev_screen_snow_height=0;
; prev_screen_snow_height start address is: 8 (R2)
MOVZ	R2, R0, R0
; prev_screen_snow_height end address is: 8 (R2)
MOVZ	R5, R2, R0
;snowburst_main.c,721 :: 		}
J	L_DrawSnowFall87
NOP	
L__DrawSnowFall144:
;snowburst_main.c,719 :: 		if(prev_screen_snow_height<0){
MOVZ	R5, R3, R0
;snowburst_main.c,721 :: 		}
L_DrawSnowFall87:
;snowburst_main.c,724 :: 		TFT_Set_Pen(sky_color, 1);
; prev_screen_snow_height start address is: 20 (R5)
ORI	R26, R0, 1
LH	R25, Offset(_sky_color+0)(GP)
JAL	_TFT_Set_Pen+0
NOP	
;snowburst_main.c,727 :: 		TFT_Set_Brush(1, sky_color, 0, TOP_TO_BOTTOM, sky_color, sky_color);
MOVZ	R28, R0, R0
MOVZ	R27, R0, R0
LH	R26, Offset(_sky_color+0)(GP)
ORI	R25, R0, 1
LH	R2, Offset(_sky_color+0)(GP)
ADDIU	SP, SP, -4
SH	R2, 2(SP)
LH	R2, Offset(_sky_color+0)(GP)
SH	R2, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
;snowburst_main.c,730 :: 		TFT_Rectangle(0, prev_screen_snow_height, SCREEN_WIDTH, screen_snow_height);
MOVZ	R28, R4, R0
; screen_snow_height end address is: 16 (R4)
ORI	R27, R0, 320
MOVZ	R26, R5, R0
; prev_screen_snow_height end address is: 20 (R5)
MOVZ	R25, R0, R0
JAL	_TFT_Rectangle+0
NOP	
;snowburst_main.c,684 :: 		if(  ((score % (long)500) == 0) && (score>(long)50)){
L__DrawSnowFall142:
L__DrawSnowFall141:
;snowburst_main.c,739 :: 		TFT_Set_Pen(0, 0);
MOVZ	R26, R0, R0
MOVZ	R25, R0, R0
JAL	_TFT_Set_Pen+0
NOP	
;snowburst_main.c,745 :: 		TFT_Set_Brush(1, 0, 1, TOP_TO_BOTTOM, CL_WHITE, CL_GRAY);
MOVZ	R28, R0, R0
ORI	R27, R0, 1
MOVZ	R26, R0, R0
ORI	R25, R0, 1
ORI	R2, R0, 33808
ADDIU	SP, SP, -4
SH	R2, 2(SP)
ORI	R2, R0, 65535
SH	R2, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
;snowburst_main.c,751 :: 		TFT_Rectangle(0, 240-snow_height-STATUS_TEXT_HEIGHT, 319, 240);
LW	R3, Offset(_snow_height+0)(GP)
ORI	R2, R0, 240
SUBU	R2, R2, R3
ADDIU	R2, R2, -25
ORI	R28, R0, 240
ORI	R27, R0, 319
SEH	R26, R2
MOVZ	R25, R0, R0
JAL	_TFT_Rectangle+0
NOP	
;snowburst_main.c,753 :: 		}
L_DrawSnowFall79:
;snowburst_main.c,754 :: 		}
L_end_DrawSnowFall:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _DrawSnowFall
_GetRandom:
;snowburst_main.c,758 :: 		int GetRandom(int range){
ADDIU	SP, SP, -4
SW	RA, 0(SP)
;snowburst_main.c,759 :: 		return (rand() % range) + 1;
JAL	_rand+0
NOP	
DIV	R2, R25
MFHI	R2
ADDIU	R2, R2, 1
;snowburst_main.c,760 :: 		}
L_end_GetRandom:
LW	RA, 0(SP)
ADDIU	SP, SP, 4
JR	RA
NOP	
; end of _GetRandom
_GetInput:
;snowburst_main.c,764 :: 		void GetInput(){
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;snowburst_main.c,766 :: 		if(TP_TFT_Press_Detect()){
SW	R25, 4(SP)
SW	R26, 8(SP)
JAL	_TP_TFT_Press_Detect+0
NOP	
BNE	R2, R0, L__GetInput235
NOP	
J	L_GetInput88
NOP	
L__GetInput235:
;snowburst_main.c,768 :: 		if (TP_TFT_Get_Coordinates(&X_Coord, &Y_Coord) == 0) {
LUI	R26, #hi_addr(_Y_Coord+0)
ORI	R26, R26, #lo_addr(_Y_Coord+0)
LUI	R25, #hi_addr(_X_Coord+0)
ORI	R25, R25, #lo_addr(_X_Coord+0)
JAL	_TP_TFT_Get_Coordinates+0
NOP	
ANDI	R2, R2, 255
BEQ	R2, R0, L__GetInput236
NOP	
J	L_GetInput89
NOP	
L__GetInput236:
;snowburst_main.c,771 :: 		if(Pen_Down == 0){
LBU	R2, Offset(_Pen_Down+0)(GP)
BEQ	R2, R0, L__GetInput237
NOP	
J	L_GetInput90
NOP	
L__GetInput237:
;snowburst_main.c,772 :: 		Starting_Pen_Down_X_Coord = X_Coord;
LHU	R2, Offset(_X_Coord+0)(GP)
SH	R2, Offset(_Starting_Pen_Down_X_Coord+0)(GP)
;snowburst_main.c,773 :: 		Starting_Pen_Down_Y_Coord = Y_Coord;
LHU	R2, Offset(_Y_Coord+0)(GP)
SH	R2, Offset(_Starting_Pen_Down_Y_Coord+0)(GP)
;snowburst_main.c,776 :: 		}
L_GetInput90:
;snowburst_main.c,778 :: 		X_Drag_Distance =  Starting_Pen_Down_X_Coord - X_Coord;
LHU	R3, Offset(_X_Coord+0)(GP)
LH	R2, Offset(_Starting_Pen_Down_X_Coord+0)(GP)
SUBU	R2, R2, R3
SH	R2, Offset(_X_Drag_Distance+0)(GP)
;snowburst_main.c,781 :: 		Pen_Down = 1;
ORI	R2, R0, 1
SB	R2, Offset(_Pen_Down+0)(GP)
;snowburst_main.c,783 :: 		}  //end of tap x / y location checking
L_GetInput89:
;snowburst_main.c,785 :: 		}
J	L_GetInput91
NOP	
L_GetInput88:
;snowburst_main.c,788 :: 		Pen_Down = 0;
SB	R0, Offset(_Pen_Down+0)(GP)
;snowburst_main.c,789 :: 		}
L_GetInput91:
;snowburst_main.c,792 :: 		if( (Pen_Down == 1 )&& (Y_coord > (SCREEN_HEIGHT-STATUS_TEXT_HEIGHT)) ) {
LBU	R3, Offset(_Pen_Down+0)(GP)
ORI	R2, R0, 1
BEQ	R3, R2, L__GetInput238
NOP	
J	L__GetInput130
NOP	
L__GetInput238:
LHU	R2, Offset(_Y_Coord+0)(GP)
SLTIU	R2, R2, 216
BEQ	R2, R0, L__GetInput239
NOP	
J	L__GetInput129
NOP	
L__GetInput239:
L__GetInput128:
;snowburst_main.c,794 :: 		ToggleMute();
JAL	_ToggleMute+0
NOP	
;snowburst_main.c,795 :: 		Delay_ms(500);
LUI	R24, 203
ORI	R24, R24, 29524
L_GetInput95:
ADDIU	R24, R24, -1
BNE	R24, R0, L_GetInput95
NOP	
NOP	
NOP	
;snowburst_main.c,792 :: 		if( (Pen_Down == 1 )&& (Y_coord > (SCREEN_HEIGHT-STATUS_TEXT_HEIGHT)) ) {
L__GetInput130:
L__GetInput129:
;snowburst_main.c,798 :: 		}
L_end_GetInput:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _GetInput
_ClearFlake:
;snowburst_main.c,802 :: 		void ClearFlake(){
ADDIU	SP, SP, -24
SW	RA, 0(SP)
;snowburst_main.c,803 :: 		int i = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
;snowburst_main.c,805 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1);i++){
; i start address is: 20 (R5)
MOVZ	R5, R0, R0
; i end address is: 20 (R5)
L_ClearFlake97:
; i start address is: 20 (R5)
SEH	R2, R5
SLTI	R2, R2, 3
BNE	R2, R0, L__ClearFlake241
NOP	
J	L_ClearFlake98
NOP	
L__ClearFlake241:
;snowburst_main.c,816 :: 		clear_up_down_flake.left = flakes[i].x;
SEH	R3, R5
ORI	R2, R0, 18
MULTU	R2, R3
MFLO	R3
LUI	R2, #hi_addr(_flakes+0)
ORI	R2, R2, #lo_addr(_flakes+0)
ADDU	R4, R2, R3
LH	R2, 0(R4)
SH	R2, Offset(_clear_up_down_flake+2)(GP)
;snowburst_main.c,817 :: 		clear_up_down_flake.top = flakes[i].prev_y;
ADDIU	R2, R4, 6
LH	R2, 0(R2)
SH	R2, Offset(_clear_up_down_flake+0)(GP)
;snowburst_main.c,818 :: 		clear_up_down_flake.right = flakes[i].x + flakes[i].width;
LH	R3, 0(R4)
ADDIU	R2, R4, 12
LH	R2, 0(R2)
ADDU	R2, R3, R2
SH	R2, Offset(_clear_up_down_flake+6)(GP)
;snowburst_main.c,820 :: 		clear_up_down_flake.bottom = flakes[i].y;
ADDIU	R2, R4, 2
LH	R2, 0(R2)
SH	R2, Offset(_clear_up_down_flake+4)(GP)
;snowburst_main.c,824 :: 		if (clear_up_down_flake.left < 0) {
LH	R2, Offset(_clear_up_down_flake+2)(GP)
SLTI	R2, R2, 0
BNE	R2, R0, L__ClearFlake242
NOP	
J	L_ClearFlake100
NOP	
L__ClearFlake242:
;snowburst_main.c,825 :: 		clear_up_down_flake.left = 0;
SH	R0, Offset(_clear_up_down_flake+2)(GP)
;snowburst_main.c,826 :: 		}
L_ClearFlake100:
;snowburst_main.c,827 :: 		if (clear_up_down_flake.top < 0) {
LH	R2, Offset(_clear_up_down_flake+0)(GP)
SLTI	R2, R2, 0
BNE	R2, R0, L__ClearFlake243
NOP	
J	L_ClearFlake101
NOP	
L__ClearFlake243:
;snowburst_main.c,828 :: 		clear_up_down_flake.top = 0;
SH	R0, Offset(_clear_up_down_flake+0)(GP)
;snowburst_main.c,829 :: 		}
L_ClearFlake101:
;snowburst_main.c,830 :: 		if (clear_up_down_flake.right < 0) {
LH	R2, Offset(_clear_up_down_flake+6)(GP)
SLTI	R2, R2, 0
BNE	R2, R0, L__ClearFlake244
NOP	
J	L_ClearFlake102
NOP	
L__ClearFlake244:
;snowburst_main.c,831 :: 		clear_up_down_flake.right = 0;
SH	R0, Offset(_clear_up_down_flake+6)(GP)
;snowburst_main.c,832 :: 		}
L_ClearFlake102:
;snowburst_main.c,833 :: 		if (clear_up_down_flake.bottom < 0) {
LH	R2, Offset(_clear_up_down_flake+4)(GP)
SLTI	R2, R2, 0
BNE	R2, R0, L__ClearFlake245
NOP	
J	L_ClearFlake103
NOP	
L__ClearFlake245:
;snowburst_main.c,834 :: 		clear_up_down_flake.bottom = 0;
SH	R0, Offset(_clear_up_down_flake+4)(GP)
;snowburst_main.c,835 :: 		}
L_ClearFlake103:
;snowburst_main.c,838 :: 		TFT_Set_Pen(sky_color, 1);
ORI	R26, R0, 1
LH	R25, Offset(_sky_color+0)(GP)
JAL	_TFT_Set_Pen+0
NOP	
;snowburst_main.c,841 :: 		TFT_Set_Brush(1, sky_color, 0, TOP_TO_BOTTOM, sky_color, sky_color);
MOVZ	R28, R0, R0
MOVZ	R27, R0, R0
LH	R26, Offset(_sky_color+0)(GP)
ORI	R25, R0, 1
LH	R2, Offset(_sky_color+0)(GP)
ADDIU	SP, SP, -4
SH	R2, 2(SP)
LH	R2, Offset(_sky_color+0)(GP)
SH	R2, 0(SP)
JAL	_TFT_Set_Brush+0
NOP	
ADDIU	SP, SP, 4
;snowburst_main.c,854 :: 		if( clear_up_down_flake.bottom > clear_up_down_flake.top){
LH	R3, Offset(_clear_up_down_flake+0)(GP)
LH	R2, Offset(_clear_up_down_flake+4)(GP)
SLT	R2, R3, R2
BNE	R2, R0, L__ClearFlake246
NOP	
J	L_ClearFlake104
NOP	
L__ClearFlake246:
;snowburst_main.c,856 :: 		TFT_Rectangle(clear_up_down_flake.left, clear_up_down_flake.top, clear_up_down_flake.right, clear_up_down_flake.bottom);
SH	R5, 20(SP)
LH	R28, Offset(_clear_up_down_flake+4)(GP)
LH	R27, Offset(_clear_up_down_flake+6)(GP)
LH	R26, Offset(_clear_up_down_flake+0)(GP)
LH	R25, Offset(_clear_up_down_flake+2)(GP)
JAL	_TFT_Rectangle+0
NOP	
LH	R5, 20(SP)
;snowburst_main.c,857 :: 		}
L_ClearFlake104:
;snowburst_main.c,805 :: 		for(i=0;i<=(NUMBER_OF_FLAKES-1);i++){
ADDIU	R2, R5, 1
SEH	R5, R2
;snowburst_main.c,858 :: 		}
; i end address is: 20 (R5)
J	L_ClearFlake97
NOP	
L_ClearFlake98:
;snowburst_main.c,859 :: 		}
L_end_ClearFlake:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 24
JR	RA
NOP	
; end of _ClearFlake
_ToggleMute:
;snowburst_main.c,865 :: 		void ToggleMute(){
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;snowburst_main.c,867 :: 		if(muteSound){
SW	R25, 4(SP)
LH	R2, Offset(_muteSound+0)(GP)
BNE	R2, R0, L__ToggleMute249
NOP	
J	L_ToggleMute105
NOP	
L__ToggleMute249:
;snowburst_main.c,868 :: 		muteSound = 0;
SH	R0, Offset(_muteSound+0)(GP)
;snowburst_main.c,869 :: 		UART1_Write_Line("Sound On");
LUI	R25, #hi_addr(?lstr4_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr4_snowburst_main+0)
JAL	_UART1_Write_Line+0
NOP	
;snowburst_main.c,870 :: 		}
J	L_ToggleMute106
NOP	
L_ToggleMute105:
;snowburst_main.c,871 :: 		else if(!muteSound){
LH	R2, Offset(_muteSound+0)(GP)
BEQ	R2, R0, L__ToggleMute250
NOP	
J	L_ToggleMute107
NOP	
L__ToggleMute250:
;snowburst_main.c,873 :: 		muteSound = 1;
ORI	R2, R0, 1
SH	R2, Offset(_muteSound+0)(GP)
;snowburst_main.c,874 :: 		UART1_Write_Line("Muting Sound");
LUI	R25, #hi_addr(?lstr5_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr5_snowburst_main+0)
JAL	_UART1_Write_Line+0
NOP	
;snowburst_main.c,875 :: 		}
L_ToggleMute107:
L_ToggleMute106:
;snowburst_main.c,877 :: 		}
L_end_ToggleMute:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _ToggleMute
_PreRollSong:
;snowburst_main.c,881 :: 		void PreRollSong(){
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;snowburst_main.c,882 :: 		int roll = 0;
;snowburst_main.c,883 :: 		int roll_max = 100;   //100
ORI	R30, R0, 100
SH	R30, 6(SP)
;snowburst_main.c,886 :: 		for(roll = 0; roll<=roll_max;roll++){
SH	R0, 4(SP)
L_PreRollSong108:
LH	R3, 6(SP)
LH	R2, 4(SP)
SLT	R2, R3, R2
BEQ	R2, R0, L__PreRollSong252
NOP	
J	L_PreRollSong109
NOP	
L__PreRollSong252:
;snowburst_main.c,887 :: 		Play_MP3_Chunk();
JAL	_Play_MP3_Chunk+0
NOP	
;snowburst_main.c,886 :: 		for(roll = 0; roll<=roll_max;roll++){
LH	R2, 4(SP)
ADDIU	R2, R2, 1
SH	R2, 4(SP)
;snowburst_main.c,888 :: 		}
J	L_PreRollSong108
NOP	
L_PreRollSong109:
;snowburst_main.c,889 :: 		}
L_end_PreRollSong:
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _PreRollSong
_GetNextSong:
;snowburst_main.c,892 :: 		void GetNextSong(){
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;snowburst_main.c,893 :: 		UART1_Write_Line("Switching to the next song.");
SW	R25, 4(SP)
LUI	R25, #hi_addr(?lstr6_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr6_snowburst_main+0)
JAL	_UART1_Write_Line+0
NOP	
;snowburst_main.c,895 :: 		Load_MP3_File("tff.mp3");
LUI	R25, #hi_addr(?lstr7_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr7_snowburst_main+0)
JAL	_Load_MP3_File+0
NOP	
;snowburst_main.c,898 :: 		if(current_pos < 5){
LW	R2, Offset(_current_pos+0)(GP)
SLTI	R2, R2, 5
BNE	R2, R0, L__GetNextSong254
NOP	
J	L_GetNextSong111
NOP	
L__GetNextSong254:
;snowburst_main.c,899 :: 		PreRollSong();
JAL	_PreRollSong+0
NOP	
;snowburst_main.c,900 :: 		}
L_GetNextSong111:
;snowburst_main.c,902 :: 		}
L_end_GetNextSong:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _GetNextSong
_RenderScore:
;snowburst_main.c,907 :: 		void RenderScore(){
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;snowburst_main.c,910 :: 		if(muteSound){
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
LH	R2, Offset(_muteSound+0)(GP)
BNE	R2, R0, L__RenderScore257
NOP	
J	L_RenderScore112
NOP	
L__RenderScore257:
;snowburst_main.c,913 :: 		TFT_Write_Text("Tap bar to enable music.", 10, 240-STATUS_TEXT_HEIGHT+3);
ORI	R27, R0, 218
ORI	R26, R0, 10
LUI	R25, #hi_addr(?lstr8_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr8_snowburst_main+0)
JAL	_TFT_Write_Text+0
NOP	
;snowburst_main.c,914 :: 		}
J	L_RenderScore113
NOP	
L_RenderScore112:
;snowburst_main.c,915 :: 		else if(!muteSound){
LH	R2, Offset(_muteSound+0)(GP)
BEQ	R2, R0, L__RenderScore258
NOP	
J	L_RenderScore114
NOP	
L__RenderScore258:
;snowburst_main.c,918 :: 		TFT_Write_Text("Tap bar to mute music.", 10, 240-STATUS_TEXT_HEIGHT+3);
ORI	R27, R0, 218
ORI	R26, R0, 10
LUI	R25, #hi_addr(?lstr9_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr9_snowburst_main+0)
JAL	_TFT_Write_Text+0
NOP	
;snowburst_main.c,919 :: 		}
L_RenderScore114:
L_RenderScore113:
;snowburst_main.c,926 :: 		LongToStr(score, score_text);
LUI	R26, #hi_addr(_score_text+0)
ORI	R26, R26, #lo_addr(_score_text+0)
LW	R25, Offset(_score+0)(GP)
JAL	_LongToStr+0
NOP	
;snowburst_main.c,929 :: 		TFT_Set_Font(TFT_defaultFont, sky_color, FO_HORIZONTAL);
MOVZ	R27, R0, R0
LH	R26, Offset(_sky_color+0)(GP)
LUI	R25, #hi_addr(_TFT_defaultFont+0)
ORI	R25, R25, #lo_addr(_TFT_defaultFont+0)
JAL	_TFT_Set_Font+0
NOP	
;snowburst_main.c,932 :: 		strcpy(score_display_text, "Score: ");
LUI	R26, #hi_addr(?lstr10_snowburst_main+0)
ORI	R26, R26, #lo_addr(?lstr10_snowburst_main+0)
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_strcpy+0
NOP	
;snowburst_main.c,933 :: 		strcat(score_display_text, score_text);
LUI	R26, #hi_addr(_score_text+0)
ORI	R26, R26, #lo_addr(_score_text+0)
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_strcat+0
NOP	
;snowburst_main.c,937 :: 		TFT_Write_Text(score_display_text, 200, 240-STATUS_TEXT_HEIGHT+3);
ORI	R27, R0, 218
ORI	R26, R0, 200
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_TFT_Write_Text+0
NOP	
;snowburst_main.c,938 :: 		}
L_end_RenderScore:
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _RenderScore
_ShowTitles:
;snowburst_main.c,941 :: 		void ShowTitles(){
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;snowburst_main.c,942 :: 		int loop = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
;snowburst_main.c,945 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVZ	R27, R0, R0
ORI	R26, R0, 65535
LUI	R25, #hi_addr(_TFT_defaultFont+0)
ORI	R25, R25, #lo_addr(_TFT_defaultFont+0)
JAL	_TFT_Set_Font+0
NOP	
;snowburst_main.c,948 :: 		TFT_Fill_Screen(sky_color);
LH	R25, Offset(_sky_color+0)(GP)
JAL	_TFT_Fill_Screen+0
NOP	
;snowburst_main.c,951 :: 		TFT_Image(32, 50, title_bmp, 1);
LUI	R2, #hi_addr(_title_bmp+0)
ORI	R2, R2, #lo_addr(_title_bmp+0)
ORI	R28, R0, 1
MOVZ	R27, R2, R0
ORI	R26, R0, 50
ORI	R25, R0, 32
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,953 :: 		TFT_Write_Text("Tap    to    melt    the    snowflakes.", 60, 140);
ORI	R27, R0, 140
ORI	R26, R0, 60
LUI	R25, #hi_addr(?lstr11_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr11_snowburst_main+0)
JAL	_TFT_Write_Text+0
NOP	
;snowburst_main.c,955 :: 		TFT_Write_Text("Created   By   Andrew   Hazelden   (c) 2011-2012", 20, 220);
ORI	R27, R0, 220
ORI	R26, R0, 20
LUI	R25, #hi_addr(?lstr12_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr12_snowburst_main+0)
JAL	_TFT_Write_Text+0
NOP	
;snowburst_main.c,957 :: 		GetNextSong();
JAL	_GetNextSong+0
NOP	
;snowburst_main.c,966 :: 		if(muteSound){
LH	R2, Offset(_muteSound+0)(GP)
BNE	R2, R0, L__ShowTitles261
NOP	
J	L_ShowTitles115
NOP	
L__ShowTitles261:
;snowburst_main.c,967 :: 		Delay_ms(4000);
LUI	R24, 1627
ORI	R24, R24, 39594
L_ShowTitles116:
ADDIU	R24, R24, -1
BNE	R24, R0, L_ShowTitles116
NOP	
;snowburst_main.c,968 :: 		}
L_ShowTitles115:
;snowburst_main.c,971 :: 		TFT_Fill_Screen(sky_color);
LH	R25, Offset(_sky_color+0)(GP)
JAL	_TFT_Fill_Screen+0
NOP	
;snowburst_main.c,973 :: 		}
L_end_ShowTitles:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _ShowTitles
_ShowGameOver:
;snowburst_main.c,975 :: 		void ShowGameOver(){
ADDIU	SP, SP, -24
SW	RA, 0(SP)
;snowburst_main.c,976 :: 		int loop = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
;snowburst_main.c,978 :: 		UART1_Write_Line("Game Over");
LUI	R25, #hi_addr(?lstr13_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr13_snowburst_main+0)
JAL	_UART1_Write_Line+0
NOP	
;snowburst_main.c,981 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVZ	R27, R0, R0
ORI	R26, R0, 65535
LUI	R25, #hi_addr(_TFT_defaultFont+0)
ORI	R25, R25, #lo_addr(_TFT_defaultFont+0)
JAL	_TFT_Set_Font+0
NOP	
;snowburst_main.c,984 :: 		TFT_Fill_Screen(sky_color);
LH	R25, Offset(_sky_color+0)(GP)
JAL	_TFT_Fill_Screen+0
NOP	
;snowburst_main.c,987 :: 		TFT_Image(32, 50, GameOver_bmp, 1);
LUI	R2, #hi_addr(_gameover_bmp+0)
ORI	R2, R2, #lo_addr(_gameover_bmp+0)
ORI	R28, R0, 1
MOVZ	R27, R2, R0
ORI	R26, R0, 50
ORI	R25, R0, 32
JAL	_TFT_Image+0
NOP	
;snowburst_main.c,991 :: 		if(score > high_score){
LW	R3, Offset(_high_score+0)(GP)
LW	R2, Offset(_score+0)(GP)
SLT	R2, R3, R2
BNE	R2, R0, L__ShowGameOver263
NOP	
J	L_ShowGameOver118
NOP	
L__ShowGameOver263:
;snowburst_main.c,993 :: 		high_score = score;
LW	R2, Offset(_score+0)(GP)
SW	R2, Offset(_high_score+0)(GP)
;snowburst_main.c,994 :: 		TFT_Write_Text("You  set  a  High  Score!", 95, 140);
ORI	R27, R0, 140
ORI	R26, R0, 95
LUI	R25, #hi_addr(?lstr14_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr14_snowburst_main+0)
JAL	_TFT_Write_Text+0
NOP	
;snowburst_main.c,995 :: 		}
J	L_ShowGameOver119
NOP	
L_ShowGameOver118:
;snowburst_main.c,1000 :: 		LongWordToStr(high_score, score_text);
LUI	R26, #hi_addr(_score_text+0)
ORI	R26, R26, #lo_addr(_score_text+0)
LW	R25, Offset(_high_score+0)(GP)
JAL	_LongWordToStr+0
NOP	
;snowburst_main.c,1001 :: 		strcpy(score_display_text, "High  Score: ");
LUI	R26, #hi_addr(?lstr15_snowburst_main+0)
ORI	R26, R26, #lo_addr(?lstr15_snowburst_main+0)
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_strcpy+0
NOP	
;snowburst_main.c,1002 :: 		strcat(score_display_text, score_text);
LUI	R26, #hi_addr(_score_text+0)
ORI	R26, R26, #lo_addr(_score_text+0)
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_strcat+0
NOP	
;snowburst_main.c,1005 :: 		TFT_Write_Text(score_display_text, 110, 140);
ORI	R27, R0, 140
ORI	R26, R0, 110
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_TFT_Write_Text+0
NOP	
;snowburst_main.c,1006 :: 		}
L_ShowGameOver119:
;snowburst_main.c,1009 :: 		LongWordToStr(score, score_text);
LUI	R26, #hi_addr(_score_text+0)
ORI	R26, R26, #lo_addr(_score_text+0)
LW	R25, Offset(_score+0)(GP)
JAL	_LongWordToStr+0
NOP	
;snowburst_main.c,1010 :: 		strcpy(score_display_text, "Your  Score: ");
LUI	R26, #hi_addr(?lstr16_snowburst_main+0)
ORI	R26, R26, #lo_addr(?lstr16_snowburst_main+0)
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_strcpy+0
NOP	
;snowburst_main.c,1011 :: 		strcat(score_display_text, score_text);
LUI	R26, #hi_addr(_score_text+0)
ORI	R26, R26, #lo_addr(_score_text+0)
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_strcat+0
NOP	
;snowburst_main.c,1014 :: 		TFT_Write_Text(score_display_text, 110, 170);
ORI	R27, R0, 170
ORI	R26, R0, 110
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_TFT_Write_Text+0
NOP	
;snowburst_main.c,1017 :: 		UART1_Write_Line(score_display_text);
LUI	R25, #hi_addr(_score_display_text+0)
ORI	R25, R25, #lo_addr(_score_display_text+0)
JAL	_UART1_Write_Line+0
NOP	
;snowburst_main.c,1019 :: 		TFT_Write_Text("Tip:   Melt   the   small   snowflakes   first!", 45, 215);
ORI	R27, R0, 215
ORI	R26, R0, 45
LUI	R25, #hi_addr(?lstr17_snowburst_main+0)
ORI	R25, R25, #lo_addr(?lstr17_snowburst_main+0)
JAL	_TFT_Write_Text+0
NOP	
;snowburst_main.c,1022 :: 		for(loop = 0; loop<=60;loop++){
; loop start address is: 12 (R3)
MOVZ	R3, R0, R0
; loop end address is: 12 (R3)
L_ShowGameOver120:
; loop start address is: 12 (R3)
SEH	R2, R3
SLTI	R2, R2, 61
BNE	R2, R0, L__ShowGameOver264
NOP	
J	L_ShowGameOver121
NOP	
L__ShowGameOver264:
;snowburst_main.c,1023 :: 		Play_MP3_Chunk();
SH	R3, 20(SP)
JAL	_Play_MP3_Chunk+0
NOP	
LH	R3, 20(SP)
;snowburst_main.c,1024 :: 		Delay_ms(50);
LUI	R24, 20
ORI	R24, R24, 22612
L_ShowGameOver123:
ADDIU	R24, R24, -1
BNE	R24, R0, L_ShowGameOver123
NOP	
NOP	
NOP	
;snowburst_main.c,1026 :: 		if(muteSound){
LH	R2, Offset(_muteSound+0)(GP)
BNE	R2, R0, L__ShowGameOver266
NOP	
J	L_ShowGameOver125
NOP	
L__ShowGameOver266:
;snowburst_main.c,1027 :: 		Delay_ms(20);
LUI	R24, 8
ORI	R24, R24, 9044
L_ShowGameOver126:
ADDIU	R24, R24, -1
BNE	R24, R0, L_ShowGameOver126
NOP	
NOP	
NOP	
;snowburst_main.c,1028 :: 		}
L_ShowGameOver125:
;snowburst_main.c,1022 :: 		for(loop = 0; loop<=60;loop++){
ADDIU	R2, R3, 1
SEH	R3, R2
;snowburst_main.c,1030 :: 		}
; loop end address is: 12 (R3)
J	L_ShowGameOver120
NOP	
L_ShowGameOver121:
;snowburst_main.c,1035 :: 		TFT_Fill_Screen(sky_color);
LH	R25, Offset(_sky_color+0)(GP)
JAL	_TFT_Fill_Screen+0
NOP	
;snowburst_main.c,1037 :: 		}
L_end_ShowGameOver:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 24
JR	RA
NOP	
; end of _ShowGameOver
