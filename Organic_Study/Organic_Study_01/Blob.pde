class Blob{
  PVector pos;
  float r;
  float offset;
  PVector[] pts;
  Blob(float x, float y, float r_, float offset_){
    r = r_;
    pos = new PVector(x,y);
    offset = offset_;
    pts = new PVector[res+3];
    for(int i = 0; i < pts.length; i++){
      float a = i*TWO_PI/res;
      pts[i] = new PVector(pos.x + r*cos(a), pos.y + r*sin(a));
    }
  }
  
  void update(){
    pos.set(width/2 + 0.25*width*cos(globA + offset), height/2);
    for(int i = 0; i < pts.length; i++){
      float a = i*TWO_PI/res;
      pts[i].set(pos.x + r*cos(a), pos.y + r*sin(a));
    }
  }
  
  void show(){
    for(PVector pt: pts){
      ellipse(pt.x, pt.y, 10, 10);
    }
  }
}
