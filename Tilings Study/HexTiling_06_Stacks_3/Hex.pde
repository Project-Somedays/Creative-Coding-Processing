class Hex{
  PVector pos;
  color col;
  float nVal;
  float h;
  PVector[] corners;
  Hex(float x_, float y_){
    pos = new PVector(x_,y_);
    corners = new PVector[6];
    for(int i = 0; i < 6; i++){
      float a = i*TWO_PI/6+PI/6;
      float x = pos.x + R*cos(a);
      float y = pos.y + fsf*R*sin(a);
      corners[i] = new PVector(x,y);
    }
    
  }
  
  void update(){
    nVal = noise((pos.x+xShift)/zoomFactor, (pos.y+yShift)/zoomFactor, t);
    h = map(nVal,0,1,0,height/8);
    col = palette[int(map(nVal, 0, 1, 0, colours.length))];
  }
  void show(){
    fill(col);
    beginShape();
    for(int i = 0; i < corners.length; i++){
      float x = corners[i].x;
      float y = corners[i].y - h;
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
