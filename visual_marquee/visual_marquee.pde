Marquee queue;
String[] labels = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p"};
int count = 0;
PFont font;

void setup() {
  size(1680, 1050);
  smooth();
  font = createFont("ArialBold", 16);
  textFont(font);
  
  queue = new Marquee(width-500,0,500,5);
}


void draw() {
  background(125);
  queue.update();
  queue.display();
  
  if(frameCount % 180 == 0) {
    queue.add(labels[count]); println("BANG!");
    count++;
  }
}

class Marquee {
  int x,y,w,count;
  int eventMark;
  int duration;
  ArrayList latest;
  
  Marquee(int _x, int _y, int _w, int _c) {
    x = _x;
    y = _y;
    w = _w;
    count = _c;
    
    duration = 800;
    latest = new ArrayList();
  }
  
  int x() { return x; }
  int y() { return y; }
  int w() { return w; }
  
  void add(String _label) {
    int theTime = millis();
    for(int i =0; i < latest.size(); i++) {
      ( (MarqueeBox) latest.get(i) ).move( theTime );
    }
    
    latest.add(0, new MarqueeBox(_title, _subtitle, x, y, w, w / count, duration, count) );
  }
  
  void update() {
    int theTime = millis();
    for(int i =0; i < latest.size(); i++) {
      MarqueeBox theBox = (MarqueeBox) latest.get(i);
      if( !theBox.isExpired() ) {
        ( (MarqueeBox) latest.get(i) ).update( theTime );
      } else { latest.remove(i); }
    }
  }
  void display() {
    for(int i = 0; i < latest.size(); i++) {
      ( (MarqueeBox) latest.get(i) ).display();
    }
    noFill();
    stroke(#FF4477);
    rect(x,y,w,w/count);
  }
  
}

class MarqueeBox {
  String label;
  boolean expired;
  int initEvent, moveEvent, duration;
  int cutoff;
  float x, opacity;
  int pos;
  int pX, pW;
  int y,w,h;
  
  MarqueeBox(String _label, int _x, int _y, int _w, int _size, int _duration, int _max) {
    label = _label;
    initEvent = moveEvent = millis();
    duration = _duration;
    cutoff = _max;
    w = h = _size;
    
    x = pX = _x;
    y = _y;
    pW = _w;
    
    opacity = 0;
    pos = 0;
    expired = false;  //  Set in "update()"
  }
  
  void move(int theTime) {
    moveEvent = theTime;
    pos++;
  }
  
  boolean isExpired() { return expired; }
  
  void update(int theTime) {
    if(pos >= cutoff && opacity <= 0) { expired = true; }  // flag removal
    else if(pos >= cutoff) { opacity = max(0, map(theTime - moveEvent, 0, duration, 255, 0) ); }  //fade out
    else if( theTime > initEvent + duration ) { opacity = 255; }  //hold color
    else { opacity = map(theTime - initEvent, 0, duration, 0, 255); }  //fade in
    
    if( theTime > moveEvent + duration ) { x = (pX+pW) - ((pos+1) * w); }
    else { x = map(theTime - moveEvent, 0, duration, (pX+pW) - ( (pos) * w), (pX+pW) - ( (pos + 1) * w)); }
  }
  
  void display() {
    int fi = 15;  // fillet amount
    float fiK = fi * .552284;  //degree of bezier point
    noStroke();
    fill(#FFAABB, opacity);
    //rect(x,y,w,h);
    
    beginShape();
    //  Rounded Rectangle
    vertex(x+w-fi,y);  //Top-Right
    bezierVertex(x+w-fi+fiK,y, x+w,y+fi-fiK, x+w,y+fi);
    
    vertex(x+w,y+h-fi);  //Bottom-Right
    bezierVertex(x+w,y+h-fi+fiK, x+w-fi+fiK,y+h, x+w-fi,y+h);
    
    vertex(x+fi,y+h);  //Bottom-Left
    bezierVertex(x+fi-fiK,y+h, x,y+h-fi+fiK, x,y+h-fi);
    
    vertex(x,y+fi);  //Complete Top-Left
    bezierVertex(x,y+fi-fiK, x+fi-fiK,y ,x+fi,y);
    endShape(CLOSE);
    
    fill(255);
    text(label, x+fi, y+fi);
  }
  void doc() {
    println(x + "\t@: " + opacity);
  }
}
