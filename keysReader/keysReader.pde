char[] input;
String[] history;
boolean finished = false;

void setup() {
  size(200,200);
  history = new String[0];
  input = new char[0];
}

void draw() {
  if(finished) {
    history = append(history, new String(input));
    println(history);
    input = new char[0];
    finished = false;
  }
}

void keyPressed() {
  //ENTER triggers immediate print/purge
  //BACKSPACE removes last character
  //Non-coded keys will append to the input array.
  if(key == ENTER || key == RETURN) {finished = true;}
  else if(key == BACKSPACE) {
    if(input.length > 0) {input = shorten(input);}
    println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    println(new String(input));
  }
  else if(key != CODED) {
    input = append(input, char(key));
    println("\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
    println(new String(input));
  }
}
