boolean toggle;
boolean bam = true;
Oscillator wave;

Ejector[] ejectorList = new Ejector[0];

void setup() {
  //timing is controlled by the millis() parameter instead of frameCount to create constant timing
  size(200,600);

  frameRate(100);  //adjusts the x-axis sample rate for sine functions.
  toggle = false;
  
  wave = new Oscillator(3,0,height,0);
  frameRate(10);
}


void draw() {
  fill(0);
  stroke(#FFFFFF);
  rect(0,0,width-1,height-1);
  update();
  display();
  
  if((frameCount % 30 == 0) && toggle) {
    println("new!");
    Ejector ap = new Ejector(random(0,width),random(0,height));  //random position
    ejectorList = (Ejector[]) append(ejectorList, ap);
  }
  
}

void update() {
  wave.update();
  for(int i=0;i<ejectorList.length;i++) {ejectorList[i].update();}
}
void display() {
  wave.display();
  for(int i=0;i<ejectorList.length;i++) {ejectorList[i].display();}
}

void mouseClicked() {toggle = !toggle;}
void keyPressed() {
  if(key == ' '){
    if(bam) {
      noLoop();
    }
    else {
      loop();
    }
    bam = !bam;
  }
}

//--------CLASSES--------

class Ejector {
  float r;
  PVector loc;
  Oscillator wobble;
  
  Ejector(float _x, float _y) {
    loc = new PVector(_x,_y);
    wobble = new Oscillator(random(.5,8),50,100,millis());
    r = wobble.update();
  }
  
  void update() {
    r = wobble.update();
  }
  
  void display() {
    noFill();
    
    float v = wave.value();
    if(v >= loc.y-r && v <= loc.y+r) {
      //float sag = r-(loc.y-v); //yields the length of the sagitta of the chord
      //float ch = 2 * sqrt(sag * (2*r - sag));
      float ch = sqrt(pow(r,2) - pow(r-loc.y+v,2));
      stroke(#FF0000);
      line(loc.x - ch,v,loc.x + ch,v);
    }
    else {
      stroke(#FFFFFF);
    }
    //stroke(#FFFFFF);
    ellipse(loc.x,loc.y,r,r);
  }
}

class Oscillator {
  int start;
  float period;
  float mi,ma;
  float val;
  
  Oscillator(float _p, float _mi, float _ma, int _st) {
    start = _st;  //millis() at initialization
    period = _p;  //period measured in seconds
    mi = _mi;  //min value
    ma = _ma;  //max value
  }
  
  float value() { return(val);}
  
  float update() {
    float amp = (ma - mi)/2;
    val = amp * sin((2*PI*.001*(millis()-start)/period))+(mi + amp);
    return(val);
  }
  
  void display() {
    line(0,val,width,val);
  }
}
