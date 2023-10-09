class Hex{
  PVector pos;
  color c;
  Hex(float x, float y, color c_){
    pos = new PVector(x,y);
    c = c_;
  }
  
  void show(){
    fill(c);
    beginShape();
    for(int i = 0; i < 6; i++){
      float x = pos.x + r*cos(i*TWO_PI/6);
      float y = pos.y + r*sin(i*TWO_PI/6);
      vertex(x,y);
    }
    endShape();
  }
  
}
