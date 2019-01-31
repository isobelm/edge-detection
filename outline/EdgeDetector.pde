class EdgeDetector
{
  
  EdgeDetector(PImage img)
  {
    this.img = img; 
    threshhold = 30;
    dist = 2;
  }
  
  static final int MAX_COLOUR = 0xFF;
  static final int BLACK = 0xFF000000;
  static final int WHITE = 0xFFFFFFFF;
  PImage img;
  int threshhold;  // edge threshold
  int dist;      //distance between pixels being checked

  PImage detectEdges()
  {
    img.loadPixels();
    noFill();
    noStroke();
    colorMode(RGB);
    
    // set up output image and pixel colour channels.
    
    PImage newImg = createImage(img.width, img.height, RGB);
    int r;
    int g;
    int b;
    int rHorizontal;
    int gHorizontal;
    int bHorizontal;
    int rVertical;
    int gVertical;
    int bVertical;
    int width = img.width;
    int height = img.height;
    
    
    // for every pixel dist away form the edge of the image
    
    for (int currentPixel = 0; currentPixel < (width * height) - (width * dist) - 1; currentPixel++)
    {
      // load colour channels for the current pixel and the pixels dist below and to the right from them
      
      b = getBlueValue(img.pixels[currentPixel]);
      g = getGreenValue(img.pixels[currentPixel]);
      r = getRedValue(img.pixels[currentPixel]);
      bHorizontal = getBlueValue(img.pixels[currentPixel+dist]);
      gHorizontal = getGreenValue(img.pixels[currentPixel+dist]);
      rHorizontal = getRedValue(img.pixels[currentPixel+dist]);
      bVertical = getBlueValue(img.pixels[currentPixel + width * dist]);
      gVertical = getGreenValue(img.pixels[currentPixel + width * dist]);
      rVertical = getRedValue(img.pixels[currentPixel + width * dist]);
      
      //initialise each pixel
      
      newImg.pixels[currentPixel] = WHITE;
      
      //if the pixel is more than THRESHOLD different from either the pixel dist above or dist below it in any colour, colour the pixel black.
      
      if ((Math.abs(r - rHorizontal) > threshhold) || (Math.abs(r - rVertical) > threshhold) || (Math.abs(g - gHorizontal) > threshhold) || (Math.abs(g - gVertical) > threshhold) 
      || (Math.abs(b - bHorizontal) > threshhold) || (Math.abs(b - bVertical) > threshhold))
      {
        newImg.pixels[currentPixel] = BLACK;
      }
    }
    
    return newImg;
  }
  
  void increaseThreshhold()
  {
    threshhold += 5;
  }
  
  void decreaseThreshhold()
  {
    threshhold -= 5;
  }
  
  void increaseDist()
  {
    ++dist;
  }
  
  void decreaseDist()
  {
    --dist;
  }
  
}
