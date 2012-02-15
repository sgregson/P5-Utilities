
HashMap frequencyCount(String[] _in) {
  HashMap toSend = new HashMap();
  String allWords = join(_in, " ");
  String[] tokens = splitTokens(allWords, " ,.?!:;[]-_+");
  
  for(int i=0; i<tokens.length; i++) {
    String s = tokens[i];  // "s" is the active word
    
    // Is the word in the HashMap
    if( match(s, "\\A(the|and|to|e|a|in|is|at|as|an|from|new|on|or|of|with|for)\\z(?i)") == null ) {
      if (toSend.containsKey(s)) {
        //  Get the word's current value, increment it, and re-place that key in the map
        int amt = int( (String) toSend.get(s) );
        toSend.put(s, str(amt+1));
      } else {
        // Otherwise enter the new word, value "1"
        toSend.put(s, "1");
      }
    }
  }
  
  return toSend;
}


// Sort a HashMap by value
List sortByValue(final Map m) {
    List keys = new ArrayList();
    keys.addAll(m.keySet());
    Collections.sort(keys, new Comparator() {
        public int compare(Object o1, Object o2) {
            //rename v1 and v2 to reverse sort order
            Object v2 = m.get(o1);
            Object v1 = m.get(o2);
            if (v1 == null) {
                return (v2 == null) ? 0 : 1;
            }
            else if (v1 instanceof Comparable) {
                return ((Comparable) v1).compareTo(v2);
            }
            else {
                return 0;
            }
        }
    });
    return keys;
}

// Utility function to index lists of files
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

// Function to get a list of all files in a directory and all subdirectories
ArrayList listFilesRecursive(String dir) {
   ArrayList fileList = new ArrayList(); 
   recurseDir(fileList,dir);
   return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a,subfiles[i].getAbsolutePath());
    }
  } else {
    a.add(file);
  }
}
