#line 1 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic32/include/built_in.h"
#line 8 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
extern void UART1_Write_Line(char *uart_text);
extern void UART1_Write_Variable(int var);
extern void UART1_Write_Long_Variable(long var);
#line 16 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
const char WRITE_CODE = 0x02;
const char READ_CODE = 0x03;

const char SCI_BASE_ADDR = 0x00;
const char SCI_MODE_ADDR = 0x00;
const char SCI_STATUS_ADDR = 0x01;
const char SCI_BASS_ADDR = 0x02;
const char SCI_CLOCKF_ADDR = 0x03;
const char SCI_DECODE_TIME_ADDR = 0x04;
const char SCI_AUDATA_ADDR = 0x05;
const char SCI_WRAM_ADDR = 0x06;
const char SCI_WRAMADDR_ADDR = 0x07;
const char SCI_HDAT0_ADDR = 0x08;
const char SCI_HDAT1_ADDR = 0x09;
const char SCI_AIADDR_ADDR = 0x0A;
const char SCI_VOL_ADDR = 0x0B;
const char SCI_AICTRL0_ADDR = 0x0C;
const char SCI_AICTRL1_ADDR = 0x0D;
const char SCI_AICTRL2_ADDR = 0x0E;
const char SCI_AICTRL3_ADDR = 0x0F;


void MP3_SCI_Write(char address, unsigned int data_in);

void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer);

void MP3_SDI_Write(char data_);

void MP3_SDI_Write_32(char *data_);

void MP3_Set_Volume(char left, char right);
#line 51 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
sbit Mmc_Chip_Select at LATG9_bit;
sbit Mmc_Chip_Select_Direction at TRISG9_bit;
#line 57 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
sbit CS_Serial_Flash_bit at LATC2_bit;
sbit CS_Serial_Flash_Direction_bit at TRISC2_bit;



unsigned long file_size;
const BYTES_2_WRITE = 32;
const BUFFER_SIZE = 512;
char mp3_buffer[BUFFER_SIZE];
char volume_left = 64, volume_right =64;
extern char Example_State;


char data_buffer_32[32];
unsigned long i;
char BufferLarge[BUFFER_SIZE];



extern int muteSound;


char file_loaded = 0;


long current_pos = 0;


int play_next_song = 0;


int song_count = 0;

long unable_to_play = 0;
#line 98 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
sbit MP3_CS_Direction at TRISG15_bit;
sbit MP3_CS at LATG15_bit;
sbit MP3_RST_Direction at TRISD9_bit;
sbit MP3_RST at LATD9_bit;
sbit DREQ_Direction at TRISD8_bit;
sbit DREQ at RD8_bit;
sbit BSYNC_Direction at TRISB8_bit;
sbit BSYNC at LATB8_bit;
#line 114 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
void MP3_SCI_Write(char address, unsigned int data_in) {
 BSYNC = 1;

 MP3_CS = 0;
 SPI_Write(WRITE_CODE);
 SPI_Write(address);
 SPI_Write( ((char *)&data_in)[1] );
 SPI_Write( ((char *)&data_in)[0] );
 MP3_CS = 1;
 while (DREQ == 0);
}
#line 133 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer) {
 unsigned int temp;

 MP3_CS = 0;
 SPI_Write(READ_CODE);
 SPI_Write(start_address);

 while (words_count--) {
 temp = SPI_Read(0);
 temp <<= 8;
 temp += SPI_Read(0);
 *(data_buffer++) = temp;
 }
 MP3_CS = 1;
 while (DREQ == 0);
}
#line 157 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
void MP3_SDI_Write(char data_) {

 MP3_CS = 1;
 BSYNC = 0;

 while (DREQ == 0);

 SPI_Write(data_);
 BSYNC = 1;
}
#line 175 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
void MP3_SDI_Write_32(char *data_) {
 char i;

 MP3_CS = 1;
 BSYNC = 0;

 while (DREQ == 0);

 for (i=0; i<32; i++)
 SPI_Write(data_[i]);
 BSYNC = 1;
}
#line 195 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
void MP3_Set_Volume(char left, char right) {
 unsigned int volume;

 volume = (left<<8) + right;
 MP3_SCI_Write(SCI_VOL_ADDR, volume);
}
#line 210 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
void MP3_Init(void)
{
 BSYNC = 1;
 MP3_CS = 1;


 UART1_Write_Line("Initializing VS1011E decoder interface");


 MP3_RST = 0;
 Delay_ms(10);
 MP3_RST = 1;

 while (DREQ == 0);

 MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
 MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
 MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);


 volume_left = 0;
 volume_right = volume_left;
 MP3_Set_Volume(volume_left, volume_right);



}
#line 247 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/mp3_player.c"
void MP3_Start(void)
{

 CS_Serial_Flash_Direction_bit = 0;
 CS_Serial_Flash_bit = 1;

 Mmc_Chip_Select_Direction = 0;

 MP3_CS_Direction = 0;
 MP3_CS = 1;
 MP3_RST_Direction = 0;
 MP3_RST = 1;

 DREQ_Direction = 1;
 BSYNC_Direction = 0;
 BSYNC = 0;
 BSYNC = 1;









 UART1_Write_Line("Initializing SPI");


 WS_SPI_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, 26, _SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_IDLE_2_ACTIVE);



 MP3_Init();
 Delay_ms(1000);

}

