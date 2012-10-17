#include "snowburst_objects.h"
#include "built_in.h"


// TFT module connections
char TFT_DataPort at LATE;
sbit TFT_RST at LATC1_bit;
sbit TFT_BLED at LATA9_bit;
sbit TFT_RS at LATB15_bit;
sbit TFT_CS at LATF12_bit;
sbit TFT_RD at LATD5_bit;
sbit TFT_WR at LATD4_bit;
char TFT_DataPort_Direction at TRISE;
sbit TFT_RST_Direction at TRISC1_bit;
sbit TFT_BLED_Direction at TRISA9_bit;
sbit TFT_RS_Direction at TRISB15_bit;
sbit TFT_CS_Direction at TRISF12_bit;
sbit TFT_RD_Direction at TRISD5_bit;
sbit TFT_WR_Direction at TRISD4_bit;
// End TFT module connections

// Touch Panel module connections
sbit DRIVEX_LEFT at LATB13_bit;
sbit DRIVEX_RIGHT at LATB11_bit;
sbit DRIVEY_UP at LATB12_bit;
sbit DRIVEY_DOWN at LATB10_bit;
sbit DRIVEX_LEFT_DIRECTION at TRISB13_bit;
sbit DRIVEX_RIGHT_DIRECTION at TRISB11_bit;
sbit DRIVEY_UP_DIRECTION at TRISB12_bit;
sbit DRIVEY_DOWN_DIRECTION at TRISB10_bit;
// End Touch Panel module connections

// Global variables
unsigned int Xcoord, Ycoord;
const ADC_THRESHOLD = 1000;
char PenDown;
typedef unsigned long TPointer;
TPointer PressedObject;
int PressedObjectType;
unsigned int caption_length, caption_height;
unsigned int display_width, display_height;

int _object_count;
unsigned short object_pressed;

void PMPWaitBusy() {
  while(PMMODEbits.BUSY);
}

void Set_Index(unsigned short index) {
  TFT_RS = 0;
  PMDIN = index;
  PMPWaitBusy();
}

void Write_Command( unsigned short cmd ) {
  TFT_RS = 1;
  PMDIN = cmd;
  PMPWaitBusy();
}

void Write_Data(unsigned int _data) {
  TFT_RS = 1;
  PMDIN = _data;
  PMPWaitBusy();
}


void Init_ADC() {
  AD1PCFG = 0xFFFF;
  PCFG12_bit = 0;
  PCFG13_bit = 0;
  // PMP setup
  ADC1_Init();
}
static void InitializeTouchPanel() {
  Init_ADC();
  TFT_Set_Active(Set_Index, Write_Command, Write_Data);
  TFT_Init(320, 240);

  TP_TFT_Init(320, 240, 13, 12);                                  // Initialize touch panel
  TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold

  PenDown = 0;
  PressedObject = 0;
  PressedObjectType = -1;
}


/////////////////////////
  TScreen*  CurrentScreen;

  TScreen                Screen1;




static void InitializeObjects() {
  Screen1.Color                     = 0x0000;
  Screen1.Width                     = 320;
  Screen1.Height                    = 240;
  Screen1.ObjectsCount              = 0;

}

static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
  if ( (Left<= X) && (Left+ Width - 1 >= X) &&
       (Top <= Y)  && (Top + Height - 1 >= Y) )
    return 1;
  else
    return 0;
}



 void DeleteTrailingSpaces(char* str){
   char i;
   i = 0;
   while(1) {
   if(str[0] == ' ') {
      for(i = 0; i < strlen(str); i++) {
       str[i] = str[i+1];
      }
   }
   else
     break;
  }
 }

void DrawScreen(TScreen *aScreen) {
 int order;
  char save_bled, save_bled_direction;

  object_pressed = 0;
  order = 0;
  CurrentScreen = aScreen;

  if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
    save_bled = TFT_BLED;
    save_bled_direction = TFT_BLED_Direction;
    TFT_BLED_Direction = 0;
    TFT_BLED           = 0;
    TFT_Set_Active(Set_Index, Write_Command, Write_Data);
    TFT_Init(CurrentScreen->Width, CurrentScreen->Height);
    TP_TFT_Init(CurrentScreen->Width, CurrentScreen->Height, 13, 12);                                  // Initialize touch panel
    TP_TFT_Set_ADC_Threshold(ADC_THRESHOLD);                              // Set touch panel ADC threshold
    TFT_Fill_Screen(CurrentScreen->Color);
    display_width = CurrentScreen->Width;
    display_height = CurrentScreen->Height;
    TFT_BLED           = save_bled;
    TFT_BLED_Direction = save_bled_direction;
  }
  else
    TFT_Fill_Screen(CurrentScreen->Color);


  while (order < CurrentScreen->ObjectsCount) {
  }
}

void Get_Object(unsigned int X, unsigned int Y) {
  _object_count = -1;
}


static void Process_TP_Press(unsigned int X, unsigned int Y) {

  Get_Object(X, Y);


  if (_object_count != -1) {
  }
}

static void Process_TP_Up(unsigned int X, unsigned int Y) {


  Get_Object(X, Y);


  if (_object_count != -1) {
  }
  PressedObject = 0;
  PressedObjectType = -1;
}

static void Process_TP_Down(unsigned int X, unsigned int Y) {

  object_pressed      = 0;

  Get_Object(X, Y);

  if (_object_count != -1) {
  }
}

void Check_TP() {
  if (TP_TFT_Press_Detect()) {
    // After a PRESS is detected read X-Y and convert it to Display dimensions space
    if (TP_TFT_Get_Coordinates(&Xcoord, &Ycoord) == 0) {
      Process_TP_Press(Xcoord, Ycoord);
      if (PenDown == 0) {
        PenDown = 1;
        Process_TP_Down(Xcoord, Ycoord);
      }
    }
  }
  else if (PenDown == 1) {
    PenDown = 0;
    Process_TP_Up(Xcoord, Ycoord);
  }
}

void Init_MCU() {
  PMMODE = 0;
  PMAEN  = 0;
  PMCON  = 0;  // WRSP: Write Strobe Polarity bit
  PMMODEbits.MODE = 2;     // Master 2
  PMMODEbits.WAITB = 0;
  PMMODEbits.WAITM = 1;
  PMMODEbits.WAITE = 0;
  PMMODEbits.MODE16 = 1;   // 16 bit mode
  PMCONbits.CSF = 0;
  PMCONbits.PTRDEN = 1;
  PMCONbits.PTWREN = 1;
  PMCONbits.PMPEN = 1;
  TP_TFT_Rotate_180(0);
  TFT_Set_Active(Set_Index,Write_Command,Write_Data);
}

void Start_TP() {
  Init_MCU();

  InitializeTouchPanel();

  // You can get calibration constants using touch panel calibration example
  TP_TFT_Set_Calibration_Consts(76, 907, 77, 915);    // Set calibration constants

  InitializeObjects();
  display_width = Screen1.Width;
  display_height = Screen1.Height;
  DrawScreen(&Screen1);
}
