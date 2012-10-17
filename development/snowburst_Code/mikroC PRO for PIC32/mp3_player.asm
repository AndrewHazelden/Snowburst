_MP3_SCI_Write:
;mp3_player.c,114 :: 		void MP3_SCI_Write(char address, unsigned int data_in) {
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mp3_player.c,115 :: 		BSYNC = 1;
SW	R25, 4(SP)
SH	R26, 10(SP)
LBU	R2, Offset(LATB8_bit+1)(GP)
ORI	R2, R2, 1
SB	R2, Offset(LATB8_bit+1)(GP)
;mp3_player.c,117 :: 		MP3_CS = 0;                    // select MP3 SCI
LBU	R2, Offset(LATG15_bit+1)(GP)
INS	R2, R0, 7, 1
SB	R2, Offset(LATG15_bit+1)(GP)
;mp3_player.c,118 :: 		SPI_Write(WRITE_CODE);
SB	R25, 8(SP)
ORI	R25, R0, 2
JAL	_SPI_Write+0
NOP	
LBU	R25, 8(SP)
;mp3_player.c,119 :: 		SPI_Write(address);
ANDI	R25, R25, 255
JAL	_SPI_Write+0
NOP	
;mp3_player.c,120 :: 		SPI_Write(Hi(data_in));       // high byte
ADDIU	R2, SP, 10
ADDIU	R2, R2, 1
LBU	R25, 0(R2)
JAL	_SPI_Write+0
NOP	
;mp3_player.c,121 :: 		SPI_Write(Lo(data_in));       // low byte
ADDIU	R2, SP, 10
LBU	R25, 0(R2)
JAL	_SPI_Write+0
NOP	
;mp3_player.c,122 :: 		MP3_CS = 1;                    // deselect MP3 SCI
LBU	R2, Offset(LATG15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATG15_bit+1)(GP)
;mp3_player.c,123 :: 		while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
L_MP3_SCI_Write0:
LBU	R2, Offset(RD8_bit+1)(GP)
EXT	R2, R2, 0, 1
BEQ	R2, R0, L__MP3_SCI_Write61
NOP	
J	L_MP3_SCI_Write1
NOP	
L__MP3_SCI_Write61:
J	L_MP3_SCI_Write0
NOP	
L_MP3_SCI_Write1:
;mp3_player.c,124 :: 		}
L_end_MP3_SCI_Write:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _MP3_SCI_Write
_MP3_SCI_Read:
;mp3_player.c,133 :: 		void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer) {
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;mp3_player.c,136 :: 		MP3_CS = 0;                    // select MP3 SCI
LBU	R2, Offset(LATG15_bit+1)(GP)
INS	R2, R0, 7, 1
SB	R2, Offset(LATG15_bit+1)(GP)
;mp3_player.c,137 :: 		SPI_Write(READ_CODE);
SW	R27, 4(SP)
SB	R26, 8(SP)
SB	R25, 9(SP)
ORI	R25, R0, 3
JAL	_SPI_Write+0
NOP	
LBU	R25, 9(SP)
;mp3_player.c,138 :: 		SPI_Write(start_address);
ANDI	R25, R25, 255
JAL	_SPI_Write+0
NOP	
LBU	R26, 8(SP)
LW	R27, 4(SP)
;mp3_player.c,140 :: 		while (words_count--) {        // read words_count words byte per byte
L_MP3_SCI_Read2:
ANDI	R3, R26, 255
ADDIU	R2, R26, -1
ANDI	R26, R2, 255
BNE	R3, R0, L__MP3_SCI_Read64
NOP	
J	L_MP3_SCI_Read3
NOP	
L__MP3_SCI_Read64:
;mp3_player.c,141 :: 		temp = SPI_Read(0);
SW	R27, 4(SP)
SB	R26, 8(SP)
SB	R25, 9(SP)
MOVZ	R25, R0, R0
JAL	_SPI_Read+0
NOP	
LBU	R25, 9(SP)
LBU	R26, 8(SP)
LW	R27, 4(SP)
;mp3_player.c,142 :: 		temp <<= 8;
ANDI	R2, R2, 65535
SLL	R2, R2, 8
; temp start address is: 12 (R3)
ANDI	R3, R2, 65535
;mp3_player.c,143 :: 		temp += SPI_Read(0);
SH	R3, 4(SP)
SW	R27, 8(SP)
SB	R26, 12(SP)
SB	R25, 13(SP)
MOVZ	R25, R0, R0
JAL	_SPI_Read+0
NOP	
LBU	R25, 13(SP)
LBU	R26, 12(SP)
LW	R27, 8(SP)
LHU	R3, 4(SP)
ADDU	R2, R3, R2
; temp end address is: 12 (R3)
;mp3_player.c,144 :: 		*(data_buffer++) = temp;
SH	R2, 0(R27)
ADDIU	R2, R27, 2
MOVZ	R27, R2, R0
;mp3_player.c,145 :: 		}
J	L_MP3_SCI_Read2
NOP	
L_MP3_SCI_Read3:
;mp3_player.c,146 :: 		MP3_CS = 1;                    // deselect MP3 SCI
LBU	R2, Offset(LATG15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATG15_bit+1)(GP)
;mp3_player.c,147 :: 		while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
L_MP3_SCI_Read4:
LBU	R2, Offset(RD8_bit+1)(GP)
EXT	R2, R2, 0, 1
BEQ	R2, R0, L__MP3_SCI_Read65
NOP	
J	L_MP3_SCI_Read5
NOP	
L__MP3_SCI_Read65:
J	L_MP3_SCI_Read4
NOP	
L_MP3_SCI_Read5:
;mp3_player.c,148 :: 		}
L_end_MP3_SCI_Read:
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _MP3_SCI_Read
_MP3_SDI_Write:
;mp3_player.c,157 :: 		void MP3_SDI_Write(char data_) {
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;mp3_player.c,159 :: 		MP3_CS = 1;
LBU	R2, Offset(LATG15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATG15_bit+1)(GP)
;mp3_player.c,160 :: 		BSYNC = 0;
LBU	R2, Offset(LATB8_bit+1)(GP)
INS	R2, R0, 0, 1
SB	R2, Offset(LATB8_bit+1)(GP)
;mp3_player.c,162 :: 		while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
L_MP3_SDI_Write6:
LBU	R2, Offset(RD8_bit+1)(GP)
EXT	R2, R2, 0, 1
BEQ	R2, R0, L__MP3_SDI_Write67
NOP	
J	L_MP3_SDI_Write7
NOP	
L__MP3_SDI_Write67:
J	L_MP3_SDI_Write6
NOP	
L_MP3_SDI_Write7:
;mp3_player.c,164 :: 		SPI_Write(data_);
SB	R25, 4(SP)
ANDI	R25, R25, 255
JAL	_SPI_Write+0
NOP	
LBU	R25, 4(SP)
;mp3_player.c,165 :: 		BSYNC = 1;
LBU	R2, Offset(LATB8_bit+1)(GP)
ORI	R2, R2, 1
SB	R2, Offset(LATB8_bit+1)(GP)
;mp3_player.c,166 :: 		}
L_end_MP3_SDI_Write:
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _MP3_SDI_Write
_MP3_SDI_Write_32:
;mp3_player.c,175 :: 		void MP3_SDI_Write_32(char *data_) {
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mp3_player.c,178 :: 		MP3_CS = 1;
LBU	R2, Offset(LATG15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATG15_bit+1)(GP)
;mp3_player.c,179 :: 		BSYNC = 0;
LBU	R2, Offset(LATB8_bit+1)(GP)
INS	R2, R0, 0, 1
SB	R2, Offset(LATB8_bit+1)(GP)
;mp3_player.c,181 :: 		while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
L_MP3_SDI_Write_328:
LBU	R2, Offset(RD8_bit+1)(GP)
EXT	R2, R2, 0, 1
BEQ	R2, R0, L__MP3_SDI_Write_3269
NOP	
J	L_MP3_SDI_Write_329
NOP	
L__MP3_SDI_Write_3269:
J	L_MP3_SDI_Write_328
NOP	
L_MP3_SDI_Write_329:
;mp3_player.c,183 :: 		for (i=0; i<32; i++)
; i start address is: 12 (R3)
MOVZ	R3, R0, R0
; i end address is: 12 (R3)
L_MP3_SDI_Write_3210:
; i start address is: 12 (R3)
ANDI	R2, R3, 255
SLTIU	R2, R2, 32
BNE	R2, R0, L__MP3_SDI_Write_3270
NOP	
J	L_MP3_SDI_Write_3211
NOP	
L__MP3_SDI_Write_3270:
;mp3_player.c,184 :: 		SPI_Write(data_[i]);
ANDI	R2, R3, 255
ADDU	R2, R25, R2
SB	R3, 4(SP)
SW	R25, 8(SP)
LBU	R25, 0(R2)
JAL	_SPI_Write+0
NOP	
LW	R25, 8(SP)
LBU	R3, 4(SP)
;mp3_player.c,183 :: 		for (i=0; i<32; i++)
ADDIU	R2, R3, 1
ANDI	R3, R2, 255
;mp3_player.c,184 :: 		SPI_Write(data_[i]);
; i end address is: 12 (R3)
J	L_MP3_SDI_Write_3210
NOP	
L_MP3_SDI_Write_3211:
;mp3_player.c,185 :: 		BSYNC = 1;
LBU	R2, Offset(LATB8_bit+1)(GP)
ORI	R2, R2, 1
SB	R2, Offset(LATB8_bit+1)(GP)
;mp3_player.c,186 :: 		}
L_end_MP3_SDI_Write_32:
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _MP3_SDI_Write_32
_MP3_Set_Volume:
;mp3_player.c,195 :: 		void MP3_Set_Volume(char left, char right) {
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mp3_player.c,198 :: 		volume = (left<<8) + right;             // calculate value
SW	R25, 4(SP)
SW	R26, 8(SP)
ANDI	R2, R25, 255
SLL	R3, R2, 8
ANDI	R2, R26, 255
ADDU	R2, R3, R2
;mp3_player.c,199 :: 		MP3_SCI_Write(SCI_VOL_ADDR, volume);    // Write value to VOL register
ANDI	R26, R2, 65535
ORI	R25, R0, 11
JAL	_MP3_SCI_Write+0
NOP	
;mp3_player.c,200 :: 		}
L_end_MP3_Set_Volume:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _MP3_Set_Volume
_MP3_Init:
;mp3_player.c,210 :: 		void MP3_Init(void)
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mp3_player.c,212 :: 		BSYNC = 1;
SW	R25, 4(SP)
SW	R26, 8(SP)
LBU	R2, Offset(LATB8_bit+1)(GP)
ORI	R2, R2, 1
SB	R2, Offset(LATB8_bit+1)(GP)
;mp3_player.c,213 :: 		MP3_CS = 1;
LBU	R2, Offset(LATG15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATG15_bit+1)(GP)
;mp3_player.c,216 :: 		UART1_Write_Line("Initializing VS1011E decoder interface");
LUI	R25, #hi_addr(?lstr1_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr1_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,219 :: 		MP3_RST = 0;
LBU	R2, Offset(LATD9_bit+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(LATD9_bit+1)(GP)
;mp3_player.c,220 :: 		Delay_ms(10);
LUI	R24, 4
ORI	R24, R24, 4522
L_MP3_Init13:
ADDIU	R24, R24, -1
BNE	R24, R0, L_MP3_Init13
NOP	
;mp3_player.c,221 :: 		MP3_RST = 1;
LBU	R2, Offset(LATD9_bit+1)(GP)
ORI	R2, R2, 2
SB	R2, Offset(LATD9_bit+1)(GP)
;mp3_player.c,223 :: 		while (DREQ == 0);
L_MP3_Init15:
LBU	R2, Offset(RD8_bit+1)(GP)
EXT	R2, R2, 0, 1
BEQ	R2, R0, L__MP3_Init73
NOP	
J	L_MP3_Init16
NOP	
L__MP3_Init73:
J	L_MP3_Init15
NOP	
L_MP3_Init16:
;mp3_player.c,225 :: 		MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
ORI	R26, R0, 2048
MOVZ	R25, R0, R0
JAL	_MP3_SCI_Write+0
NOP	
;mp3_player.c,226 :: 		MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
ORI	R26, R0, 31232
ORI	R25, R0, 2
JAL	_MP3_SCI_Write+0
NOP	
;mp3_player.c,227 :: 		MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);   // default 12 288 000 Hz
ORI	R26, R0, 8192
ORI	R25, R0, 3
JAL	_MP3_SCI_Write+0
NOP	
;mp3_player.c,230 :: 		volume_left  = 0; //0x3F;
SB	R0, Offset(_volume_left+0)(GP)
;mp3_player.c,231 :: 		volume_right = volume_left; //0x3F;
SB	R0, Offset(_volume_right+0)(GP)
;mp3_player.c,232 :: 		MP3_Set_Volume(volume_left, volume_right);
MOVZ	R26, R0, R0
MOVZ	R25, R0, R0
JAL	_MP3_Set_Volume+0
NOP	
;mp3_player.c,236 :: 		}
L_end_MP3_Init:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _MP3_Init
_MP3_Start:
;mp3_player.c,247 :: 		void MP3_Start(void)
ADDIU	SP, SP, -20
SW	RA, 0(SP)
;mp3_player.c,250 :: 		CS_Serial_Flash_Direction_bit = 0;
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R27, 12(SP)
SW	R28, 16(SP)
LBU	R2, Offset(TRISC2_bit+0)(GP)
INS	R2, R0, 2, 1
SB	R2, Offset(TRISC2_bit+0)(GP)
;mp3_player.c,251 :: 		CS_Serial_Flash_bit = 1;             // Disable Serial Flash module
LBU	R2, Offset(LATC2_bit+0)(GP)
ORI	R2, R2, 4
SB	R2, Offset(LATC2_bit+0)(GP)
;mp3_player.c,253 :: 		Mmc_Chip_Select_Direction = 0;
LBU	R2, Offset(TRISG9_bit+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(TRISG9_bit+1)(GP)
;mp3_player.c,255 :: 		MP3_CS_Direction  = 0;               // Configure MP3_CS as output
LBU	R2, Offset(TRISG15_bit+1)(GP)
INS	R2, R0, 7, 1
SB	R2, Offset(TRISG15_bit+1)(GP)
;mp3_player.c,256 :: 		MP3_CS            = 1;               // Deselect MP3_CS
LBU	R2, Offset(LATG15_bit+1)(GP)
ORI	R2, R2, 128
SB	R2, Offset(LATG15_bit+1)(GP)
;mp3_player.c,257 :: 		MP3_RST_Direction = 0;               // Configure MP3_RST as output
LBU	R2, Offset(TRISD9_bit+1)(GP)
INS	R2, R0, 1, 1
SB	R2, Offset(TRISD9_bit+1)(GP)
;mp3_player.c,258 :: 		MP3_RST           = 1;               // Set MP3_RST pin
LBU	R2, Offset(LATD9_bit+1)(GP)
ORI	R2, R2, 2
SB	R2, Offset(LATD9_bit+1)(GP)
;mp3_player.c,260 :: 		DREQ_Direction    = 1;               // Configure DREQ as input
LBU	R2, Offset(TRISD8_bit+1)(GP)
ORI	R2, R2, 1
SB	R2, Offset(TRISD8_bit+1)(GP)
;mp3_player.c,261 :: 		BSYNC_Direction   = 0;               // Configure BSYNC as output
LBU	R2, Offset(TRISB8_bit+1)(GP)
INS	R2, R0, 0, 1
SB	R2, Offset(TRISB8_bit+1)(GP)
;mp3_player.c,262 :: 		BSYNC             = 0;               // Clear BSYNC
LBU	R2, Offset(LATB8_bit+1)(GP)
INS	R2, R0, 0, 1
SB	R2, Offset(LATB8_bit+1)(GP)
;mp3_player.c,263 :: 		BSYNC             = 1;               // Clear BSYNC
LBU	R2, Offset(LATB8_bit+1)(GP)
ORI	R2, R2, 1
SB	R2, Offset(LATB8_bit+1)(GP)
;mp3_player.c,273 :: 		UART1_Write_Line("Initializing SPI");
LUI	R25, #hi_addr(?lstr2_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr2_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,276 :: 		WS_SPI_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, 26, _SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_IDLE_2_ACTIVE);
MOVZ	R28, R0, R0
ORI	R27, R0, 26
MOVZ	R26, R0, R0
ORI	R25, R0, 32
ORI	R2, R0, 256
ADDIU	SP, SP, -8
SH	R2, 4(SP)
SH	R0, 2(SP)
SH	R0, 0(SP)
JAL	_WS_SPI_Init_Advanced+0
NOP	
ADDIU	SP, SP, 8
;mp3_player.c,280 :: 		MP3_Init();
JAL	_MP3_Init+0
NOP	
;mp3_player.c,281 :: 		Delay_ms(1000);
LUI	R24, 406
ORI	R24, R24, 59050
L_MP3_Start17:
ADDIU	R24, R24, -1
BNE	R24, R0, L_MP3_Start17
NOP	
;mp3_player.c,283 :: 		}
L_end_MP3_Start:
LW	R28, 16(SP)
LW	R27, 12(SP)
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 20
JR	RA
NOP	
; end of _MP3_Start
_Load_MP3_File:
;mp3_player.c,285 :: 		void Load_MP3_File(char *filename){
ADDIU	SP, SP, -16
SW	RA, 0(SP)
;mp3_player.c,287 :: 		UART1_Write_Line("Initializing MMC_FAT");
SW	R25, 4(SP)
SW	R26, 8(SP)
SW	R25, 12(SP)
LUI	R25, #hi_addr(?lstr3_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr3_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,290 :: 		current_pos = 0;
SW	R0, Offset(_current_pos+0)(GP)
;mp3_player.c,292 :: 		if (Mmc_Fat_Init() == 0) {
JAL	_Mmc_Fat_Init+0
NOP	
LW	R25, 12(SP)
ANDI	R2, R2, 255
BEQ	R2, R0, L__Load_MP3_File76
NOP	
J	L_Load_MP3_File19
NOP	
L__Load_MP3_File76:
;mp3_player.c,293 :: 		if (Mmc_Fat_Assign(filename, 0) ) {
SW	R25, 12(SP)
MOVZ	R26, R0, R0
JAL	_Mmc_Fat_Assign+0
NOP	
LW	R25, 12(SP)
BNE	R2, R0, L__Load_MP3_File78
NOP	
J	L_Load_MP3_File20
NOP	
L__Load_MP3_File78:
;mp3_player.c,294 :: 		UART1_Write_Line("Loaded MP3 File:");
SW	R25, 12(SP)
LUI	R25, #hi_addr(?lstr4_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr4_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
LW	R25, 12(SP)
;mp3_player.c,295 :: 		UART1_Write_Line(filename);
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,296 :: 		file_loaded = 1;
ORI	R2, R0, 1
SB	R2, Offset(_file_loaded+0)(GP)
;mp3_player.c,297 :: 		}
J	L_Load_MP3_File21
NOP	
L_Load_MP3_File20:
;mp3_player.c,299 :: 		UART1_Write_Line("Failed to load MP3 File: ");
SW	R25, 12(SP)
LUI	R25, #hi_addr(?lstr5_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr5_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
LW	R25, 12(SP)
;mp3_player.c,300 :: 		UART1_Write_Line(filename);
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,301 :: 		file_loaded = 0;
SB	R0, Offset(_file_loaded+0)(GP)
;mp3_player.c,302 :: 		}
L_Load_MP3_File21:
;mp3_player.c,304 :: 		}
J	L_Load_MP3_File22
NOP	
L_Load_MP3_File19:
;mp3_player.c,306 :: 		UART1_Write_Line("MMC FAT not initialized");
LUI	R25, #hi_addr(?lstr6_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr6_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,307 :: 		file_loaded = 0;
SB	R0, Offset(_file_loaded+0)(GP)
;mp3_player.c,308 :: 		}
L_Load_MP3_File22:
;mp3_player.c,310 :: 		}
L_end_Load_MP3_File:
LW	R26, 8(SP)
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 16
JR	RA
NOP	
; end of _Load_MP3_File
_Play_MP3_Chunk:
;mp3_player.c,313 :: 		void Play_MP3_Chunk(){
ADDIU	SP, SP, -12
SW	RA, 0(SP)
;mp3_player.c,314 :: 		long starting_pos = 0;
SW	R25, 4(SP)
;mp3_player.c,316 :: 		starting_pos = current_pos;
LW	R2, Offset(_current_pos+0)(GP)
SW	R2, 8(SP)
;mp3_player.c,319 :: 		if(!muteSound){
LH	R2, Offset(_muteSound+0)(GP)
BEQ	R2, R0, L__Play_MP3_Chunk80
NOP	
J	L_Play_MP3_Chunk23
NOP	
L__Play_MP3_Chunk80:
;mp3_player.c,321 :: 		if(file_loaded && ( file_size > current_pos)) {
LBU	R2, Offset(_file_loaded+0)(GP)
BNE	R2, R0, L__Play_MP3_Chunk82
NOP	
J	L__Play_MP3_Chunk59
NOP	
L__Play_MP3_Chunk82:
LW	R3, Offset(_current_pos+0)(GP)
LW	R2, Offset(_file_size+0)(GP)
SLTU	R2, R3, R2
BNE	R2, R0, L__Play_MP3_Chunk83
NOP	
J	L__Play_MP3_Chunk58
NOP	
L__Play_MP3_Chunk83:
L__Play_MP3_Chunk57:
;mp3_player.c,323 :: 		if(current_pos == 0){
LW	R2, Offset(_current_pos+0)(GP)
BEQ	R2, R0, L__Play_MP3_Chunk84
NOP	
J	L_Play_MP3_Chunk27
NOP	
L__Play_MP3_Chunk84:
;mp3_player.c,324 :: 		UART1_Write_Line("Play started.");
LUI	R25, #hi_addr(?lstr7_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr7_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,325 :: 		Mmc_Fat_Reset(&file_size);          // Call Reset before file reading,
LUI	R25, #hi_addr(_file_size+0)
ORI	R25, R25, #lo_addr(_file_size+0)
JAL	_Mmc_Fat_Reset+0
NOP	
;mp3_player.c,327 :: 		UART1_Write_Line("File Size:");
LUI	R25, #hi_addr(?lstr8_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr8_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,328 :: 		UART1_Write_Long_Variable(file_size);
LW	R25, Offset(_file_size+0)(GP)
JAL	_UART1_Write_Long_Variable+0
NOP	
;mp3_player.c,329 :: 		play_next_song = 0;
SH	R0, Offset(_play_next_song+0)(GP)
;mp3_player.c,331 :: 		unable_to_play = 0;
SW	R0, Offset(_unable_to_play+0)(GP)
;mp3_player.c,332 :: 		}
L_Play_MP3_Chunk27:
;mp3_player.c,335 :: 		while( (current_pos - starting_pos) < (BUFFER_SIZE) ){
L_Play_MP3_Chunk28:
LW	R3, 8(SP)
LW	R2, Offset(_current_pos+0)(GP)
SUBU	R2, R2, R3
SLTI	R2, R2, 512
BNE	R2, R0, L__Play_MP3_Chunk85
NOP	
J	L_Play_MP3_Chunk29
NOP	
L__Play_MP3_Chunk85:
;mp3_player.c,337 :: 		for (i=0; i<BUFFER_SIZE; i++) {
SW	R0, Offset(_i+0)(GP)
L_Play_MP3_Chunk30:
LW	R2, Offset(_i+0)(GP)
SLTIU	R2, R2, 512
BNE	R2, R0, L__Play_MP3_Chunk86
NOP	
J	L_Play_MP3_Chunk31
NOP	
L__Play_MP3_Chunk86:
;mp3_player.c,338 :: 		Mmc_Fat_Read(BufferLarge + i);
LW	R3, Offset(_i+0)(GP)
LUI	R2, #hi_addr(_BufferLarge+0)
ORI	R2, R2, #lo_addr(_BufferLarge+0)
ADDU	R2, R2, R3
MOVZ	R25, R2, R0
JAL	_Mmc_Fat_Read+0
NOP	
;mp3_player.c,337 :: 		for (i=0; i<BUFFER_SIZE; i++) {
LW	R2, Offset(_i+0)(GP)
ADDIU	R2, R2, 1
SW	R2, Offset(_i+0)(GP)
;mp3_player.c,339 :: 		}
J	L_Play_MP3_Chunk30
NOP	
L_Play_MP3_Chunk31:
;mp3_player.c,341 :: 		for (i=0; i<BUFFER_SIZE/32; i++) {
SW	R0, Offset(_i+0)(GP)
L_Play_MP3_Chunk33:
LW	R2, Offset(_i+0)(GP)
SLTIU	R2, R2, 16
BNE	R2, R0, L__Play_MP3_Chunk87
NOP	
J	L_Play_MP3_Chunk34
NOP	
L__Play_MP3_Chunk87:
;mp3_player.c,342 :: 		MP3_SDI_Write_32(BufferLarge + i*32);
LW	R2, Offset(_i+0)(GP)
SLL	R3, R2, 5
LUI	R2, #hi_addr(_BufferLarge+0)
ORI	R2, R2, #lo_addr(_BufferLarge+0)
ADDU	R2, R2, R3
MOVZ	R25, R2, R0
JAL	_MP3_SDI_Write_32+0
NOP	
;mp3_player.c,341 :: 		for (i=0; i<BUFFER_SIZE/32; i++) {
LW	R2, Offset(_i+0)(GP)
ADDIU	R2, R2, 1
SW	R2, Offset(_i+0)(GP)
;mp3_player.c,343 :: 		}
J	L_Play_MP3_Chunk33
NOP	
L_Play_MP3_Chunk34:
;mp3_player.c,345 :: 		current_pos += BUFFER_SIZE;
LW	R2, Offset(_current_pos+0)(GP)
ADDIU	R2, R2, 512
SW	R2, Offset(_current_pos+0)(GP)
;mp3_player.c,350 :: 		}
J	L_Play_MP3_Chunk28
NOP	
L_Play_MP3_Chunk29:
;mp3_player.c,357 :: 		}
J	L_Play_MP3_Chunk36
NOP	
;mp3_player.c,321 :: 		if(file_loaded && ( file_size > current_pos)) {
L__Play_MP3_Chunk59:
L__Play_MP3_Chunk58:
;mp3_player.c,361 :: 		if(unable_to_play < 3){
LW	R2, Offset(_unable_to_play+0)(GP)
SLTI	R2, R2, 3
BNE	R2, R0, L__Play_MP3_Chunk88
NOP	
J	L_Play_MP3_Chunk37
NOP	
L__Play_MP3_Chunk88:
;mp3_player.c,362 :: 		UART1_Write_Line("Unable to play MP3 file.");
LUI	R25, #hi_addr(?lstr9_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr9_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,363 :: 		}
L_Play_MP3_Chunk37:
;mp3_player.c,365 :: 		current_pos = 0;
SW	R0, Offset(_current_pos+0)(GP)
;mp3_player.c,366 :: 		file_loaded = 0;
SB	R0, Offset(_file_loaded+0)(GP)
;mp3_player.c,367 :: 		play_next_song = 1;
ORI	R2, R0, 1
SH	R2, Offset(_play_next_song+0)(GP)
;mp3_player.c,368 :: 		song_count++;
LH	R2, Offset(_song_count+0)(GP)
ADDIU	R2, R2, 1
SH	R2, Offset(_song_count+0)(GP)
;mp3_player.c,370 :: 		unable_to_play++;
LW	R2, Offset(_unable_to_play+0)(GP)
ADDIU	R2, R2, 1
SW	R2, Offset(_unable_to_play+0)(GP)
;mp3_player.c,371 :: 		}
L_Play_MP3_Chunk36:
;mp3_player.c,372 :: 		}
J	L_Play_MP3_Chunk38
NOP	
L_Play_MP3_Chunk23:
;mp3_player.c,375 :: 		Delay_ms(35);   //temp turned off
LUI	R24, 14
ORI	R24, R24, 15828
L_Play_MP3_Chunk39:
ADDIU	R24, R24, -1
BNE	R24, R0, L_Play_MP3_Chunk39
NOP	
NOP	
NOP	
;mp3_player.c,376 :: 		}
L_Play_MP3_Chunk38:
;mp3_player.c,378 :: 		}
L_end_Play_MP3_Chunk:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 12
JR	RA
NOP	
; end of _Play_MP3_Chunk
_Play_MP3:
;mp3_player.c,388 :: 		void Play_MP3(){
ADDIU	SP, SP, -8
SW	RA, 0(SP)
;mp3_player.c,390 :: 		if(file_loaded) {
SW	R25, 4(SP)
LBU	R2, Offset(_file_loaded+0)(GP)
BNE	R2, R0, L__Play_MP391
NOP	
J	L_Play_MP341
NOP	
L__Play_MP391:
;mp3_player.c,392 :: 		UART1_Write_Line("Play started.");
LUI	R25, #hi_addr(?lstr10_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr10_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,393 :: 		Mmc_Fat_Reset(&file_size);          // Call Reset before file reading,
LUI	R25, #hi_addr(_file_size+0)
ORI	R25, R25, #lo_addr(_file_size+0)
JAL	_Mmc_Fat_Reset+0
NOP	
;mp3_player.c,396 :: 		while (file_size > BUFFER_SIZE) {
L_Play_MP342:
LW	R2, Offset(_file_size+0)(GP)
SLTIU	R2, R2, 513
BEQ	R2, R0, L__Play_MP392
NOP	
J	L_Play_MP343
NOP	
L__Play_MP392:
;mp3_player.c,398 :: 		for (i=0; i<BUFFER_SIZE; i++) {
SW	R0, Offset(_i+0)(GP)
L_Play_MP344:
LW	R2, Offset(_i+0)(GP)
SLTIU	R2, R2, 512
BNE	R2, R0, L__Play_MP393
NOP	
J	L_Play_MP345
NOP	
L__Play_MP393:
;mp3_player.c,399 :: 		Mmc_Fat_Read(BufferLarge + i);
LW	R3, Offset(_i+0)(GP)
LUI	R2, #hi_addr(_BufferLarge+0)
ORI	R2, R2, #lo_addr(_BufferLarge+0)
ADDU	R2, R2, R3
MOVZ	R25, R2, R0
JAL	_Mmc_Fat_Read+0
NOP	
;mp3_player.c,398 :: 		for (i=0; i<BUFFER_SIZE; i++) {
LW	R2, Offset(_i+0)(GP)
ADDIU	R2, R2, 1
SW	R2, Offset(_i+0)(GP)
;mp3_player.c,400 :: 		}
J	L_Play_MP344
NOP	
L_Play_MP345:
;mp3_player.c,402 :: 		for (i=0; i<BUFFER_SIZE/32; i++) {
SW	R0, Offset(_i+0)(GP)
L_Play_MP347:
LW	R2, Offset(_i+0)(GP)
SLTIU	R2, R2, 16
BNE	R2, R0, L__Play_MP394
NOP	
J	L_Play_MP348
NOP	
L__Play_MP394:
;mp3_player.c,403 :: 		MP3_SDI_Write_32(BufferLarge + i*32);
LW	R2, Offset(_i+0)(GP)
SLL	R3, R2, 5
LUI	R2, #hi_addr(_BufferLarge+0)
ORI	R2, R2, #lo_addr(_BufferLarge+0)
ADDU	R2, R2, R3
MOVZ	R25, R2, R0
JAL	_MP3_SDI_Write_32+0
NOP	
;mp3_player.c,402 :: 		for (i=0; i<BUFFER_SIZE/32; i++) {
LW	R2, Offset(_i+0)(GP)
ADDIU	R2, R2, 1
SW	R2, Offset(_i+0)(GP)
;mp3_player.c,404 :: 		}
J	L_Play_MP347
NOP	
L_Play_MP348:
;mp3_player.c,406 :: 		file_size -= BUFFER_SIZE;
LW	R2, Offset(_file_size+0)(GP)
ADDIU	R2, R2, -512
SW	R2, Offset(_file_size+0)(GP)
;mp3_player.c,411 :: 		}
J	L_Play_MP342
NOP	
L_Play_MP343:
;mp3_player.c,414 :: 		for (i=0; i<file_size; i++) {
SW	R0, Offset(_i+0)(GP)
L_Play_MP350:
LW	R3, Offset(_file_size+0)(GP)
LW	R2, Offset(_i+0)(GP)
SLTU	R2, R2, R3
BNE	R2, R0, L__Play_MP395
NOP	
J	L_Play_MP351
NOP	
L__Play_MP395:
;mp3_player.c,415 :: 		Mmc_Fat_Read(BufferLarge + i);
LW	R3, Offset(_i+0)(GP)
LUI	R2, #hi_addr(_BufferLarge+0)
ORI	R2, R2, #lo_addr(_BufferLarge+0)
ADDU	R2, R2, R3
MOVZ	R25, R2, R0
JAL	_Mmc_Fat_Read+0
NOP	
;mp3_player.c,414 :: 		for (i=0; i<file_size; i++) {
LW	R2, Offset(_i+0)(GP)
ADDIU	R2, R2, 1
SW	R2, Offset(_i+0)(GP)
;mp3_player.c,416 :: 		}
J	L_Play_MP350
NOP	
L_Play_MP351:
;mp3_player.c,417 :: 		for (i=0; i<file_size; i++) {
SW	R0, Offset(_i+0)(GP)
L_Play_MP353:
LW	R3, Offset(_file_size+0)(GP)
LW	R2, Offset(_i+0)(GP)
SLTU	R2, R2, R3
BNE	R2, R0, L__Play_MP396
NOP	
J	L_Play_MP354
NOP	
L__Play_MP396:
;mp3_player.c,418 :: 		MP3_SDI_Write(BufferLarge[i]);
LW	R3, Offset(_i+0)(GP)
LUI	R2, #hi_addr(_BufferLarge+0)
ORI	R2, R2, #lo_addr(_BufferLarge+0)
ADDU	R2, R2, R3
LBU	R25, 0(R2)
JAL	_MP3_SDI_Write+0
NOP	
;mp3_player.c,417 :: 		for (i=0; i<file_size; i++) {
LW	R2, Offset(_i+0)(GP)
ADDIU	R2, R2, 1
SW	R2, Offset(_i+0)(GP)
;mp3_player.c,419 :: 		}
J	L_Play_MP353
NOP	
L_Play_MP354:
;mp3_player.c,422 :: 		UART1_Write_Line("Play finished.");
LUI	R25, #hi_addr(?lstr11_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr11_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,423 :: 		}
J	L_Play_MP356
NOP	
L_Play_MP341:
;mp3_player.c,426 :: 		UART1_Write_Line("Unable to play MP3 file.");
LUI	R25, #hi_addr(?lstr12_mp3_player+0)
ORI	R25, R25, #lo_addr(?lstr12_mp3_player+0)
JAL	_UART1_Write_Line+0
NOP	
;mp3_player.c,427 :: 		}
L_Play_MP356:
;mp3_player.c,429 :: 		}
L_end_Play_MP3:
LW	R25, 4(SP)
LW	RA, 0(SP)
ADDIU	SP, SP, 8
JR	RA
NOP	
; end of _Play_MP3
