#line 1 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/snowburst_main.c"
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
#line 1 "c:/users/dsi/desktop/snowburst/development/snowburst_code/mikroc pro for pic32/snowburst_resources.h"
const code char gameover_bmp[12503];
const code char snowflake1_bmp[1542];
const code char snowflake2_bmp[1542];
const code char snowflake3_bmp[1542];
const code char snowflake4_bmp[1542];
const code char snowflake5_bmp[1542];
const code char snowflake6_bmp[1542];
const code char snowflake7_bmp[1542];
const code char snowflake8_bmp[1542];
const code char snowflake9_bmp[1542];
const code char snowflake10_bmp[1542];
const code char snowflake11_bmp[1542];
const code char snowflake12_bmp[1542];
const code char snowflake13_bmp[1542];
const code char snowflake14_bmp[1542];
const code char title_bmp[12503];
#line 76 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/snowburst_main.c"
extern void Set_Index(unsigned short index);
extern void Write_Command(unsigned short cmd);
extern void Write_Data(unsigned int _data);
extern void MP3_Start();
extern void Play_MP3();
extern void Play_MP3_Chunk();
extern void Load_MP3_File(char *filename);
extern void Set_Volume(char left,char right);
extern void UART1_Write_Line(char *uart_text);
extern void UART1_Write_Label_Var(char *uart_text, int var );
void UART1_Write_Label_Long_Var(char *uart_text, long var);
void UART1_Write_Label_Float_Var(char *uart_text, float var);
extern char IsCollision (unsigned int Shape_X, unsigned int Shape_Y, unsigned int Shape_Width, unsigned int Shape_Height, unsigned int Button_Left, unsigned int Button_Top, unsigned int Button_Width, unsigned int Button_Height);

void Start_UART();

void GetNextSong();
void PreRollSong();



extern char file_loaded;
extern long current_pos;
extern unsigned long file_size;
extern int play_next_song = 0;


extern int song_count;


int prev_sound_pos = 0;
int prev_file_size = 0;


int muteSound = 0;
int prev_muteSound = 0;

unsigned long frame_counter = 0;


int x_direction = 0;


long score = 0;
long prev_score = 0;



long high_score = 0;

char level_text[11];
char score_text[11];


char score_display_text[80];


char level_display_text[80];


char temp_txt[12];

long snow_height = 0;
long prev_snow_height = 0;


int game_over = 0;

unsigned int X_Coord, Y_Coord, Prev_X_Coord, Prev_Y_Coord;

char Pen_Down = 0;
int Starting_Pen_Down_X_Coord = 0;
int Starting_Pen_Down_Y_Coord = 0;

int X_Drag_Distance = 0;


void flakeMissed(int flake_number);
void DrawFlake(int frame, int x, int y, int scale);
void Init_Sprites();
int GetRandom(int range);
void GetInput();
void TappedFlake();
void FlakeMissed(int flake_number);
void FlakeReset(int flake_number);
void DrawSnowFall();
void ShowGameOver();
void ShowTitles();
void InitGame();
void SavePrevValues();
void RenderScore();
void ClearFlake();
void RenderScreen();
void MoveFlakes();
void ToggleMute();

struct sprite {
 int x;
 int y;
 int prev_x;
 int prev_y;
 int frame;
 int scale;
 int width;
 int height;
 int speed;
};


struct clear_region{
 int top;
 int left;
 int bottom;
 int right;
};


struct clear_region clear_up_down_flake;

struct sprite flakes[ 3 ];



int sky_color = 0x0928;


void main() {

 int i = 0;
 int flake_size = 0;



 Start_TP();


 Start_UART();


 Init_Sprites();


 TFT_Fill_Screen(sky_color);


 file_loaded = 0;
 MP3_Start();


 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);





 UART1_Write_Line("Starting Snowburst.");

 TP_TFT_Press_Detect();
 TP_TFT_Press_Detect();

 while (1){

 TFT_Fill_Screen(sky_color);


 ShowTitles();


 InitGame();

 while (!game_over) {


 if( (frame_counter % 20) == 0){
 UART1_Write_Label_Long_Var("Frame: ", frame_counter);
 }



 if(play_next_song){

 GetNextSong();
 }
 else if( (frame_counter % 2) == 0){

 Play_MP3_Chunk();
 }



 GetInput();


 MoveFlakes();


 TappedFlake();


 ClearFlake();


 RenderScreen();


 if(muteSound){
 Delay_ms(25);
 }


 SavePrevValues();
 }


 ShowGameOver();
 }

}


