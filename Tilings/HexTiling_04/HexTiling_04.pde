/*Based on the wikipedia article: */
// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
float R, sep, r, currentR;
Hex[][] grid;
int visCount, count;
float yOff;
float a;
PVector[][] corners;
float frameDuration = TWO_PI/240;

void setup() {
  noFill();
  stroke(0);
  size(500, 577);
  visCount = 6;
  count = 7;
  sep = width/(visCount-1);
  R = sep/1.5;
  r = R*cos(PI/6);
  a = 0;
  currentR = R*cos(a);
  //yOff = spacing/2*cos(PI/6);
  grid = new Hex[count][count];
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count; j++) {
      if (i%2 == 1) {
        grid[i][j] = new Hex((i-1)*R*1.5, (j+0.5 - 1)*2*r);
      } else {
        grid[i][j] = new Hex((i - 1)*R*1.5, (j - 1)*2*r);
      }
    }
  }
}

void draw() {
  background(0);
  currentR = 0.5*R*cos(a)+R/2;
  fill(255, 0, 0);


  drawHexes();
  drawLRRhombus();
  drawVRhombus();
  drawRLRhombus();


  a+=frameDuration;
  //saveFrame("output/gif-###.png");
  //if(a > TWO_PI){
  //  noLoop();
  //}
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}

void drawHexes() {
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count; j++) {
      //strokeWeight(5);
      //grid[i][j].showVertices();
      //noStroke();
      grid[i][j].updateHex();
      grid[i][j].showHex();
    }
  }
}

void drawLRRhombus() {
  //draw LR rhombus
  fill(255, 255, 0);
  for (int i = 0; i < count-1; i++) {
    for (int j = 0; j < count-1; j++) {
      Hex h1 = grid[i][j];
      Hex h2 =  grid[i+1][j];
      if (i%2==0) {
        beginShape();
        vertex(h1.c[0].x, h1.c[0].y);
        vertex(h1.p[0].x, h1.p[0].y);
        vertex(h2.c[4].x, h2.c[4].y);
        vertex(h2.c[3].x, h2.c[3].y);
        vertex(h1.p[1].x, h1.p[1].y);
        vertex(h1.c[1].x, h1.c[1].y);
        endShape(CLOSE);
      } else {
        beginShape();
        vertex(h1.c[5].x, h1.c[5].y);
        vertex(h1.p[5].x, h1.p[5].y);
        vertex(h2.c[3].x, h2.c[3].y);
        vertex(h2.c[2].x, h2.c[2].y);
        vertex(h1.p[0].x, h1.p[0].y);
        vertex(h1.c[0].x, h1.c[0].y);
        endShape();
      }
    }
  }
}

void drawVRhombus() {
  //draw LR rhombus
  fill(255, 255, 0);
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count - 1; j++) {
      Hex h1 = grid[i][j];
      Hex h2 =  grid[i][j+1];
      beginShape();
      vertex(h1.p[2].x, h1.p[2].y);
      vertex(h1.c[2].x, h1.c[2].y);
      vertex(h1.c[1].x, h1.c[1].y);
      vertex(h1.p[1].x, h1.p[1].y);
      vertex(h2.c[5].x, h2.c[5].y);
      vertex(h2.c[4].x, h2.c[4].y);
      endShape(CLOSE);
    }
  }
}

void drawRLRhombus() {
  fill(255, 255, 0);
  for (int i = 1; i < count - 1; i+= 2) {
    for (int j = 0; j < count - 1; j++) {
      Hex h1 = grid[i][j];
      Hex h2 =  grid[i-1][j+1];
      Hex h3 = grid[i+1][j+1];
      beginShape();
      vertex(h1.c[3].x, h1.c[3].y);
      vertex(h1.p[3].x, h1.p[3].y);
      vertex(h2.c[5].x, h2.c[5].y);
      vertex(h2.c[0].x, h2.c[0].y);
      vertex(h1.p[2].x, h1.p[2].y);
      vertex(h1.c[2].x, h1.c[2].y);
      endShape(CLOSE);

      beginShape();
      vertex(h1.c[0].x, h1.c[0].y);
      vertex(h1.p[0].x, h1.p[0].y);
      vertex(h3.c[4].x, h3.c[4].y);
      vertex(h3.c[3].x, h3.c[3].y);
      vertex(h1.p[1].x, h1.p[1].y);
      vertex(h1.c[1].x, h1.c[1].y);
      endShape(CLOSE);
    }
  }
}
