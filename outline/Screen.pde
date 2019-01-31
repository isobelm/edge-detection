final int STRIPE_WIDTH = 20;

class Screen
{
  ArrayList<Widget> widgetList;
  color background;
  color stripeColour;
  boolean stripes;
  
  
  Screen(color background)
  {
    this.background = background;
    widgetList = new ArrayList<Widget>();
    stripes = false;
  }
  
  void setStripeColour(color stripeColour)
  {
    this.stripeColour = stripeColour;
  }
  
  void draw()
  {
    background(background);
    if (stripes)
    {
      for (int i = 0; i < height; i += 2 * STRIPE_WIDTH)
      {
        noStroke();
        fill(stripeColour);
        rect(0, i, width, STRIPE_WIDTH);
        stroke(1);
      }
    }
    for(int i = 0; i < widgetList.size(); i++)
    {
      Widget aWidget = (Widget)widgetList.get(i);
      aWidget.draw();
    }
  }
  
  void setBackground(color background)
  {
    this.background = background;
  }
  
  void addWidget(Widget newWidget)
  {
    if (newWidget == null)
    {
      print("null");
    }
    else
    {
      widgetList.add(newWidget);
    }
  }
  
  int getEvent()
  {
    int event = 0;
    for(int i = 0; i < widgetList.size(); i++)
    {
      event = widgetList.get(i).getEvent(mouseX, mouseY);
      if (event != 0)
      {
        return event;
      }
    }
    return event;
  }
  
  void onOffStripes()
  {
    stripes = stripes? false : true;
  }
}
