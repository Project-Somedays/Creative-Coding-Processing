class Shape{
  PVector pos;
  boolean isOffScreen = false;
  float d;
  float sep;

  Shape(float x, float y, float d_, float sep_, float a_){
    pos = new PVector(x,y);
    d = d_;
    sep = sep_;
    a = a_;
  }
  
  void update(){
    pos.x -= 4;
    if(pos.x < -sep - d){
      isOffScreen = true;
    }
  }
  
  void show(){
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(a);
      for(int i = 0; i < colours.length; i++){
        fill(colours[i]);
        ellipse(sep + 0.5*d*cos(i*TWO_PI/colours.length), sep + 0.5*d*sin(i*TWO_PI/colours.length), d, d);
      }
    popMatrix();
  }
  
  
}
