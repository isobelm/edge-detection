import drop.*;
SDrop drop;

PImage img;
PImage out;
PFont font;

final int EVENT_NULL = 0, NEXT_BUTTON = 1, BACK_BUTTON = 2, THRESHHOLD_EVENT = 3;

final int THRESHHOLD = 0, DIST = 1, CREATE_SCREEN = 2, SAVE_SCREEN = 3;

color background;
color grey;
EdgeDetector edgeDetector;
Screen[] screens;
int currentScreen;
boolean preview;
boolean drawn;

void setup()
{
  size(600, 400);
  background(40, 50, 44);
  font = createFont("Arial", 18);
  textFont(font);
  background = color(40, 50, 44);
  grey = color(200, 200, 200);
  textAlign(CENTER, CENTER);
  fill(200, 200, 200);
  noStroke();
  pixelDensity(2);
  drop = new SDrop(this);
  initialiseScreens();
  preview = false;
  drawn = false;
}


void draw()
{
  if (preview)
  {
    if (!drawn)
    {
      float ratioH = out.height / height;
      float ratioW = out.width / width;
      float ratioM = max(ratioH, ratioW);
      image(out, 0, 0, out.width / ratioM, out.height / ratioM);
      drawn = true;
    }
  }
  else
  {
    if (img == null)
    {
      background(40, 50, 44);
      text("Drop image here to start.", 300, 200);
    }
    else
    {
      if (currentScreen != SAVE_SCREEN)  screens[currentScreen].draw();
      String  text = "";
      switch(currentScreen)
      {
        case THRESHHOLD:
        //edgeDetector.threshhold = 30;
          text = "Threshhold: " + edgeDetector.threshhold;
          break;
        case DIST:
          text = "Distance: " + edgeDetector.dist;
          break;
        case CREATE_SCREEN:
          create();
          currentScreen++;
          break;
        default:
          break;
      }
      fill(200, 200, 200);
      text(text, 300, 200);
    }
  }

}

void initialiseScreens()
{
  screens = new Screen[4];
  screens[THRESHHOLD] = new Screen(background);
  screens[DIST] = new Screen(background);
  screens[CREATE_SCREEN] = new Screen(background);
  screens[SAVE_SCREEN] = new Screen(background);
  currentScreen = 0;

  Widget next = new Widget(520, 360, 60, 20, "Next", grey, font, NEXT_BUTTON);
  Widget back = new Widget(20, 360, 60, 20, "Back", grey, font, BACK_BUTTON);
  next.setFontColour(background);
  back.setFontColour(background);
  for(int i = 0; i < screens.length; i++)
  {
    screens[i].addWidget(next);
    screens[i].addWidget(back);
  }
  initialiseThreshholdScreen(screens[THRESHHOLD]);
}

void initialiseThreshholdScreen(Screen screen)
{
}

void mouseReleased(){
  int event;
  event = screens[currentScreen].getEvent();
  switch(event) 
  {
    case NEXT_BUTTON:
      if (currentScreen < screens.length - 1)
      {
        currentScreen++;
      }
      break;
    case BACK_BUTTON:
      if (currentScreen > 0)
      {
        currentScreen--;
      }
      break;
    default:
    break;
  }  
} //<>//

void keyReleased() //<>//
{
  if (key == CODED) //<>//
  {
    if (keyCode == UP) //<>//
    {
      if (currentScreen == THRESHHOLD) edgeDetector.increaseThreshhold();
      else if (currentScreen == DIST)edgeDetector.increaseDist(); //<>//
    }
    else if (keyCode == DOWN)
    { //<>//
      if (currentScreen == THRESHHOLD) edgeDetector.decreaseThreshhold();
      else if (currentScreen == DIST) edgeDetector.decreaseDist(); //<>//
    }
    else if (keyCode == LEFT)
    {
      if (currentScreen > 0)
          currentScreen--;
    }
    else if (keyCode == RIGHT)
    {
      if (out == null)
      {
        currentScreen++;
      }
      else
      {
        preview = false;
        drawn = false;
        out = null;
        currentScreen = 0;
      }
    } //<>// //<>//
  }
  if (key == RETURN || key == ENTER)
  {
    if (out == null)
      {
        currentScreen++;
      }
      else
      {
        preview = false;
        drawn = false;
        out = null;
        currentScreen = 0;
      }
  }
}
  
void create()
{
  out = edgeDetector.detectEdges();
  String path = "/Users/isobelmahon/Desktop/";
  String outputName = path + "edge_detector_output-" + edgeDetector.threshhold + "-" + edgeDetector.dist + ".png";
  out.save(outputName);
  //currentScreen = 0;
  img = null;
  preview = true;
  
}

void dropEvent(DropEvent theDropEvent) 
{
  if(theDropEvent.isImage()) 
  {
    img = theDropEvent.loadImage();
    edgeDetector = new EdgeDetector(img);
  }
}
