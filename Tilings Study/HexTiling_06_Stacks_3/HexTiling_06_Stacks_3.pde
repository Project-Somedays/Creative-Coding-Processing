// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
color[] colours = {#d9ed92, #b5e48c, #99d98c, #76c893, #52b69a, #34a0a4, #168aad, #1a759f, #1e6091, #184e77};
String sketchname = getClass().getName();
color[] palette;
int n = 100;
int adjN;
Hex[][] grid;
float r, hl, R;
float fsf = 1; //fore-shortening factor
float zoomFactor = 300;
float xShift = 0;
float yShift = 0;
float shiftSpeed = 1/zoomFactor;
float tSpeed = 0.005;
float t;


void setup() {
  size(1080, 1000);
  palette = reverse(colours);
  adjN = int(1.2*n/fsf);
  grid = new Hex[adjN][n];
  r = width/(2*(n - 1.5));
  R = r/cos(PI/6);
  hl = R*sin(PI/6);
  initGrid();
  
  //println("r: " + r + ", R: " + R + ", hl: " + hl);
}

void draw() {
  background(0);
  drawHexGrid();
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
  t += tSpeed;
  
  xShift ++;
  yShift ++;
}

void keyPressed() {
  if (keyCode == ' ') {
    //noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}

void initGrid() {
  for (int row = 0; row < adjN; row++) {
    for (int col = 0; col < n; col++) {
     float x;
     float y;
      if (row%2 == 0) {
        x = r*(1+ 2*col);
        y = row*(R + hl);
      } else {
        x = col*2*r;
        y = row*(hl + R);
      }
      grid[row][col] = new Hex(x, y);
    }
  }
}

void drawHexGrid() {
  for (int row = 0; row < adjN; row++) {
    for (int col = 0; col < n; col++) {
      grid[row][col].update();
      grid[row][col].show();
    }
  }
}