void MoveFlakes(){
 int i = 0;

 for(i=0;i<=( 3 -1); i++){

 flakes[i].y += flakes[i].speed;


 if( (long)(flakes[i].y+flakes[i].height+flakes[i].speed) > (long)(240-snow_height- 25 )){

 flakeMissed(i);

 }

 }
}


void Start_UART(){


 UART1_Init(256000);
 Delay_ms(100);
}


void RenderScreen(){
 int i = 0;

 for(i=0;i<=( 3 -1); i++){

 DrawFlake(flakes[i].frame, flakes[i].x, flakes[i].y, flakes[i].scale);


 flakes[i].frame++;

 if(flakes[i].frame > 13){
 flakes[i].frame = 1;
 }
 }


 DrawSnowFall();


 RenderScore();

}

void InitGame(){

 score = 0;

 prev_score = 0;


 snow_height = 0;


 game_over = 0;
}

void FlakeReset(int flake_number){
 int offset = 0;
 int top_clear_flake_pos = 0;

 int small_speed_boost = 0;
 int large_speed_boost = 0;



 if(score > 20000){
 small_speed_boost = 2;
 large_speed_boost = 1;
 }
 else if(score > 10000){
 small_speed_boost = 2;
 }
 else if(score > 5000){
 small_speed_boost = 1;
 }
 else{
 small_speed_boost = 0;
 large_speed_boost = 0;
 }




 TFT_Set_Pen(sky_color, 1);


 TFT_Set_Brush(1, sky_color, 0, TOP_TO_BOTTOM, sky_color, sky_color);





 top_clear_flake_pos = flakes[flake_number].y-flakes[flake_number].speed;
 if(top_clear_flake_pos < 0){
 top_clear_flake_pos = 0;
 }


 TFT_Rectangle(flakes[flake_number].x,top_clear_flake_pos, flakes[flake_number].x+flakes[flake_number].width, flakes[flake_number].y+flakes[flake_number].height);


 flakes[flake_number].x = ((320 + 32)/  3 ) * flake_number + ( getRandom(120) - 60);


 if( flakes[flake_number].x < 0){
 flakes[flake_number].x = 0;
 }
 if( flakes[flake_number].x > 290){
 flakes[flake_number].x = 290;
 }


 flakes[flake_number].y = 0;

 flakes[flake_number].prev_x = flakes[flake_number].x;
 flakes[flake_number].prev_y = flakes[flake_number].y;


 flakes[flake_number].frame = getRandom(13);



 flakes[flake_number].scale = getRandom(2);


 if(flakes[flake_number].scale == 1){
 flakes[flake_number].width = 32;
 flakes[flake_number].height = 32;
 }
 else{
 flakes[flake_number].width = 64;
 flakes[flake_number].height = 64;
 }








 if (flakes[flake_number].scale == 1){

 flakes[flake_number].speed = getRandom(4)+small_speed_boost;
 }
 else{

 flakes[flake_number].speed = getRandom(3)+large_speed_boost;
 }

}


void SavePrevValues(){
 int i;


 frame_counter++;


 prev_snow_height = snow_height;


 prev_score = score;



 prev_muteSound = muteSound;


 for(i=0;i<=( 3 -1);i++){
 flakes[i].prev_x = flakes[i].x;
 flakes[i].prev_y = flakes[i].y;
 }
}

void FlakeMissed(int flake_number)
{


 if(flakes[flake_number].scale == 1){


 if(snow_height > 120){

 snow_height+=3;
 }
 else{

 snow_height+=7;
 }

 }

 else if(flakes[flake_number].scale ==2){

 if(snow_height > 120){

 snow_height+=7;
 }
 else{

 snow_height+=15;
 }

 }

 FlakeReset(flake_number);

}


void TappedFlake(){
 int i;

 int tapped_flake_size = 0;



 if( Pen_Down && (abs(X_Drag_Distance) < 10) ){


 for(i=0;i< 3 ;i++){


 if(IsCollision (X_Coord- 15 , Y_Coord- 15 ,  15 *2,  15 *2, flakes[i].x, flakes[i].y, flakes[i].width, flakes[i].height) ){


 if(flakes[i].scale == 1){

 score+= 50;
 }
 else {

 score+= 25;
 }




 FlakeReset(i);

 }

 }

 }

}