void Load_MP3_File(char *filename){

 UART1_Write_Line("Initializing MMC_FAT");


 current_pos = 0;

 if (Mmc_Fat_Init() == 0) {
 if (Mmc_Fat_Assign(filename, 0) ) {
 UART1_Write_Line("Loaded MP3 File:");
 UART1_Write_Line(filename);
 file_loaded = 1;
 }
 else {
 UART1_Write_Line("Failed to load MP3 File: ");
 UART1_Write_Line(filename);
 file_loaded = 0;
 }

 }
 else {
 UART1_Write_Line("MMC FAT not initialized");
 file_loaded = 0;
 }

}


void Play_MP3_Chunk(){
 long starting_pos = 0;

 starting_pos = current_pos;


 if(!muteSound){

 if(file_loaded && ( file_size > current_pos)) {

 if(current_pos == 0){
 UART1_Write_Line("Play started.");
 Mmc_Fat_Reset(&file_size);

 UART1_Write_Line("File Size:");
 UART1_Write_Long_Variable(file_size);
 play_next_song = 0;

 unable_to_play = 0;
 }


 while( (current_pos - starting_pos) < (BUFFER_SIZE) ){

 for (i=0; i<BUFFER_SIZE; i++) {
 Mmc_Fat_Read(BufferLarge + i);
 }

 for (i=0; i<BUFFER_SIZE/32; i++) {
 MP3_SDI_Write_32(BufferLarge + i*32);
 }

 current_pos += BUFFER_SIZE;




 }






 }
 else{


 if(unable_to_play < 3){
 UART1_Write_Line("Unable to play MP3 file.");
 }

 current_pos = 0;
 file_loaded = 0;
 play_next_song = 1;
 song_count++;

 unable_to_play++;
 }
 }
 else{

 Delay_ms(35);
 }

}









void Play_MP3(){

 if(file_loaded) {

 UART1_Write_Line("Play started.");
 Mmc_Fat_Reset(&file_size);


 while (file_size > BUFFER_SIZE) {

 for (i=0; i<BUFFER_SIZE; i++) {
 Mmc_Fat_Read(BufferLarge + i);
 }

 for (i=0; i<BUFFER_SIZE/32; i++) {
 MP3_SDI_Write_32(BufferLarge + i*32);
 }

 file_size -= BUFFER_SIZE;




 }


 for (i=0; i<file_size; i++) {
 Mmc_Fat_Read(BufferLarge + i);
 }
 for (i=0; i<file_size; i++) {
 MP3_SDI_Write(BufferLarge[i]);
 }


 UART1_Write_Line("Play finished.");
 }
 else{

 UART1_Write_Line("Unable to play MP3 file.");
 }

}
