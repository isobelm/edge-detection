int getRedValue(int colour)
  {
    int red = colour & 0x00FF0000;
    red = red >> 16;
    return red;
  }
  
  int getGreenValue(int colour)
  {
    int green = colour & 0x0000FF00;
    green = green >> 8;
    return green;
    }
  
  int getBlueValue(int colour)
  {
    int blue = colour & 0x000000FF;
    return blue;
  }
