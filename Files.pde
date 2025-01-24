

void saveJSONAs(File file)
{
  if (file == null) return;
  filename = makeFilename(file, "chalk");
  saveJSON();
}

void saveJSON()
{
  saveJSONArray(board.toJSON(), filename);
  unsaved = false;
}

void openJSON(File file)
{
  if (file == null) return;
  String tempfilename = checkFilename(file);
  if (tempfilename == null) return;
  filename = tempfilename;
  board.load();
  unsaved = false;
}

void savePNGAs(File file)
{
  if (file == null) return;
  board.savePNG(makeFilename(file, "png"));
}

String checkFilename(File in)
{
  String out = in.getAbsolutePath();
  int dotindex = out.lastIndexOf('.');
  if (dotindex < 0) return null;
  String ext = out.substring(dotindex);
  if (ext.equals(".chalk")) return out;
  return null;
}

String makeFilename(File in, String extension)
{
  String out = in.getAbsolutePath();
  int dotindex = out.lastIndexOf('.');
  if (dotindex < 0) return out + "." + extension;
  return out.substring(0, dotindex + 1) + extension;
}
