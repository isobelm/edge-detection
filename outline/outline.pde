/*
Basic edge detection
*/

final int MAX_COLOUR = 255;
int dispWidth = 100;
int dispHeight = 100;
PImage img;
final int THRESHHOLD = 30;
final int DIST = 2;

void settings()
{
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
  PImage newImg = createImage(img.width, img.height, RGB);
  int r;
  int g;
  int b;
  int rh;
  int gh;
  int bh;
  int rv;
  int gv;
  int bv;
  for (int i = 1; i < (width * height) - (width * 2); i++)
  {
    b = getBlueValue(img.pixels[i]);
    g = getGreenValue(img.pixels[i]);
    r = getRedValue(img.pixels[i]);
    bh = getBlueValue(img.pixels[i+DIST]);
    gh = getGreenValue(img.pixels[i+DIST]);
    rh = getRedValue(img.pixels[i+DIST]);
    bv = getBlueValue(img.pixels[i + width * DIST]);
    gv = getGreenValue(img.pixels[i + width * DIST]);
    rv = getRedValue(img.pixels[i + width * DIST]);
    newImg.pixels[i] = -1;
    if ((Math.abs(r - rh) > THRESHHOLD) || (Math.abs(r - rv) > THRESHHOLD) || (Math.abs(g - gh) > THRESHHOLD) || (Math.abs(g - gv) > THRESHHOLD) || (Math.abs(b - bh) > THRESHHOLD)
    || (Math.abs(b - bv) > THRESHHOLD))
    {
      newImg.pixels[i] = -16777216;
    }
  }
  newImg.updatePixels();
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