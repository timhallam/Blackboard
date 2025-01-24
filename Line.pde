

class Line
{
  // variables
  
  ArrayList<Dot> dots;
  color col;
  int size;
  
  // constructors
  
  Line(color col, int size)
  {
    this.col = col;
    this.size = size;
    dots = new ArrayList<Dot>();
  }
  
  Line(JSONObject in)
  {
    dots = new ArrayList<Dot>();
    col = unhex(in.getString("c"));
    size = in.getInt("s");
    JSONArray jdots = in.getJSONArray("d");
    for (int n = 0; n < jdots.size(); n ++)
    {
      dots.add(new Dot(jdots.getJSONObject(n)));
    }
  }
  
  // methods
  
  JSONObject toJSON()
  {
    JSONObject out = new JSONObject();
    out.setInt("s", size);
    out.setString("c", hex(col));
    JSONArray jdots = new JSONArray();
    for (int n = 0; n < dots.size(); n ++)
    {
      jdots.setJSONObject(n, dots.get(n).toJSON());
    }
    out.setJSONArray("d", jdots);
    return out;
  }
}