void DrawFlake(int frame, int x, int y, int scale){

 switch (frame) {
 case 0:
 TFT_Image(x, y, snowflake1_bmp, scale);
 break;

 case 1:
 TFT_Image(x, y, snowflake1_bmp, scale);
 break;

 case 2:
 TFT_Image(x, y, snowflake2_bmp, scale);
 break;

 case 3:
 TFT_Image(x, y, snowflake3_bmp, scale);
 break;

 case 4:
 TFT_Image(x, y, snowflake4_bmp, scale);
 break;

 case 5:
 TFT_Image(x, y, snowflake5_bmp, scale);
 break;

 case 6:
 TFT_Image(x, y, snowflake6_bmp, scale);
 break;

 case 7:
 TFT_Image(x, y, snowflake7_bmp, scale);
 break;

 case 8:
 TFT_Image(x, y, snowflake8_bmp, scale);
 break;

 case 9:
 TFT_Image(x, y, snowflake9_bmp, scale);
 break;

 case 10:
 TFT_Image(x, y, snowflake10_bmp, scale);
 break;

 case 11:
 TFT_Image(x, y, snowflake11_bmp, scale);
 break;

 case 12:
 TFT_Image(x, y, snowflake12_bmp, scale);
 break;

 case 13:
 TFT_Image(x, y, snowflake13_bmp, scale);
 break;

 case 14:
 TFT_Image(x, y, snowflake14_bmp, scale);
 break;

 default:
 TFT_Image(x, y, snowflake1_bmp, scale);

 }


}





void Init_Sprites(){
 int random_x = 0;
 int i = 0;

 for(i=0;i<=( 3 -1);i++){



 flakes[i].x = ((320 + 32)/  3 ) * i + getRandom(32);
 flakes[i].y = getRandom(5) * 48;


 flakes[i].prev_x = flakes[i].x;
 flakes[i].prev_y = flakes[i].y;



 flakes[i].frame = getRandom(13);



 flakes[i].scale = getRandom(2);


 if(flakes[i].scale == 1){
 flakes[i].width = 32;
 flakes[i].height = 32;
 }
 else{
 flakes[i].width = 64;
 flakes[i].height = 64;
 }



 flakes[i].speed = getRandom(4);


 }

}


void DrawSnowFall(){

 long screen_snow_height = 0;
 long prev_screen_snow_height = 0;


 if(snow_height > (long)(240-64- 25 )){
 game_over = 1;
 }

 if( (prev_muteSound != muteSound) || (snow_height != prev_snow_height) || (score != prev_score) || (frame_counter < 1) ){


 if( ((score % (long)500) == 0) && (score>(long)50)){




 if (snow_height>64){

 snow_height-=50;
 }
 else{

 snow_height-=7;
 }




 UART1_Write_Line("You lowered the snowbank.");


 if(snow_height<0){
 snow_height=0;
 }

 screen_snow_height = (long)240-snow_height- 25 ;
 prev_screen_snow_height = (long)240-prev_snow_height- 25 ;




 if(screen_snow_height<0){
 screen_snow_height=0;
 }


 if(prev_screen_snow_height<0){
 prev_screen_snow_height=0;
 }


 TFT_Set_Pen(sky_color, 1);


 TFT_Set_Brush(1, sky_color, 0, TOP_TO_BOTTOM, sky_color, sky_color);


 TFT_Rectangle(0, prev_screen_snow_height,  320 , screen_snow_height);



 }




 TFT_Set_Pen(0, 0);





 TFT_Set_Brush(1, 0, 1, TOP_TO_BOTTOM, CL_WHITE, CL_GRAY);





 TFT_Rectangle(0, 240-snow_height- 25 , 319, 240);

 }
}



int GetRandom(int range){
 return (rand() % range) + 1;
}



void GetInput(){

 if(TP_TFT_Press_Detect()){

 if (TP_TFT_Get_Coordinates(&X_Coord, &Y_Coord) == 0) {


 if(Pen_Down == 0){
 Starting_Pen_Down_X_Coord = X_Coord;
 Starting_Pen_Down_Y_Coord = Y_Coord;


 }

 X_Drag_Distance = Starting_Pen_Down_X_Coord - X_Coord;


 Pen_Down = 1;

 }

 }
 else{

 Pen_Down = 0;
 }


 if( (Pen_Down == 1 )&& (Y_coord > ( 240 - 25 )) ) {

 ToggleMute();
 Delay_ms(500);
 }

}



