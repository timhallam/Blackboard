/* 
Blackboard
by Tim Hallam
Jan 2005

key bindings:
  R      run/playback
  CtrlR  save stillframes
  CtrlS  save .chalk
  CtrlA  save-as .chalk
  CtrlP  save .png
  CtrlO  open .chalk
  CtrlZ  undo
  CtrlN  new
*/



boolean newline;
color gcol;
int gsize;
int playmode, playspeed;
Board board;
Menu menu;
String filename;
boolean unsaved;
PGraphics bg;

void setup()
{
  size(1280, 720); // uncomment for windowed mode
  //fullScreen(); // or uncomment this for fullscreen - may be glitchy on ultrafine displays (TODO: fix this)
  
  frameRate(30);
  
  menu = new Menu();
  board = new Board();
  playmode = 0;
  playspeed = 40;
  
  bg = createGraphics(width, height);
  bg.beginDraw();
  bg.background(0); // change background colour here
  bg.image(loadImage(sketchPath() + File.separator + "backgrounds" + File.separator + "blackboard.png"), 0, 0, width, height); // change background image here
  bg.endDraw();
  
  background(bg);
  ellipseMode(CENTER);
  noStroke();
  
  filename = null;
  unsaved = true;
}

void draw()
{
  if (playmode == 0)
  {
    board.render();
    menu.render();
  }
  else
  {
    if (playmode == 2) saveFrame(sketchPath() + File.separator + "data" + File.separator + "frame#######.tif");
    for (int n = 0; n < playspeed; n ++)
    {
      if (!board.drawDot()) playmode = 0;
    }
  }
}
