class FireTrail{
  PVector pos;
  int opacity = 255;
  FireTrail(float x, float y){
    pos = new PVector(x,y);
  }
  
  void update(){
    fill(255,0,0,opacity);
    opacity -= 10;
  }

  void show(){
    ellipse(pos.x, pos.y, nodeS, nodeS);
  }
}
