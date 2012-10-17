#line 1 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/snowburst_events_code.c"
#line 1 "c:/users/dsi/desktop/snowburst/development/snowburst_code/mikroc pro for pic32/snowburst_objects.h"
typedef enum {_taLeft, _taCenter, _taRight} TTextAlign;

typedef struct Screen TScreen;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned short ObjectsCount;
};

extern TScreen Screen1;
#line 24 "c:/users/dsi/desktop/snowburst/development/snowburst_code/mikroc pro for pic32/snowburst_objects.h"
void DrawScreen(TScreen *aScreen);
void Check_TP();
void Start_TP();
