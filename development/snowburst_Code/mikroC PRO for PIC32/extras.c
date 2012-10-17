//Extra functions


//Check for a sprite to mine collision
char IsCollision (unsigned int Shape_X, unsigned int Shape_Y,  unsigned int Shape_Width, unsigned int Shape_Height,
unsigned int Button_Left, unsigned int Button_Top, unsigned int Button_Width, unsigned int Button_Height) {
  
  //Check for touch based button presses
  //The right side of Shape is greater than left side of Button     and        left side of Shape is smaller than right side of Button
  if( ((Shape_X + Shape_Width) >= Button_Left )               &&              ((Shape_X) <= (Button_Left + Button_Width-1)) &&


      //Check for top and bottom collisions
      //The bottom side of Shape is greater than top of Button         and            top of Shape is smaller then bottom of Button
      ((Shape_Y + Shape_Height) >= Button_Top )                   &&               ((Shape_Y) <= (Button_Top + Button_Height-1))  ) {


    //Debug printing
    //UART1_Write_Line("Collision detected");

    //A collision has been detected
    return 1;
  }
  else
  {
    //Default return value
    //No collisions have been detected
    return 0;
  }
  
}

//UART1 write text and new line (carriage return + line feed)
void UART1_Write_Line(char *uart_text) {
  UART1_Write_Text(uart_text);
  UART1_Write(13);
  UART1_Write(10);
}


//UART1 write integer variable and new line (carriage return + line feed)
void UART1_Write_Variable(int var) {
  char var_txt[12];
  IntToStr(var, var_txt);
  UART1_Write_Text(var_txt);
  UART1_Write(13);
  UART1_Write(10);
}

//UART1 write long variable and new line (carriage return + line feed)
void UART1_Write_Long_Variable(long var){
  char var_txt[20];
  LongToStr(var, var_txt);
  UART1_Write_Text(var_txt);
  UART1_Write(13);
  UART1_Write(10);
}

//UART1 write label and variable (carriage return + line feed)
void UART1_Write_Label_Var(char *uart_text, int var ) {
  char var_txt[12];

  UART1_Write_Text(uart_text);
  IntToStr(var, var_txt);
  UART1_Write_Text(var_txt);
  UART1_Write(13);
  UART1_Write(10);
}


//UART1 write label and long variable (carriage return + line feed)
void UART1_Write_Label_Long_Var(char *uart_text, long var){
  char var_txt[20];

  UART1_Write_Text(uart_text);
  LongToStr(var, var_txt);
  UART1_Write_Text(var_txt);
  UART1_Write(13);
  UART1_Write(10);
}

//UART1 write label and float variable (carriage return + line feed)
void UART1_Write_Label_Float_Var(char *uart_text, float var){
  char var_txt[20];

  UART1_Write_Text(uart_text);
  FloatToStr(var, var_txt);
  UART1_Write_Text(var_txt);
  UART1_Write(13);
  UART1_Write(10);
}
