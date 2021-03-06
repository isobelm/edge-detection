class Widget {
  int x, y, width, height;
  String label;
  int event;
  color widgetColor, labelColour, hoverColour;
  PFont widgetFont;

  Widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event)
  {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.event = event; 
    this.widgetColor = widgetColor;
    this.widgetFont = widgetFont;
    labelColour = color(0);
    hoverColour = color(255);
   }
   
   void setFontColour(color colour)
   {
     labelColour = colour;
   }
   
  void draw(){
    if (getEvent(mouseX, mouseY) == event)
    {
      fill(hoverColour);
    }
    else
    {
      fill(widgetColor);
    }
    textAlign(CENTER, CENTER);
    rect(x, y, width, height);
    fill(labelColour);
    text(label, x + width / 2, y + height / 2 - 3);
  }
  

  Widget(int x, int y, String label, PFont widgetFont, int event)
  {
    this.x = x;
    this.y = y;
    this.label = label;
    this.event = event; 
    this.widgetFont = widgetFont;
  }
  
  int getEvent(int mX, int mY){
     if(mX > x && mX < x + width && mY > y && mY < y + height){
        return event;
     }
     return EVENT_NULL;
  }
}
