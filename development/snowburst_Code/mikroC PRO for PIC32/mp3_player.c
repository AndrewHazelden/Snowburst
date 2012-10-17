/*
* This is the VSI VS1011E sound driver
*/

#include <built_in.h>


extern void UART1_Write_Line(char *uart_text);
extern void UART1_Write_Variable(int var);
extern void UART1_Write_Long_Variable(long var);


/**************************************************************************************************
* VS1053 constants
**************************************************************************************************/
const char WRITE_CODE           = 0x02;
const char READ_CODE            = 0x03;

const char SCI_BASE_ADDR        = 0x00;
const char SCI_MODE_ADDR        = 0x00;
const char SCI_STATUS_ADDR      = 0x01;
const char SCI_BASS_ADDR        = 0x02;
const char SCI_CLOCKF_ADDR      = 0x03;
const char SCI_DECODE_TIME_ADDR = 0x04;
const char SCI_AUDATA_ADDR      = 0x05;
const char SCI_WRAM_ADDR        = 0x06;
const char SCI_WRAMADDR_ADDR    = 0x07;
const char SCI_HDAT0_ADDR       = 0x08;
const char SCI_HDAT1_ADDR       = 0x09;
const char SCI_AIADDR_ADDR      = 0x0A;
const char SCI_VOL_ADDR         = 0x0B;
const char SCI_AICTRL0_ADDR     = 0x0C;
const char SCI_AICTRL1_ADDR     = 0x0D;
const char SCI_AICTRL2_ADDR     = 0x0E;
const char SCI_AICTRL3_ADDR     = 0x0F;

// Writes one byte to MP3 SCI
void MP3_SCI_Write(char address, unsigned int data_in);
// Reads words_count words from MP3 SCI
void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer);
// Write one byte to MP3 SDI
void MP3_SDI_Write(char data_);
// Write 32 bytes to MP3 SDI
void MP3_SDI_Write_32(char *data_);
// Set volume
void MP3_Set_Volume(char left, char right);

/**************************************************************************************************
* MMC Chip Select connection
**************************************************************************************************/
sbit Mmc_Chip_Select at LATG9_bit;
sbit Mmc_Chip_Select_Direction at TRISG9_bit;

/**************************************************************************************************
* Serial Flash Chip Select connection
**************************************************************************************************/
sbit CS_Serial_Flash_bit at LATC2_bit;
sbit CS_Serial_Flash_Direction_bit at TRISC2_bit;


// Global Variables
unsigned long file_size;
const BYTES_2_WRITE = 32;
const BUFFER_SIZE = 512;                //default was 128 bytes
char mp3_buffer[BUFFER_SIZE];
char volume_left = 64, volume_right =64;
extern char Example_State;


char  data_buffer_32[32];
unsigned long i;
char  BufferLarge[BUFFER_SIZE];


//Mute sound flag
extern int muteSound;

//Indicates if a MP3 file has been loaded from the MMC card
char file_loaded = 0;

//Indicates the current file position after running play_MP3_Chunk
long current_pos = 0;

//flag to indicate that the current song is done playing
int play_next_song = 0;

//song counter
int song_count = 0;

long unable_to_play = 0;
//end old code



/**************************************************************************************************
* CODEC V1053E connections
**************************************************************************************************/
sbit MP3_CS_Direction          at TRISG15_bit;
sbit MP3_CS                    at LATG15_bit;
sbit MP3_RST_Direction         at TRISD9_bit;
sbit MP3_RST                   at LATD9_bit;
sbit DREQ_Direction            at TRISD8_bit;
sbit DREQ                      at RD8_bit;
sbit BSYNC_Direction           at TRISB8_bit;
sbit BSYNC                     at LATB8_bit;

/**************************************************************************************************
* Function MP3_SCI_Write()
* -------------------------------------------------------------------------------------------------
* Overview: Function writes one byte to MP3 SCI
* Input: register address in codec, data
* Output: Nothing
**************************************************************************************************/
void MP3_SCI_Write(char address, unsigned int data_in) {
  BSYNC = 1;

  MP3_CS = 0;                    // select MP3 SCI
  SPI_Write(WRITE_CODE);
  SPI_Write(address);
  SPI_Write(Hi(data_in));       // high byte
  SPI_Write(Lo(data_in));       // low byte
  MP3_CS = 1;                    // deselect MP3 SCI
  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
}

