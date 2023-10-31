class Electrode{
  PVector pos;
  float a;
  float r;
  
  
  Electrode(float phase){
    pos = new PVector(0,0);
    a = phase;
  }
  
  void update(){
    r = 0.4*width*sin(0.1*(a+globA));
    pos.set(width/2 + r*cos(a + globA), height/2 + r*sin(a + globA));
  }
  
  
  void show(){
    ellipse(pos.x, pos.y, nodeS, nodeS);
  }
}
