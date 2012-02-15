class Firm {
  String name;
  HashMap people;
  HashMap connections;
  String[] allBios;
  
  Firm(String _name, Person _entry) {
    name = _name;
    people = new HashMap();
    allBios = new String[0];
    
    people.put(_entry.name(), _entry);
  }
  
  void put(Person _entry) { people.put(_entry.name(), _entry); }
  boolean contains(String _name) { return people.containsKey(_name); }
  Person get(String _name) { return (Person) people.get(_name); }
  
  void analyzeFirm() {
    for(Iterator i = people.keySet().iterator(); i.hasNext(); ) {
      Person p = (Person) people.get( (String) i.next() );
      allBios = (String[]) concat(allBios, p.bio());
    }
    connections = frequencyCount(allBios);
  }
  
  String toString() {
    String out = new String("Firm:  " + name + "\t");
    
    int count = 0;
    for(Iterator i = sortByValue(connections).iterator(); i.hasNext() && count < 6; ) {
      String theKey = (String) i.next();
      String theValue = (String) connections.get(theKey);
      
      out += theKey + "(" + theValue + ") / ";
      count++;
    }
    
    out += "\n";
    
    for(Iterator i = people.keySet().iterator(); i.hasNext(); ) {
      Person t = (Person) people.get( (String) i.next() );
      out += "  " + t + "\n";
    }
    
    return out;
  }
}

class Person {
  String name;
  String[] bio;
  HashMap words;
  
  Person(String _n, String[] _b) {
    name = _n;
    bio = _b;
    words = frequencyCount(bio);
  }
  
  String name() { return name; }
  String[] bio() { return bio; }
  
  String toString() {
    String out = new String("Person:  " + name + "\t");
    
    int count = 0;
    for(Iterator i = sortByValue(words).iterator(); i.hasNext() && count < 6; ) {
      String theKey = (String) i.next();
      String theValue = (String) words.get(theKey);
      
      out += theKey + "(" + theValue + ") / ";
      count++;
    }
    
    return out;
  }
}
