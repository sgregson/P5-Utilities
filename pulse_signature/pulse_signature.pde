ArrayList activeClicks;
int DURATION;
color solid = #0084A5;

void setup() {
  size(screen.width,screen.height);
  noStroke();
  smooth();
  
  DURATION = 3000;
  activeClicks = new ArrayList();
}

void draw() {
  //background(255);
  for (int i = 0; i < activeClicks.size(); i++) {
    PointTrace trace = (PointTrace) activeClicks.get(i);
    if( trace.update() ) {
      trace.display();
    } else {activeClicks.remove(i);}
  }
  for (int i = 0; i < activeClicks.size(); i++) {
    //  draw connector
    if(i > 0 ) {
      PointTrace trace = (PointTrace) activeClicks.get(i);
      PointTrace prev = (PointTrace) activeClicks.get(i-1);
      trace.connect( prev.x(), prev.y() );
    }
  }
}


void mouseDragged() {
  activeClicks.add( new PointTrace(millis(), mouseX, mouseY) );
}

void keyPressed() {
  if(key == 'q') {activeClicks.add( new PointTrace(millis(), rW(0),rH(0) ));}
  else if(key == 'w') {activeClicks.add( new PointTrace(millis(), rW(1),rH(0) ));}
  else if(key == 'e') {activeClicks.add( new PointTrace(millis(), rW(2),rH(0) ));}
  else if(key == 'r') {activeClicks.add( new PointTrace(millis(), rW(3),rH(0) ));}
  else if(key == 't') {activeClicks.add( new PointTrace(millis(), rW(4),rH(0) ));}
  else if(key == 'y') {activeClicks.add( new PointTrace(millis(), rW(5),rH(0) ));}
  else if(key == 'u') {activeClicks.add( new PointTrace(millis(), rW(6),rH(0) ));}
  else if(key == 'i') {activeClicks.add( new PointTrace(millis(), rW(7),rH(0) ));}
  else if(key == 'o') {activeClicks.add( new PointTrace(millis(), rW(8),rH(0) ));}
  else if(key == 'p') {activeClicks.add( new PointTrace(millis(), rW(9),rH(0) ));}
  else if(key == 'a') {activeClicks.add( new PointTrace(millis(), rW(0),rH(1) ));}
  else if(key == 's') {activeClicks.add( new PointTrace(millis(), rW(1),rH(1) ));}
  else if(key == 'd') {activeClicks.add( new PointTrace(millis(), rW(2),rH(1) ));}
  else if(key == 'f') {activeClicks.add( new PointTrace(millis(), rW(3),rH(1) ));}
  else if(key == 'g') {activeClicks.add( new PointTrace(millis(), rW(4),rH(1) ));}
  else if(key == 'h') {activeClicks.add( new PointTrace(millis(), rW(5),rH(1) ));}
  else if(key == 'j') {activeClicks.add( new PointTrace(millis(), rW(6),rH(1) ));}
  else if(key == 'k') {activeClicks.add( new PointTrace(millis(), rW(7),rH(1) ));}
  else if(key == 'l') {activeClicks.add( new PointTrace(millis(), rW(8),rH(1) ));}
  else if(key == 'z') {activeClicks.add( new PointTrace(millis(), rW(0),rH(2) ));}
  else if(key == 'x') {activeClicks.add( new PointTrace(millis(), rW(1),rH(2) ));}
  else if(key == 'c') {activeClicks.add( new PointTrace(millis(), rW(2),rH(2) ));}
  else if(key == 'v') {activeClicks.add( new PointTrace(millis(), rW(3),rH(2) ));}
  else if(key == 'b') {activeClicks.add( new PointTrace(millis(), rW(4),rH(2) ));}
  else if(key == 'n') {activeClicks.add( new PointTrace(millis(), rW(5),rH(2) ));}
  else if(key == 'm') {activeClicks.add( new PointTrace(millis(), rW(6),rH(2) ));}
}

float rH(int k) {return( random(k*height/3, (k+1)*height/3) );}
float rW(int k) {return( random(k*width/10, (k+1)*width/10) );}


class PointTrace {
  int theX;
  int theY;
  int mark;
  int s, mS;
  float amt, amt2;
  color fade, fade2;
  
  PointTrace(int _m, float _x, float _y) {
    mark = _m;
    theX = floor(_x);
    theY = floor(_y);
    s = floor(40 * (sin((PI - 1)*(1 - map(mark + DURATION - millis(), 0, DURATION, 0, 1) ) + 1) ));
    mS = s;
  }
  
  int x() {return theX;}
  
  int y() {return theY;}
  
  boolean update() {
    if(mark + DURATION - millis() >= -DURATION ) {
      return(true);
      
    } else { return(false); }
  }
  
  void display() {
    fill(solid, 40);
    noStroke();
    ellipse(theX,theY, 32, 32);
    
    noFill();
    stroke(solid, 40);
    ellipse(theX,theY, 40,40);
    println();
  }
  
  
  void connect(int nX, int nY) {
      int di = floor( sqrt(pow(theX-nX,2) + pow(theY-nY,2)) );
      
      stroke(solid, 40);
      line(theX,theY,nX,nY);
      
      /*
      beginShape();
      vertex(theX,theY);
      bezierVertex(theX, theY-(.5*di) ,nX, nY-(.5*di) ,nX,nY);
      endShape();
      */
  }
  
}


int[] getKeyframes(int start, int dur) {
  int[] keyF = {start, round(start + (.25*dur)), round(start + (.75*dur)), start + dur};
  return(keyF);
}
