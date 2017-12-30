/*
Basic edge detection
author: Isobel Mahon
date: 25/12/17
*/

final int MAX_COLOUR = 255;
final int BLACK = -16777216;
final int WHITE = -1;
int dispWidth = 100;
int dispHeight = 100;
PImage img;
final int THRESHHOLD = 30;  // edge threshold
final int DIST = 2;      //distance between pixels being checked

void settings()
{
  //set up output window
  
  img = loadImage("input.jpg");
  dispWidth = img.width;
  dispHeight = img.height;
  size (dispWidth, dispHeight);
}

void setup()
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
  
  // for every pixel DIST away form the edge of the image
  
  for (int currentPixel = 0; currentPixel < (width * height) - (width * 2); currentPixel++)
  {
    // load colour channels for the current pixel and the pixels DIST below and to the right from them
    
    b = getBlueValue(img.pixels[currentPixel]);
    g = getGreenValue(img.pixels[currentPixel]);
    r = getRedValue(img.pixels[currentPixel]);
    bHorizontal = getBlueValue(img.pixels[currentPixel+DIST]);
    gHorizontal = getGreenValue(img.pixels[currentPixel+DIST]);
    rHorizontal = getRedValue(img.pixels[currentPixel+DIST]);
    bVertical = getBlueValue(img.pixels[currentPixel + width * DIST]);
    gVertical = getGreenValue(img.pixels[currentPixel + width * DIST]);
    rVertical = getRedValue(img.pixels[currentPixel + width * DIST]);
    
    //initialise each pixel
    
    newImg.pixels[currentPixel] = WHITE;
    
    //if the pixel is more than THRESHOLD different from either the pixel DIST above or DIST below it in any colour, colour the pixel black.
    
    if ((Math.abs(r - rHorizontal) > THRESHHOLD) || (Math.abs(r - rVertical) > THRESHHOLD) || (Math.abs(g - gHorizontal) > THRESHHOLD) || (Math.abs(g - gVertical) > THRESHHOLD) 
    || (Math.abs(b - bHorizontal) > THRESHHOLD) || (Math.abs(b - bVertical) > THRESHHOLD))
    {
      newImg.pixels[currentPixel] = BLACK;
    }
  }
  image (newImg, 0, 0);
  save("output.jpg");
}

int getRedValue(int colour)
{
  return ((-colour) / 256 / 256) % 256;
}

int getGreenValue(int colour)
{
  return ((-colour) / 256) % 256;
}

int getBlueValue(int colour)
{
  return (-colour) % 256;
}
