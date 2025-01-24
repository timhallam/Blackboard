

class Board
{
  // variables
  
  ArrayList<Line> lines;
  PGraphics pg;
  int thisdot, thisline;
  boolean newline;
  
  // constructor
  
  Board()
  {
    lines = new ArrayList<Line>();
    newline = true;
    resetPG();
    resetDraw();
  }
  
  // methods
  
  JSONArray toJSON()
  {
    JSONArray out = new JSONArray();
    for (int n = 0; n < lines.size(); n ++)
    {
      out.setJSONObject(n, lines.get(n).toJSON());
    }
    return out;
  }
  
  void load()
  {
    lines.clear();
    JSONArray in = loadJSONArray(filename);
    delay(500); // give it time to load fully
    for (int n = 0; n < in.size(); n ++)
    {
      lines.add(new Line(in.getJSONObject(n)));
    }
    redrawBoard();
  }
  
  void redrawBoard()
  {
    resetPG();
    pg.beginDraw();
    for (Line line : lines)
    {
      gcol = line.col;
      pg.fill(gcol);
      gsize = line.size;
      for (Dot dot : line.dots)
      {
        pg.ellipse(dot.x, dot.y, gsize, gsize);
      }
    }
    pg.endDraw();
  }
  
  void resetPG()
  {
    pg = createGraphics(width, height);
    pg.beginDraw();
    pg.ellipseMode(CENTER);
    pg.noStroke();
    pg.endDraw();
  }
  
  void addDots(ArrayList<Dot> dots)
  {
    if (newline)
    {
      newline = false;
      lines.add(new Line(gcol, gsize));
    }
    Line lastline = lines.get(lines.size() - 1);
    pg.beginDraw();
    pg.noStroke();
    pg.fill(lastline.col);
    for (Dot dot : dots)
    {
      lastline.dots.add(dot);
      pg.ellipse(dot.x, dot.y, lastline.size, lastline.size);
    }
    pg.endDraw();
  }
  
  void render()
  {
    background(bg);
    image(pg, 0, 0);
  }
  
  void savePNG(String pngfilename)
  {
    pg.save(pngfilename);
  }
  
  void undo()
  {
    if (lines.size() == 0) return;
    lines.remove(lines.size() - 1);
    redrawBoard();
  }
  
  boolean drawDot()
  {
    if (thisline >= lines.size())
    {
      resetDraw();
      return false;
    }
    Line line = lines.get(thisline);
    if (thisdot >= line.dots.size())
    {
      thisline ++;
      thisdot = 0;
      return drawDot();
    }
    Dot dot = line.dots.get(thisdot);
    fill(line.col);
    ellipse(dot.x, dot.y, line.size, line.size);
    thisdot ++;
    return true;
  }
  
  void resetDraw()
  {
    thisline = 0;
    thisdot = 0;
  }
  
}
