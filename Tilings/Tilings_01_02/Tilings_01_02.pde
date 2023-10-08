/*
With the rotation, it doesn't quite line up any more =(
*/

// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
int n = 9;
float padding;
float s;
color bgCol = color(0);
color[] colours = {#012a4a, #013a63, #01497c, #014f86, #2a6f97, #2c7da0, #468faf, #61a5c2, #89c2d9, #a9d6e5};

public enum TileType {H,SideH,O,UUP,UDOWN, ULEFT, URIGHT, PLUS};
float[] rotations = {HALF_PI, PI, 3*HALF_PI, -HALF_PI};

void setup() {
  size(1000, 1000);
  
  padding = 0.2*width/n;
  s = (width-(n+1)*padding)/n;
  stroke(0.5);
  background(bgCol);
  
  //color col = colours[int(random(colours.length))];
  //Tile tile = new Tile(width/2-s/2, height/2-s/2, TileType.UDOWN, col);
  //tile.show();

  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
      color col = colours[int(random(colours.length))];
      TileType tileType = TileType.values()[int(random(TileType.values().length))];
      Tile tile = new Tile(i*(s + padding)+padding, j*(s+padding)+padding, tileType, col);
      tile.show();
    }
  }
  saveFrame("../" + sketchname + ".png");
}

void draw() {

  //if (frameCount ==  120) {
  //  saveFrame("../" + sketchname + ".png");
  //}
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second()+".png");
  }
}
