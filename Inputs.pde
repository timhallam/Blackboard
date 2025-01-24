

void mouseClicked()
{
  if (playmode > 0) return;
  if (!menu.mouseIn(true))
  {
    ArrayList<Dot> dots = new ArrayList<Dot>();
    for (int n = 0; n < 5; n ++) dots.add(new Dot(mouseX, mouseY));
    board.addDots(dots);
  }
}

void mouseDragged()
{
  float d = dist(pmouseX, pmouseY, mouseX, mouseY);
  ArrayList<Dot> dots = new ArrayList<Dot>();
  for (float t = 0.0; t < d; t += 1.0)
  {
    float dotx = map(t, 0.0, d, pmouseX, mouseX);
    float doty = map(t, 0.0, d, pmouseY, mouseY);
    dots.add(new Dot(dotx, doty));
  }
  board.addDots(dots);
}

void mouseMoved()
{
  board.newline = true;
}

void keyPressed()
{
  char k = key;
  if (k == 'r' || k == 'R')
  {
    background(bg);
    playmode = 1;
  }
  
  else if (k == 1 || (k == 19 && filename == null)) // Ctrl-A or Ctrl-S when no filename
  {
    selectOutput("Save as", "saveJSONAs");
  }
  
  else if (k == 19) // Ctrl-S
  {
    saveJSON();
  }
  
  else if (k == 15) // Ctrl-O
  {
    selectInput("Open", "openJSON");
  }
  
  else if (k == 16) // Ctrl-P
  {
    selectOutput("Save still", "savePNGAs");
  }
  
  else if (k == 18) // Ctrl-R
  {
    playmode = 2;
    background(bg);
    File folder = new File(sketchPath() + File.separator + "data");
    File[] files = folder.listFiles();
    if (files != null)
    {
      for (int n = 0; n < files.length; n ++) files[n].delete();
      delay(1000); // wait for files to be deleted
    }
  }
  
  else if (k == 26) // Ctrl-Z
  {
    board.undo();
  }
  
  else if (k == 14) // Ctrl-N
  {
    board = new Board();
    filename = null;
  }
  
  
  
  
  
}
