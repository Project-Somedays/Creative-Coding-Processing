class Shape{
  PVector pos;

  Shape(float x, float y){
    pos = new PVector(x,y);
  }
  
  void update(){
  
  }
  
  void show(){
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(a);
      fill(255,0,0);
      ellipse(pos.x, pos.y - currentSep/2, currentD, currentD);
      fill(0,255,0);
      ellipse(pos.x, pos.y + currentSep/2, currentD, currentD);
    popMatrix();
  }
  
  
}
