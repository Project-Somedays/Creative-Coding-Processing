// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();

float bigR, sep, r, rippleR, maxR;
Hex[][] grid;
int visCount, count;
float yOff;
int frames = 180;
float rIncrement;
boolean isPlaying;

PVector[][] corners;
PVector c;
float frameDuration;
boolean isRecording;

void setup() {
  size(500, 585);
  isPlaying = false;
  noLoop();
  noFill();
  stroke(0);
  c = new PVector(width/2, height/2);
  count = 16;
  visCount = count - 1;
  rippleR = 1;
  maxR = height/sqrt(2);
  frameDuration = TWO_PI/frames;
  rIncrement = maxR/frames;
  sep = width/(visCount-1);
  bigR = sep/1.5; // circumscribed radius
  r = bigR*cos(PI/6); //inscribed radius

  //yOff = spacing/2*cos(PI/6);
  textAlign(CENTER);
  grid = new Hex[count][count];
  initHexGrid();
  isRecording = false;
}

void draw() {
  background(0);
  drawHexes();

  noFill();
  // ellipse(width/2, height/2, 2*rippleR, 2*rippleR);
  if (rippleR < maxR) {
    rippleR += rIncrement;
  }

  // fill(255);
  // text(grid[8][8].a, grid[8][8].pos.x, grid[8][8].pos.y);
  if (frameCount > 10 && grid[8][8].state == 1) {

    isRecording = !isRecording;
  }
  //if(isRecording){
  //  // text("Now Recording", width/2, height/4);
  //  saveFrame("output/gif-####.png");
  //}
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
  //if (frameCount > 200 && grid[8][8].state == 1) {
  //  noLoop();
  //}
}



void initHexGrid() {
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count; j++) {
      if (i%2 == 1) {
        grid[i][j] = new Hex((i-1)*bigR*1.5, (j+0.5 - 1)*2*r);
      } else {
        grid[i][j] = new Hex((i - 1)*bigR*1.5, (j - 1)*2*r);
      }
      // println("(" + i + ", " + j + ")");
    }
  }
}

void drawHexes() {
  for (int i = 0; i < count; i++) {
    for (int j = 0; j < count; j++) {
      grid[i][j].updateHex();
      grid[i][j].showHex();
    }
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    isPlaying = !isPlaying;
  }

  if (isPlaying) {
    loop();
  } else {
    noLoop();
  }
}
