class Pendulum{
  PVector pos;
  float aVel;
  float aAcc;
  PVector anchor;
  float theta, r;
  PVector tension;
  PVector centripetal;
  float a;
  PVector vel;
  
  Pendulum(float aX, float aY, float l_, float a_){
    anchor = new PVector(aX, aY);
    a = a_;
    r = l_;
    pos = new PVector(anchor.x + r*sin(a), anchor.y + r*cos(a));
    aVel = 0;
    aAcc = 0;
    theta = 0;
    tension = new PVector(0,0);
    vel = new PVector(0,0);
    
    //centripetal = new PVector(0,0);
    
    
  }
  
  void update(){
    aAcc = -gravStrength*sin(a);
    aVel += aAcc;
    a += aVel;
    pos.set(anchor.x + r*sin(a), anchor.y + r*cos(a));
    vel.set(r*cos(aVel), r*sin(aVel));
    aVel *= 0.999;
  }
  

  void show(){
     //show anchor
     ellipse(anchor.x, anchor.y, 10, 10);
     stroke(255);
     line(anchor.x, anchor.y, pos.x, pos.y);
     noStroke();
     ellipse(pos.x, pos.y, 25, 25);

     
  }
}
