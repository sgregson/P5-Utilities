char[] input;
String[] history;
boolean finished = false;
int lH = 11;

void setup() {
  size(200,200);
  fill(255);stroke(255);
  history = new String[0];
  input = new char[0];
}

void draw() {
  background(0);
  
  for(int i = 0; i<history.length;i++){text(history[i], 5,height - lH - (history.length * lH) + i*lH);}
  text(new String(input), 5,height-lH);
  if( sin(millis() / 100) >= 0 ) {line(5,height-10,10,height-10);}
  
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

    println(new String(input));
  }
  else if(key != CODED) {
    input = append(input, char(key));

    println(new String(input));
  }
}

