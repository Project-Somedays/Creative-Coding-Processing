class Hex{
  PVector pos;
  color col;
  float nVal;
  float h;
  Hex(float x, float y){
    pos = new PVector(x,y);
  }
  
  void update(){
    nVal = noise(pos.x*zoomFactor, pos.y*zoomFactor, t);
    h = map(nVal,0,1,0,height/8);
    col = palette[int(map(nVal, 0, 1, 0, colours.length))];
  }
  void show(){
    fill(col);
    beginShape();
    for(int i = 0; i < 6; i++){
      float a = i*TWO_PI/6+PI/6;
      float x = pos.x + R*cos(a);
      float y = pos.y + fsf*R*sin(a) - h;
      vertex(x,y);
    }
    endShape(CLOSE);
    
    ////LH Rhombus
    //beginShape();
    //vertex(pos.x - r, pos.y + fsf*hl);
    //vertex(pos.x - r, pos.y + 2*hl);
    //vertex(pos.x, pos.y + R);
    //vertex(pos.x, pos.y + fsf*R);
    //endShape(CLOSE);
    
    ////RH Rhombus
    //beginShape();
    //vertex(pos.x + r, pos.y);
    //vertex(pos.x + r, pos.y + 0.5*hl);
    //vertex(pos.x, pos.y + R);
    //vertex(pos.x, pos.y + 0.5*R);
    //endShape(CLOSE);
  }
}
