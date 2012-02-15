PVector gridOrigin = new PVector(10,10);
int row = 150;
int col = 150;
int graphScale = 4;
float threshold = 0;  //graph point must be above this point to be rendered >0
float proximity = 150/graphScale;  //within this distance in cells to be counted
GraphPoint[][] grid = new GraphPoint[row][col];
DataPoint[] data = new DataPoint[500];
int countMax;
boolean pause = false;

void setup() {
  size((col+2)*graphScale,(row+2)*graphScale);
  println(proximity);
  frameRate(30);
  for(int i=0;i<row;i++) {
    for(int j=0;j<col;j++) {
      grid[i][j] = new GraphPoint(i,j);
    }
  }//initialize the grid
  for(int i=0;i<data.length;i++) {
    data[i] = new DataPoint();
  }//initialize the dataset
  updateValues();//give the points values
}




void draw() {
  if(!pause) {
    background(0);
    if(frameCount%60 == 0) {
      for(int i=0;i<data.length;i++) {
        data[i].randomize();
      }
      updateValues();
    }
    for(int i=0;i<row;i++) {
      for(int j=0;j<col;j++) {
        grid[i][j].display();
      }
    }

    stroke(#74BDE8);
    for(int i=0;i<data.length;i++) {
      data[i].display();
    }

    //gridLines();
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

void updateValues() {
  for(int i=0;i<row;i++) {
    for(int j=0;j<col;j++) {
      int count = 0;
      for(int k=0;k < data.length;k++) {
        if(PVector.dist(data[k].getLoc(),grid[i][j].getLoc()) <= proximity) {
          count++;
          //map(PVector.dist(data[k].getLoc(),grid[i][j].getLoc()),0,3,1.5,.7);
        }
      }
      if(count > countMax) {
        countMax = count;
      }
      grid[i][j].setValue(count);
    }
  }
}

class DataPoint {
  float xpos,ypos;
  float drawSize = graphScale/4;

  DataPoint(float i,float j) {
    xpos = gridOrigin.x+i*graphScale;
    ypos = gridOrigin.y+j*graphScale;
  }
  DataPoint() {randomize();}

  float getX() {return(xpos);}
  float getY() {return(ypos);}
  void randomize() {
    //      if(random(2) >=1 ){xpos = random(0,row);ypos = random(0,col/3);}
    //      else {xpos = random(2*row/3,row); ypos = random(0,col);}    
    int a = 0;
    while(a<1) {
      xpos = random(gridOrigin.x,gridOrigin.x+row*graphScale);
      ypos = random(gridOrigin.y,gridOrigin.y+col*graphScale);
      if(sq(2.3*row*graphScale/3-xpos)+sq(2*col*graphScale/3-ypos) > 81) {
        a++;
      }
    }
  }
  PVector getLoc() {
    return new PVector(xpos,ypos);
  }
  void display() {
    pushMatrix();
    translate(xpos,ypos);
    //ellipse(0,0,5,5);
    line(-drawSize,-drawSize,drawSize,drawSize);
    line(drawSize,-drawSize,-drawSize,drawSize);
    popMatrix();
  }
}

/////////////////////

class GraphPoint {
  float row,col,xpos,ypos,displayValue,setValue;
  float cellSize,fillSize;

  GraphPoint(int i,int j) {
    cellSize = graphScale;
    fillSize = .8*graphScale;
    row = i;
    col = j;
    xpos = gridOrigin.x+row*graphScale;
    ypos = gridOrigin.y+col*graphScale;
    setValue = 0;
    displayValue = 0;
  }

  void setValue(int value) {setValue = value;}
  float getX() {return(xpos);}
  float getY() {return(ypos);}
  float getValue() {return(setValue);}
  float getDisplayValue() {return(displayValue);}
  PVector getLoc() {return new PVector(xpos,ypos);}

  void display() {
    if(setValue >= threshold) {
      if(displayValue < setValue) {displayValue+=.5;}
      else if(displayValue > setValue) {displayValue-=.5;}
    } 
    else {
      displayValue = 0;
    }

    pushMatrix();
    translate(xpos,ypos);
    //stroke(#FF0000);
    //point(xpos,ypos,0);
    noStroke();
    //useful colors: 304269, F26101
    fill(lerpColor(#000000,#F26101,map(displayValue,0,countMax,0,1)));
    rect(-fillSize/2,-fillSize/2,fillSize,fillSize);
    popMatrix();
  }
}

