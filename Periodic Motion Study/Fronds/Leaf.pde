class Leaf {
  PVector start, end, left, right;
  float a;
  float R;
  float r;
  float offset;
  float scale;
  float threshold;
  //color strokeCol;
  color col;
  float rs;
  
  Leaf(float scale_, float offset_, float threshold_, color col_) {
    a = -HALF_PI;
    threshold = threshold_;
    scale = scale_;
    R = scale*width/12;
    //rs = scale*width/64;
    rs = 0;
    r = R/2;
    offset = offset_;
    col = col_;
    //strokeCol = strokeCol_;
    start = new PVector(rs*cos(a), rs*sin(a));
    //end = new PVector(R*cos(a-offset), R*sin(a-offset));
    //left = new PVector(r*cos(a-PI/3-offset), r*sin(a-PI/3-offset));
    //right = new PVector(r*cos(a+PI/3-offset), r*sin(a+PI/3-offset));
     left = new PVector(r*cos(a - PI/4), r*sin(a - PI/4));
     right = new PVector(r*cos(a + PI/4), r*sin(a + PI/4));
     end = new PVector(R*cos(a), R*sin(a));
  }

  void update() {
    if (globA > threshold) {
       
      if(a <= -HALF_PI){
         a = -HALF_PI + PI/6*sin(globA-threshold);
      } else {
         a = -HALF_PI + PI/3*sin(globA-threshold);
      }
     
      //end.set(R*cos(a-offset), R*sin(a-offset));
      //right.set(r*cos(a-PI/3-offset), r*sin(a-PI/3-offset));
      //left.set(r*cos(a+PI/3-offset), r*sin(a+PI/3-offset));
      start.set(rs*cos(a), rs*sin(a));
      end.set(R*cos(a), R*sin(a));
      left.set(r*cos(a - PI/4), r*sin(a - PI/4));
      right.set(r*cos(a + PI/4), r*sin(a + PI/4));
      
    }
  }

  void show() {
    fill(col);
    //stroke(strokeCol);
    noStroke();
    // drawRight
    beginShape();
    curveVertex(start.x, start.y);
    curveVertex(start.x, start.y);
    curveVertex(left.x, left.y);
    curveVertex(end.x, end.y);
    curveVertex(end.x, end.y);
    endShape();
    beginShape();
    curveVertex(start.x, start.y);
    curveVertex(start.x, start.y);
    curveVertex(right.x, right.y);
    curveVertex(end.x, end.y);
    curveVertex(end.x, end.y);
    endShape();    
  }
}