/**************************************************************************************************
* Function MP3_SCI_Read()
* -------------------------------------------------------------------------------------------------
* Overview: Function reads words_count words from MP3 SCI
* Input: start address, word count to be read
* Output: words are stored to data_buffer
**************************************************************************************************/
void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer) {
  unsigned int temp;

  MP3_CS = 0;                    // select MP3 SCI
  SPI_Write(READ_CODE);
  SPI_Write(start_address);

  while (words_count--) {        // read words_count words byte per byte
    temp = SPI_Read(0);
    temp <<= 8;
    temp += SPI_Read(0);
    *(data_buffer++) = temp;
  }
  MP3_CS = 1;                    // deselect MP3 SCI
  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
}

/**************************************************************************************************
* Function MP3_SDI_Write()
* -------------------------------------------------------------------------------------------------
* Overview: Function write one byte to MP3 SDI
* Input: data to be writed
* Output: Nothing
**************************************************************************************************/
void MP3_SDI_Write(char data_) {

  MP3_CS = 1;
  BSYNC = 0;

  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI

  SPI_Write(data_);
  BSYNC = 1;
}

/**************************************************************************************************
* Function MP3_SDI_Write_32
* -------------------------------------------------------------------------------------------------
* Overview: Function Write 32 bytes to MP3 SDI
* Input: data buffer
* Output: Nothing
**************************************************************************************************/
void MP3_SDI_Write_32(char *data_) {
  char i;

  MP3_CS = 1;
  BSYNC = 0;

  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI

  for (i=0; i<32; i++)
  SPI_Write(data_[i]);
  BSYNC = 1;
}

/**************************************************************************************************
* Function MP3_Set_Volume()
* -------------------------------------------------------------------------------------------------
* Overview: Function set volume on the left and right channel
* Input: left channel volume, right channel volume
* Output: Nothing
**************************************************************************************************/
void MP3_Set_Volume(char left, char right) {
  unsigned int volume;

  volume = (left<<8) + right;             // calculate value
  MP3_SCI_Write(SCI_VOL_ADDR, volume);    // Write value to VOL register
}


