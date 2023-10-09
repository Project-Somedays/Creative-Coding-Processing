class Hex{
  PVector pos;
  int colIx;
  Hex(float x, float y, int colIx_){
    pos = new PVector(x,y);
    colIx = colIx_;
  }
 
  void update(){
    colIx = (colIx + 1)%colours.length;
  }
  
  void show(){
    fill(colours[colIx]);
    beginShape();
    for(int i = 0; i < 6; i++){
      float x = pos.x + r*cos(i*TWO_PI/6);
      float y = pos.y + r*sin(i*TWO_PI/6);
      vertex(x,y);
    }
    endShape();
  }
  
}
