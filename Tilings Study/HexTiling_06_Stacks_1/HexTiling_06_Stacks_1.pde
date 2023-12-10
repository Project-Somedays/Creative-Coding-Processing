// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
int n = 25;
int adjN;
Hex[][] grid;
float r, hl, R;
float fsf = 1; //fore-shortening factor
float zoomFactor = 0.0025;
float t = 0;
float tSpeed = 0.005;


void setup() {
  size(1080, 1000);
  adjN = int(1.2*n/fsf);
  grid = new Hex[adjN][n];
  r = width/(2*(n - 1.5));
  R = r/cos(PI/6);
  hl = R*sin(PI/6);
  initGrid();
  
  println("r: " + r + ", R: " + R + ", hl: " + hl);
}

void draw() {
  background(0);
  drawHexGrid();
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
  t += tSpeed;
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
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
