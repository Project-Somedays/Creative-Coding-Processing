class Arrow {
  color col;
  PVector pos;
  float r = 1;
  float a;

  boolean stillGrowing = true;

  Arrow(float x, float y, float a_) {
    col = colours[int(random(colours.length))];
    a = a_;
    pos = new PVector(x, y);
  }
  
  void detectCollision(){
    stillGrowing = false;
  }

  void update() {
    if (stillGrowing) {
      r += 2;
    }
  }

  void show() {
    //stroke(col);
    fill(col);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    beginShape();
    vertex(r,0);
    vertex(0.5*r*cos(TWO_PI/3), 0.5*r*sin(TWO_PI/3));
    vertex(0.5*r*cos(2*TWO_PI/3), 0.5*r*sin(2*TWO_PI/3));
    endShape(CLOSE);
    //ellipse(pos.x, pos.y, r, r);
    popMatrix();
  }
}
