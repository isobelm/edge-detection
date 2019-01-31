class Colour
{
  Colour()
  {}
  
  private int colourResolution = 0x80;
  
  void setColourResolution(int resolution)
  {
    colourResolution = resolution;
  }
  
  int getColourResolution()
  {
    return colourResolution;
  }
  
  PImage colour(PImage img)
  {
    PImage result = createImage(img.width, img.height, RGB);
    
    for (int i = 0; i < img.width * img.height; i++)
    {
      int colour = img.pixels[i];
      int r = getRedValue(colour);
      int g = getGreenValue(colour);
      int b = getBlueValue(colour);
      int ave = (r + g + b) / 3;
      if (ave % colourResolution < colourResolution / 2) colour = (ave / colourResolution) * colourResolution;
      else colour = (ave / colourResolution + 1) * colourResolution;
      if (colour > 0xFF) colour = 0xFF;
      colour = (colour) + (colour << 8) + (colour << 16) + 0xFF000000;
      result.pixels[i] = colour;
    }
    
    return result;
  }
}
