HashMap companies;

void setup() {
  companies = new HashMap();
  createObjects();
  
  for(Iterator i = companies.keySet().iterator(); i.hasNext(); ) {
    Firm f = (Firm) companies.get( (String) i.next() );
    f.analyzeFirm();
    
    println(f);
  }
}

void draw() {
  
  
}



void createObjects() {
  ArrayList allFiles = listFilesRecursive(sketchPath + "/data");
  
  for(int i=0; i < allFiles.size(); i++) {
    File f = (File) allFiles.get(i);
    if( match(f.getName(), "(\\.(?i)(txt))$") != null ) {
      println(">>Bio: " + f.getName());
      
      String[] fLoc = split(f.getAbsolutePath(), "/");
      String theFirm = fLoc[fLoc.length-2];
      String theName = match(fLoc[fLoc.length-1], "(.*)(.txt)$(?i)")[1];  //match everything but .txt
      String[] theBio = loadStrings( f.getAbsolutePath() );
      
      if( companies.containsKey( theFirm ) ) {
        Firm company = (Firm) companies.get( theFirm );
        company.put( new Person(theName, theBio) );
      } else { companies.put( theFirm, new Firm(theFirm, new Person(theName,theBio)) ); }
      
    }
  }
  
  println();
}



