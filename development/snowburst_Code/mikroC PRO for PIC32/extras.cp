#line 1 "C:/Users/dsi/Desktop/Snowburst/Development/snowburst_Code/mikroC PRO for PIC32/extras.c"




char IsCollision (unsigned int Shape_X, unsigned int Shape_Y, unsigned int Shape_Width, unsigned int Shape_Height,
unsigned int Button_Left, unsigned int Button_Top, unsigned int Button_Width, unsigned int Button_Height) {



 if( ((Shape_X + Shape_Width) >= Button_Left ) && ((Shape_X) <= (Button_Left + Button_Width-1)) &&




 ((Shape_Y + Shape_Height) >= Button_Top ) && ((Shape_Y) <= (Button_Top + Button_Height-1)) ) {






 return 1;
 }
 else
 {


 return 0;
 }

}


void UART1_Write_Line(char *uart_text) {
 UART1_Write_Text(uart_text);
 UART1_Write(13);
 UART1_Write(10);
}



void UART1_Write_Variable(int var) {
 char var_txt[12];
 IntToStr(var, var_txt);
 UART1_Write_Text(var_txt);
 UART1_Write(13);
 UART1_Write(10);
}


void UART1_Write_Long_Variable(long var){
 char var_txt[20];
 LongToStr(var, var_txt);
 UART1_Write_Text(var_txt);
 UART1_Write(13);
 UART1_Write(10);
}


void UART1_Write_Label_Var(char *uart_text, int var ) {
 char var_txt[12];

 UART1_Write_Text(uart_text);
 IntToStr(var, var_txt);
 UART1_Write_Text(var_txt);
 UART1_Write(13);
 UART1_Write(10);
}



void UART1_Write_Label_Long_Var(char *uart_text, long var){
 char var_txt[20];

 UART1_Write_Text(uart_text);
 LongToStr(var, var_txt);
 UART1_Write_Text(var_txt);
 UART1_Write(13);
 UART1_Write(10);
}


void UART1_Write_Label_Float_Var(char *uart_text, float var){
 char var_txt[20];

 UART1_Write_Text(uart_text);
 FloatToStr(var, var_txt);
 UART1_Write_Text(var_txt);
 UART1_Write(13);
 UART1_Write(10);
}
