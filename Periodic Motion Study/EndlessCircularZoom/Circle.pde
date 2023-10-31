class Circle {

  float d, x, y;
  color col;
  float t;
  int multiplier;
  boolean isFinished;

  Circle(color col_,int multiplier_) {
    col = col_;
    isFinished = false;
    multiplier = multiplier_;
  }

  void show() {
    fill(col);
    // stop updating once finished
    if(!isFinished){
      d = D*t/period; 
      x = 0.5*(D-d)*cos(multiplier*t);
      y = 0.5*(D-d)*sin(multiplier*t);
    }
    
    
    ellipse(x, y, d, d);
    t += increment;
    if(t > period){
      isFinished = true;
    }
  }
}
