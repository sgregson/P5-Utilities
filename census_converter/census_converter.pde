int term;

void setup() {
  size(200,200);
  term = millis();
  background(#FF0000);
}

void draw() {
  if(frameCount == 1){
    String loadPath = selectInput("Choose Input [true CSV with headers, column-0 is COUNT]");
    if( loadPath == null ) {exit();}
    else {
      String outputPath = selectOutput("Select or Create Destination File");
      if( outputPath == null ) {exit();}
      else {
        size(400,400);
        background(0);
        if( !outputPath.substring(outputPath.length()-4).equals(".csv") ) { outputPath = outputPath + ".csv"; }
        
        
        String[] linesIn = loadStrings(loadPath);
        PrintWriter output = createWriter(outputPath);
        
        //  Copy Headings
        String[] params = split(linesIn[0], ',');
        String personType = join(subset(params, 1),',');
        output.println(personType);
        
        
        //  Copy Remaining
        for(int i = 1;i < linesIn.length; i++) {
          println("Processing Line: " + linesIn[i]);
          
          params = split(linesIn[i], ',');
          personType = join(subset(params, 1),',');
          // for as many times as are indicated in the first column, print the remaining attributes as csv
          for(int j = 0; j < int(params[0]);j++) {
            output.println(personType);
          }
        }
        
        output.flush();
        output.close();
        println(millis() + " done");
        
        term = millis();
        background(#00FF00);
      }
    }
  }
  
  if(millis() - term > 1000) {exit();}
}
