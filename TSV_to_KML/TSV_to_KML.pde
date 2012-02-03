/*

REQUIRES TAB-SEPARATED VALUES

*/

void setup() {
  String[] files = listFileNames(sketchPath + "/input/");
  for(int i=0; i < files.length; i++) {
    writeKML(files[i]);
  }
  println("Finished.");
  exit();
}

void writeKML(String _file) {
  PrintWriter output = createWriter(sketchPath + "/output/"+_file+".kml");
  
  //write document header
  String[] docPrefix = loadStrings(sketchPath + "/kml_header.txt");
  for(int i=0; i<docPrefix.length; i++) {
    output.println(docPrefix[i]);
  }
  output.println("\t<name>" + _file + ".kml</name>");  //write document name
  
  //write balloon template
  String[] balloon = loadStrings(sketchPath + "/balloon_style.txt");
  for(int i=0; i<balloon.length; i++) {
    output.println(balloon[i]);
  }
  
  //write schema
  String[] schema = loadStrings(sketchPath + "/dsgnmps_KML_schema.txt");
  for(int i=0; i<schema.length; i++) {
    output.println(schema[i]);
  }
  
  //Start <Folder>
  output.println("\t<Folder>");
  output.println("\t\t<name>" + _file + " outlines</name>");  //write folder name
  
  //Write Placemarks (loop starts a 1 to ignore headers)
  String[] lines = loadStrings(sketchPath + "/input/" + _file);
  for(int i=1; i<lines.length; i++) {
    String[] params = split(lines[i], '\t');
    if( !params[0].equals("EXTRA") ) {
      String num = deEncode(params[0]);
      String name = deEncode(params[2]);
      String street = deEncode(params[3]);
      String region = deEncode(params[4]);
      String description = deEncode(params[5]);
      String date = deEncode(params[6]);
      String poly = params[7];
      
      output.println("\t\t<Placemark>");
      output.println("\t\t\t<name>"+name+"</name>");
      
      if(match(_file, "new") != null) {
        output.println("\t\t\t<styleUrl>#dsgnmps-new</styleUrl>");
      } else if(match(_file, "modern") != null) {
        output.println("\t\t\t<styleUrl>#dsgnmps-modern</styleUrl>");
      } else if(match(_file, "historic") != null) {
        output.println("\t\t\t<styleUrl>#dsgnmps-historic</styleUrl>");
      } else if(match(_file, "restaurant") != null) {
        output.println("\t\t\t<styleUrl>#dsgnmps-restaurant</styleUrl>");
      } else if(match(_file, "imbibe") != null) {
        output.println("\t\t\t<styleUrl>#dsgnmps-imbibe</styleUrl>");
      } else if(match(_file, "shop") != null) {
        output.println("\t\t\t<styleUrl>#dsgnmps-shop</styleUrl>");
      }
      
      output.println("\t\t\t<ExtendedData>");
      output.println("\t\t\t\t<SchemaData schemaUrl=\"#dsgnmpsSchema\">");
      output.println("\t\t\t\t\t<SimpleData name=\"number\">"+ num +"</SimpleData>");
      output.println("\t\t\t\t\t<SimpleData name=\"name\">"+ name +"</SimpleData>");
      output.println("\t\t\t\t\t<SimpleData name=\"street\">"+ street +"</SimpleData>");
      output.println("\t\t\t\t\t<SimpleData name=\"region\">"+ region +"</SimpleData>");
      output.println("\t\t\t\t\t<SimpleData name=\"description\">"+ description +"</SimpleData>");
      output.println("\t\t\t\t\t<SimpleData name=\"date\">"+ date +"</SimpleData>");
      output.println("\t\t\t\t</SchemaData>");
      output.println("\t\t\t</ExtendedData>");
      
      output.println("\t\t\t<Polygon>");
      output.println("\t\t\t\t<tessellate>1</tessellate>");
      output.println("\t\t\t\t<outerBoundaryIs>");
      output.println("\t\t\t\t\t<LinearRing>");
      output.println("\t\t\t\t\t\t<coordinates>");
      output.println("\t\t\t\t\t\t\t"+poly);
      output.println("\t\t\t\t\t\t</coordinates>");
      output.println("\t\t\t\t\t</LinearRing>");
      output.println("\t\t\t\t</outerBoundaryIs>");
      output.println("\t\t\t</Polygon>");
      output.println("\t\t</Placemark>");
    }
  }
  
  
  //close folder, document, kml
  output.println("\t</Folder>");
  output.println("</Document>");
  output.println("</kml>");
  
  output.flush();
  output.close();

}

String deEncode(String s) {
  //handle special characters that are represented by Special Characters in XML spec
  s = s.replaceAll("&","&amp;");
  s = s.replaceAll("<","&lt;");
  s = s.replaceAll(">","&gt;");
  s = s.replaceAll("'","&quot;");
  s = s.replaceAll("\"","&apos;");
  return(s);
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


/********
outline:
kml>
  Document>
    <Schema name="_string_" id="schemaID">   
      <SimpleField type="string/int/float/double/bool" name="field_file">     
        <displayName>...</displayName>            <!-- string -->   
      </SimpleField> 
    </Schema>

    <name>
    <Folder>
      <name>
      <Placemark>*
        <name>
        
        <ExtendedData>                   
          <SchemaData schemaUrl="#schemaID">
            <SimpleData name="field_file">VALUE</SimpleData>       <!-- string -->
          </SchemaData>
        </ExtendedData>
        
        <Polygon>
          <tessellate>  1
          <outerBoundaryIs>
            <LinearRing>
              <coordinates>
                <VALUE
              </coordinates
            </LinearRing
          </outerBoundaryIs
********/