void ClearFlake(){
 int i = 0;

 for(i=0;i<=( 3 -1);i++){










 clear_up_down_flake.left = flakes[i].x;
 clear_up_down_flake.top = flakes[i].prev_y;
 clear_up_down_flake.right = flakes[i].x + flakes[i].width;

 clear_up_down_flake.bottom = flakes[i].y;



 if (clear_up_down_flake.left < 0) {
 clear_up_down_flake.left = 0;
 }
 if (clear_up_down_flake.top < 0) {
 clear_up_down_flake.top = 0;
 }
 if (clear_up_down_flake.right < 0) {
 clear_up_down_flake.right = 0;
 }
 if (clear_up_down_flake.bottom < 0) {
 clear_up_down_flake.bottom = 0;
 }


 TFT_Set_Pen(sky_color, 1);


 TFT_Set_Brush(1, sky_color, 0, TOP_TO_BOTTOM, sky_color, sky_color);
#line 854 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/snowburst_main.c"
 if( clear_up_down_flake.bottom > clear_up_down_flake.top){

 TFT_Rectangle(clear_up_down_flake.left, clear_up_down_flake.top, clear_up_down_flake.right, clear_up_down_flake.bottom);
 }
 }
}





void ToggleMute(){

 if(muteSound){
 muteSound = 0;
 UART1_Write_Line("Sound On");
 }
 else if(!muteSound){

 muteSound = 1;
 UART1_Write_Line("Muting Sound");
 }

}



void PreRollSong(){
 int roll = 0;
 int roll_max = 100;


 for(roll = 0; roll<=roll_max;roll++){
 Play_MP3_Chunk();
 }
}


void GetNextSong(){
 UART1_Write_Line("Switching to the next song.");

 Load_MP3_File("tff.mp3");


 if(current_pos < 5){
 PreRollSong();
 }

}




void RenderScore(){


 if(muteSound){


 TFT_Write_Text("Tap bar to enable music.", 10, 240- 25 +3);
 }
 else if(!muteSound){


 TFT_Write_Text("Tap bar to mute music.", 10, 240- 25 +3);
 }






 LongToStr(score, score_text);


 TFT_Set_Font(TFT_defaultFont, sky_color, FO_HORIZONTAL);


 strcpy(score_display_text, "Score: ");
 strcat(score_display_text, score_text);



 TFT_Write_Text(score_display_text, 200, 240- 25 +3);
}


void ShowTitles(){
 int loop = 0;


 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);


 TFT_Fill_Screen(sky_color);


 TFT_Image(32, 50, title_bmp, 1);

 TFT_Write_Text("Tap    to    melt    the    snowflakes.", 60, 140);

 TFT_Write_Text("Created   By   Andrew   Hazelden   (c) 2011-2012", 20, 220);

 GetNextSong();








 if(muteSound){
 Delay_ms(4000);
 }


 TFT_Fill_Screen(sky_color);

}

void ShowGameOver(){
 int loop = 0;

 UART1_Write_Line("Game Over");


 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);


 TFT_Fill_Screen(sky_color);


 TFT_Image(32, 50, GameOver_bmp, 1);



 if(score > high_score){

 high_score = score;
 TFT_Write_Text("You  set  a  High  Score!", 95, 140);
 }
 else{



 LongWordToStr(high_score, score_text);
 strcpy(score_display_text, "High  Score: ");
 strcat(score_display_text, score_text);


 TFT_Write_Text(score_display_text, 110, 140);
 }


 LongWordToStr(score, score_text);
 strcpy(score_display_text, "Your  Score: ");
 strcat(score_display_text, score_text);


 TFT_Write_Text(score_display_text, 110, 170);


 UART1_Write_Line(score_display_text);

 TFT_Write_Text("Tip:   Melt   the   small   snowflakes   first!", 45, 215);


 for(loop = 0; loop<=60;loop++){
 Play_MP3_Chunk();
 Delay_ms(50);

 if(muteSound){
 Delay_ms(20);
 }

 }




 TFT_Fill_Screen(sky_color);

}
