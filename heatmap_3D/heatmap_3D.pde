import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

int row = 40;
int col = 70;
float rVal = .25;
int graphScale = 1;
float threshold = 1.5;  //graph point must be above this point to be rendered >0
GraphPoint[][] grid = new GraphPoint[row][col];
DataPoint[] data = new DataPoint[400];
PeasyCam cam;
int countMax;
boolean pause = false;

void setup() {
  size(900,600,P3D);
  frameRate(30);
  cam = new PeasyCam(this,2*row/3,2*col/3,0,35);
  cam.setRotations(-0.6681,0.6888,-0.7680);
  cam.setResetOnDoubleClick(false);
  //-0.9832,0.2930,-0.1699
  //-0.6820,0.6624,-0.5823
  for(int i=0;i<row;i++) {
    for(int j=0;j<col;j++) {
      grid[i][j] = new GraphPoint(i,j);
    }
  }
  for(int i=0;i<data.length;i++) {data[i] = new DataPoint();}
  
  updateValues();
  
}




void draw() {
  if(!pause) {
    background(0);
    if(frameCount%60 == 0){
      for(int i=0;i<data.length;i++) {data[i].randomize();}
      updateValues();
    }
    for(int i=0;i<row;i++) {for(int j=0;j<col;j++) {grid[i][j].display();}}
    
    strokeWeight(1);
    stroke(#74BDE8);
    for(int i=0;i<data.length;i++) {data[i].display();}
    strokeWeight(1);
    
    gridLines();
  }
}


void keyPressed() {
  if(key == ' ') {
    saveFrame("sample-###.png");
  }
  else if(key == 'p') {
    pause = !pause;
  }
}
void mousePressed() {
  println(join(nf(cam.getRotations(),1,4),","));
  println(cam.getDistance());
}



void gridLines() {
  //Column Lines
  for(int i=0;i<row;i++) {
    if(i==0 || i==row-1) {}
    else {
      beginShape();
      for(int j=0;j<col;j++) {
        stroke(255,30);
        if(grid[i][j].getZ() > threshold){curveVertex(grid[i][j].getX(),grid[i][j].getY(),grid[i][j].getZ());}
        else {curveVertex(grid[i][j].getX(),grid[i][j].getY(),0);}
      }
      endShape();
    }
  }

  for(int i=0;i<col;i++) {
    if(i==0 || i==col-1) {}
    else {
      beginShape();
      for(int j=0;j<row;j++) {
        //stroke(lerpColor(#000000,#FF0000,map(grid[j][i].getZ(),-rVal,rVal,0,1)));
        stroke(255,30);
        if(grid[j][i].getZ() > threshold){curveVertex(grid[j][i].getX(),grid[j][i].getY(),grid[j][i].getZ());}
        else {curveVertex(grid[j][i].getX(),grid[j][i].getY(),0);}
      }
      endShape();
    }
  }
}

void updateValues(){
  for(int i=0;i<row;i++) {
    for(int j=0;j<col;j++) {
      int count = 0;
      for(int k=0;k < data.length;k++) {
        if(PVector.dist(data[k].getLoc(),grid[i][j].getLoc()) <= 3){
          count += map(PVector.dist(data[k].getLoc(),grid[i][j].getLoc()),0,3,1.5,.7);
        }
      }
      if(count > countMax){countMax = count;}
      grid[i][j].setZ(count);
    }
  }
}

class DataPoint {
  float gxloc,gyloc,xpos,ypos;

  DataPoint(float i,float j) {
    gxloc = i;
    gyloc = j;
    xpos = i*graphScale;
    ypos = j*graphScale;
  }
  DataPoint() {randomize();}

  float getX() {return(xpos);}
  float getY() {return(ypos);}
  void randomize() {
//      if(random(2) >=1 ){xpos = random(0,row);ypos = random(0,col/3);}
//      else {xpos = random(2*row/3,row); ypos = random(0,col);}    
    int a = 0;
    while(a<1){
      xpos = random(0,row*graphScale);
      ypos = random(0,col*graphScale);
      if(sq(2.3*row/3-xpos)+sq(2*col/3-ypos) > 81){a++;}
    }
      
  }
  PVector getLoc() {return new PVector(xpos,ypos,0);}
  void display() {
    point(xpos,ypos,0);
  }
}

class GraphPoint {
  float row,col,xpos,ypos,zcurrent,zfuture;
  float cellSize;

  GraphPoint(int i,int j) {
    cellSize = graphScale*.9;
    row = i;
    col = j;
    xpos = row*graphScale;
    ypos = col*graphScale;
    zcurrent = 0;
  }

  void setZ(int value) {zfuture = value;}
  float getX() {return(xpos);}
  float getY() {return(ypos);}
  float getZ() {return(zcurrent);}
  PVector getLoc() {return new PVector(xpos,ypos,0);}

  void display() {
    //stroke(#FF0000);
    //point(xpos,ypos,0);
    noStroke();
    //useful colors: 304269, F26101
    fill(lerpColor(#000000,#F26101,map(zcurrent,0,countMax,0,1)));
    //fill(lerpColor(#000000,#F26101,map(floor(zcurrent),0,4,0,1)));
    pushMatrix();
    translate(0,0,-.1);
    rect(xpos-cellSize/2,ypos-cellSize/2,cellSize,cellSize);
    popMatrix();
    if(zcurrent < zfuture){zcurrent+=.5;}
    else if(zcurrent > zfuture){zcurrent-=.5;}
  }
}