/**************************************************************************************************
* Function MP3_Init()
* -------------------------------------------------------------------------------------------------
* Overview: Initializes MP3 codec chip
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
void MP3_Init(void)
{
  BSYNC = 1;
  MP3_CS = 1;

  
  UART1_Write_Line("Initializing VS1011E decoder interface");
  
  // Hardware reset
  MP3_RST = 0;
  Delay_ms(10);
  MP3_RST = 1;

  while (DREQ == 0);

  MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
  MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
  MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);   // default 12 288 000 Hz

  // Maximum volume is 0x00 and total silence is 0xFE.
  volume_left  = 0; //0x3F;
  volume_right = volume_left; //0x3F;
  MP3_Set_Volume(volume_left, volume_right);
  
  //example visualtft onscreen volume bar
  //UpdateVolumeBar(100 - volume_left, 0);
}



/**************************************************************************************************
* Function MP3_Start()
* -------------------------------------------------------------------------------------------------
* Overview: Function Initialize SPI to communicate with MP3 codec and opens mp3 file for playing
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
void MP3_Start(void)
{
  // Disable other peripheral modules on the same SPI bus
  CS_Serial_Flash_Direction_bit = 0;
  CS_Serial_Flash_bit = 1;             // Disable Serial Flash module

  Mmc_Chip_Select_Direction = 0;

  MP3_CS_Direction  = 0;               // Configure MP3_CS as output
  MP3_CS            = 1;               // Deselect MP3_CS
  MP3_RST_Direction = 0;               // Configure MP3_RST as output
  MP3_RST           = 1;               // Set MP3_RST pin

  DREQ_Direction    = 1;               // Configure DREQ as input
  BSYNC_Direction   = 0;               // Configure BSYNC as output
  BSYNC             = 0;               // Clear BSYNC
  BSYNC             = 1;               // Clear BSYNC

  // Initialize SPI2 module
  // master_mode   = _SPI_MASTER
  // data_mode     = _SPI_8_BIT
  // clock_divider = 1-1024
  // slave_select  = _SPI_SS_DISABLE (Only for slave mod)
  // data_sample   = _SPI_DATA_SAMPLE_MIDDLE
  // clock_idle    = _SPI_CLK_IDLE_LOW
  // edge          = _SPI_ACTIVE_2_IDLE
  UART1_Write_Line("Initializing SPI");
  
  //For the Mikromedia Workstation board:
  WS_SPI_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, 26, _SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_IDLE_2_ACTIVE);
  //SPI2_Init_Advanced(_SPI_MASTER, _SPI_8_BIT, 26, _SPI_SS_DISABLE, _SPI_DATA_SAMPLE_MIDDLE, _SPI_CLK_IDLE_LOW, _SPI_IDLE_2_ACTIVE);


  MP3_Init();
  Delay_ms(1000);
  
}

void Load_MP3_File(char *filename){

  UART1_Write_Line("Initializing MMC_FAT");
  
  //Reset current position
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

  //Check if the sound has been muted
  if(!muteSound){
    //Check if the MP3 was loaded from the MMC card
    if(file_loaded && ( file_size > current_pos)) {

      if(current_pos == 0){
        UART1_Write_Line("Play started.");
        Mmc_Fat_Reset(&file_size);          // Call Reset before file reading,
        //   procedure returns size of the file
        UART1_Write_Line("File Size:");
        UART1_Write_Long_Variable(file_size);
        play_next_song = 0;
        
        unable_to_play = 0;
      }

      //Run the while loop until the buffer is full
      while( (current_pos - starting_pos) < (BUFFER_SIZE) ){

        for (i=0; i<BUFFER_SIZE; i++) {
          Mmc_Fat_Read(BufferLarge + i);
        }

        for (i=0; i<BUFFER_SIZE/32; i++) {
          MP3_SDI_Write_32(BufferLarge + i*32);
        }

        current_pos += BUFFER_SIZE;


        //MP3 file reading loop
        //UART1_Write_Text(".");
      }

      //temp turn on for debugging
      //UART1_Write_Line("Current Pos:");
      //UART1_Write_Long_Variable(current_pos);
      
      //UART1_Write_Line("Play chunk finished.");
    }
    else{
      //MP3 File wasn't loaded
      //limit how many times the same error is printed
      if(unable_to_play < 3){
        UART1_Write_Line("Unable to play MP3 file.");
      }
      //reset mp3 position
      current_pos = 0;
      file_loaded = 0;
      play_next_song = 1;
      song_count++;
      
      unable_to_play++;
    }
  }
  else{
    //slow down the game speed if sound is muted
    Delay_ms(35);   //temp turned off
  }

}









void Play_MP3(){

  if(file_loaded) {

    UART1_Write_Line("Play started.");
    Mmc_Fat_Reset(&file_size);          // Call Reset before file reading,
    //   procedure returns size of the file
    // send file blocks to MP3 SDI
    while (file_size > BUFFER_SIZE) {

      for (i=0; i<BUFFER_SIZE; i++) {
        Mmc_Fat_Read(BufferLarge + i);
      }

      for (i=0; i<BUFFER_SIZE/32; i++) {
        MP3_SDI_Write_32(BufferLarge + i*32);
      }

      file_size -= BUFFER_SIZE;


      //main update loop
      //UART1_Write_Text(".");
    }

    // send the rest of the file to MP3 SDI
    for (i=0; i<file_size; i++) {
      Mmc_Fat_Read(BufferLarge + i);
    }
    for (i=0; i<file_size; i++) {
      MP3_SDI_Write(BufferLarge[i]);
    }


    UART1_Write_Line("Play finished.");
  }
  else{
    //MP3 File wasn't loaded
    UART1_Write_Line("Unable to play MP3 file.");
  }

}