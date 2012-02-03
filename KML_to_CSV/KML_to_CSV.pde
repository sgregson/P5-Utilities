/**
*A Program to convert KML files into Tab-Separated-Value files
*The objective is to make it easier to construct a KML file with metadata for extra content
**/
void setup() {
  String[] kmlFiles = listFileNames(sketchPath + "/input/");
  for(int i=0; i < kmlFiles.length; i++) {
    writeTSV(kmlFiles[i]);
  }
}

void writeTSV(String _file) {
  XMLElement kml = new XMLElement(this, sketchPath+"/input/"+_file);
  PrintWriter output = createWriter(sketchPath+"/output/"+_file+".csv");
  
  XMLElement[] refs = kml.getChildren("Document/Folder/Placemark");

  output.println(kml.getChild("Document/name").getContent() + "\t" + kml.getChild("Document/Folder/name").getContent());
  
  for(int i=0; i<refs.length; i++) {
    output.println(refs[i].getChild("name").getContent() + "\t" + trim(refs[i].getChild("Polygon/outerBoundaryIs/LinearRing/coordinates").getContent()));
  }
  
  output.flush();
  output.close();
}


// Utility function to index lists of files in the data directory
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}


