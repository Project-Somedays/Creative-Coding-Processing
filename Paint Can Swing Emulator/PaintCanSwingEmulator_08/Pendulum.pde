class Pendulum{
  PVector pos;
  PVector vel;
  PVector acc;
  PVector anchor;
  float theta, r;
  PVector tension;
  PVector centripetal;
  
  Pendulum(float aX, float aY, float l_, float a){
    anchor = new PVector(aX, aY);
    pos = new PVector(anchor.x + l_*cos(a), anchor.y + l_*sin(a));
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    theta = 0;
    tension = new PVector(0,0);
    r = l_;
    //centripetal = new PVector(0,0);
    
    
  }
  
  void applyForce(){
    float r = PVector.dist(anchor, pos);
    float tensionStr = sq(vel.mag())/r + gravity.mag()*cos(theta);
    tension = PVector.sub(anchor, pos).setMag(tensionStr);
    acc.add(tension);
    acc.add(gravity);
  }
  
  void update(){
    theta = PVector.angleBetween(anchor, pos);
    applyForce();
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void show(){
     //show anchor
     ellipse(anchor.x, anchor.y, 10, 10);
     line(anchor.x, anchor.y, pos.x, pos.y);
     ellipse(pos.x, pos.y, 25, 25);
     text("Length: " + round(PVector.dist(anchor, pos)), width/2, height*0.1);
     //text("Theta: " + theta, width/2, height*0.2);
     
     // show gravity
     stroke(255,0,0);
     line(pos.x, pos.y, pos.x + gravity.x, pos.y + gravity.y);
     // show tension
     stroke(0,255,0);
     line(pos.x, pos.y, pos.x + tension.x, pos.y + tension.y);
     
     
     stroke(255);
    
  }
}
