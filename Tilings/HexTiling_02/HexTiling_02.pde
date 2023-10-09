// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
float r;
int hexRows, hexCols;
Hex[][] hexGrid;
//color[] colours = {#C30FFF, #0D21DE, #1BE3F5, #0DDE38, #D6FB1A};
color[] colours = {#57C382, #FFE938, #FEA008, #F25A00, #DB1500, #AE1100};
//Hex[] hexCol, hexCol2;
int colourCycler;

void setup() {
  size(720, 720);
  hexRows = 31;
  hexCols = 31;
  r = width / ((hexCols-1)*2*cos(PI/6));
  colourCycler = 0;
  hexGrid = new Hex[hexCols][hexRows];
  for (int j = 0; j < hexRows; j++) {
    hexGrid[0][j] = new Hex(0, j*2*r, colours[colourCycler%colours.length]);
    colourCycler += 1;
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
      hexGrid[i][j] = new Hex(x, y, colours[colourCycler%colours.length]);
      colourCycler += 1;
    }
    isBelow = !isBelow;
  }
  //r = 50;
  //hexCol = new Hex[hexRows + 1];
  //for(int i = 0; i < hexCol.length; i++){
  //  hexCol[i] = new Hex(0, i*2*r, #FFFFFF);
  //}
  //hexCol2 = new Hex[hexRows + 1];
  //for(int i = 0; i < hexCol.length; i++){
  //  float x = hexCol[i].pos.x + 2*r*cos(PI/6);
  //  float y = hexCol[i].pos.y + 2*r*sin(PI/6);
  //  hexCol2[i] = new Hex(x, y, #FFFFFF);
  //}
  // draw once and save the image
  noStroke();
  background(0);
  for (int i = 0; i < hexCols; i++) {
    for (int j = 0; j < hexRows; j++) {
      hexGrid[i][j].show();
    }
  }
  save("HexTiling.png");
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
    }
  }
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}
