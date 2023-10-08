Tile[] tiles;
float r;
color[] colours = {#C30FFF,#0D21DE, #1BE3F5,#0DDE38,#D6FB1A};
int showHowMany;

void setup() {
  size(600, 600);
  r = 25;
  tiles = new Tile[7]; 
  tiles[0] = new Tile(0, 0, colours[0]);
  for (int i = 1; i < tiles.length; i++) {
    float x = 2*r*cos(i*TWO_PI/6+PI/6);
    float y = 2*r*sin(i*TWO_PI/6+PI/6);
    tiles[i] = new Tile(x,y,colours[i%colours.length]);
  }
  showHowMany = 1;
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2, height/2);
  
  for(int i = 0; i < showHowMany; i++){
    tiles[i].show();
  }
  
  //fill(255,0,255);
  popMatrix();
}

void keyPressed(){
  if(keyCode == LEFT){
    showHowMany -= 1;
  } else if(keyCode == RIGHT){
    showHowMany += 1;
  }
}
