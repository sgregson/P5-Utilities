color pink = color(255, 102, 204);
color grn = color(0, 255, 30);
color blu = color(0, 30, 255);
float val = .78;

void setup() {
    size(1680, 1050);
}

void draw() {
  background(#FFFFFF);
  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    int px = i % width;
    int py = floor(i / width);
    if((height-py < val*px+100)&&(height-py > val*px-200)) {
      pixels[i] = pink;
    }
    else if(height-py == .68*px+100) {
      pixels[i] = grn;
    }
    else if(height-py == .58*px-100) {
      pixels[i] = blu;
    }
  }
  updatePixels();
}

void mouseClicked() {
  if(mouseButton == LEFT) {val += .05;}
  else {val -= .05;}
  println(val);
}
