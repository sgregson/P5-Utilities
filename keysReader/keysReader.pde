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
    input = new char[0];
    finished = false;
  }
}

void keyPressed() {
  //ENTER pushes input[] to new line of history
  //BACKSPACE removes character or line
  //UNENCODED keys are logged in input[]
  if(key == ENTER || key == RETURN) {finished = true;}
  else if(key == BACKSPACE) {
    if(input.length > 0) { input = shorten(input); }
    else { if(history.length > 0){history = shorten(history);} }
  }
  else if(key != CODED) {
    input = append(input, char(key));
  }
}

