

class Menu
{
  // variables
  
  ArrayList<Button> buttons;
  int buttonsize;
  color[] palette;
  int[] sizes;
  color opac;
  
  // constructor
  
  Menu()
  {
    buttons = new ArrayList<Button>();
    buttonsize = 40;
    opac = 80;
    
    palette = new color[]{
      color(0, 0, 0, opac),
      color(80, 80, 80, opac),
      color(255, 255, 255, opac),
      color(255, 0, 0, opac),
      color(255, 150, 0, opac),
      color(255, 255, 0, opac),
      color(0, 255, 0, opac),
      color(0, 0, 255, opac),
      color(255, 0, 255, opac)};
    gcol = palette[4];
    sizes = new int[]{5, 10, 15, 20};
    gsize = sizes[1];
    
    for (int n = 0; n < palette.length; n ++)
    {
      buttons.add(new ColButton(buttons.size() * (buttonsize - 1), palette[n]));
    }
    for (int n = 0; n < sizes.length; n ++)
    {
      buttons.add(new SizeButton(buttons.size() * (buttonsize - 1), sizes[n]));
    }
  }
  
  // methods
  
  void render()
  {
    for (Button button : buttons) button.render();
  }
  
  boolean mouseIn(boolean doclick)
  {
    for (Button button : buttons)
    {
      if (button.mouseIn(doclick)) return true;
    }
    return false;
  }
  
  // subclasses
  
  class Button
  {
    // variables
    
    int x, y;
    PGraphics img;
    
    // constructor
    
    Button(int y)
    {
      x = width - buttonsize;
      this.y = y;
      img = createGraphics(buttonsize, buttonsize);
    }
    
    // methods
    
    void render()
    {
      image(img, x, y);
    }
    
    void click()
    {
      // placeholder for the kids
    }
    
    void makeIcon()
    {
      // another placeholder
    }
    
    boolean mouseIn(boolean doclick)
    {
      boolean out = mouseX > x && mouseX < x + buttonsize && mouseY > y && mouseY < y + buttonsize;
      if (out && doclick) click();
      return out;
    }
  }
  
  class ColButton extends Button
  {
    // variables
    
    color col;
    
    // constructor
    
    ColButton(int y, color col)
    {
      super(y);
      this.col = col;
      makeIcon();
    }
    
    // methods
    
    void makeIcon()
    {
      img.beginDraw();
      img.ellipseMode(CENTER);
      img.fill(0);
      img.stroke(64);
      img.rect(0, 0, buttonsize - 1, buttonsize - 1);
      img.fill(col);
      if (col != palette[0]) img.noStroke();
      for (int n = 0; n < 5; n ++) img.ellipse(buttonsize / 2, buttonsize / 2, gsize, gsize);
      img.endDraw();
    }
    
    void click()
    {
      gcol = col;
    }
  }
  
  class SizeButton extends Button
  {
    // variables
    
    int size;
    
    // constructor
    
    SizeButton(int y, int size)
    {
      super(y);
      this.size = size;
      makeIcon();
    }
    
    // methods
    
    void makeIcon()
    {
      img.beginDraw();
      img.ellipseMode(CENTER);
      img.fill(0);
      img.stroke(64);
      img.rect(0, 0, buttonsize - 1, buttonsize - 1);
      img.fill(gcol);
      if (gcol != palette[0]) img.noStroke();
      for (int n = (size / 2) + 2; n < buttonsize - (size / 2) - 2; n ++)
      {
        for (int i = 0; i < 5; i ++) img.ellipse(n, n, size, size);
      }
      img.endDraw();
    }
    
    void click()
    {
      gsize = size;
    }
  }
}
