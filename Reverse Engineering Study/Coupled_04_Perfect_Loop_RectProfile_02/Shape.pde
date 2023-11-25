class Shape{
  PVector pos;
  boolean isOffScreen = false;
  float w;
  float h;
  float a;
  float sep;

  Shape(float x, float y, float w_, float h_, float sep_, float a_){
    pos = new PVector(x,y);
    w = w_;
    h = h_;
    sep = sep_;
    a = a_;
  }
  
  void update(){
    pos.x --;
    if(pos.x < -sep - h){
      isOffScreen = true;
    }
  }
  
  void show(){
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(a + globA);
      for(int i = 0; i < colours.length; i++){
        rotate(TWO_PI/colours.length);
        stroke(colours[i]);
        rect(0, sep, w, h);
      }
    popMatrix();
  }
  
  
}
