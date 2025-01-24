

class Dot
{
  // variables
  
  float x, y;
  
  // constructors
  
  Dot(float x, float y)
  {
    this.x = x;
    this.y = y;
  }
  
  Dot(JSONObject in)
  {
    x = in.getFloat("x");
    y = in.getFloat("y");
  }
  
  // methods
  
  JSONObject toJSON()
  {
    JSONObject out = new JSONObject();
    out.setFloat("x", x);
    out.setFloat("y", y);
    return out;
  }
}
