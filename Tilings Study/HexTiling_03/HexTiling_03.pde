// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
float r;
int hexRows, hexCols;
Hex[][] hexGrid;
//color[] colours = {#C30FFF, #0D21DE, #1BE3F5, #0DDE38, #D6FB1A};
color[] colours = {#57C382, #FFE938, #FEA008, #F25A00, #DB1500, #AE1100};
//Hex[] hexCol, hexCol2;
int colourCycler;
int totalFrames;

void setup() {
  size(720, 720);
  hexRows = 31;
  hexCols = 31;
  totalFrames = 31*4;
  r = width / ((hexCols-1)*2*cos(PI/6));
  colourCycler = 0;
  hexGrid = new Hex[hexCols][hexRows];
  for (int j = 0; j < hexRows; j++) {
    hexGrid[0][j] = new Hex(0, j*2*r, colourCycler);
    colourCycler = (colourCycler + 1)%colours.length;
  }
  
  boolean isBelow = true;
  for (int i = 1; i < hexCols; i++) {
    float angle;
    if (isBelow) {
      angle = PI/6;
    } else {
      angle = -PI/6;
    }
    for (int j = 0; j < hexRows; j++) {
      float x = hexGrid[i-1][j].pos.x + 2*r*cos(angle);
      float y = hexGrid[i-1][j].pos.y + 2*r*sin(angle);
      hexGrid[i][j] = new Hex(x, y, colourCycler);
      colourCycler = (colourCycler + 1)%colours.length;
    }
    isBelow = !isBelow;
  }

  noStroke();
  background(0);
  for (int i = 0; i < hexCols; i++) {
    for (int j = 0; j < hexRows; j++) {
      hexGrid[i][j].show();
    }
  }
  //save("HexTiling.png");
}

void draw() {
  background(0);
  //for(int i = 0; i < hexCol.length; i++){

  //}
  //for(Hex h: hexCol){
  //  h.show();
  //}
  //for(Hex h: hexCol2){
  //  h.show();
  //}
  for (int i = 0; i < hexCols; i++) {
    for (int j = 0; j < hexRows; j++) {
      hexGrid[i][j].show();
      if (frameCount%5 == 4) {
        hexGrid[i][j].update();
      }
    }
  }
  //if(frameCount < totalFrames){
  //  saveFrame("output/gif-####.png");
  //} else {
  //  noLoop();
  //}
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
  
}
