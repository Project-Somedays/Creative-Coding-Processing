class Tile{
  PVector loc;

  color c;
  Tile(float x, float y, color c_){
    loc = new PVector(x, y);
    c = c_;
  }
  
  void show(){
    fill(c);
    beginShape();
    for(int i = 0; i < 6; i++){
      float x = loc.x + r*cos(i*TWO_PI/6);
      float y = loc.y + r*sin(i*TWO_PI/6);
      vertex(x,y);
    }
    endShape(CLOSE);
  }
}
