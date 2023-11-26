class Particle{
  PVector pos;
  PVector vel;
  float strength = 100;
  int colourIx = 0;
  Particle(PVector pos_, PVector vel_){
    pos = pos_.copy();
    vel = vel_.copy();
  }
  
  void update(){
    pos.add(vel);
    strength -= soundDropOffAmbient;
    strength = max(0, strength); // strength shouldn't drop to below zero
  }
  
  void bounce(float lbx, float rbx, float uby, float bby){
    if(pos.x <= lbx || pos.x >= rbx){
      vel.x = -vel.x;
      strength -= 1;
      colourIx = (colourIx + 1)%colours.length;
    }
    if(pos.y <= uby || pos.y >= bby){
      vel.y = -vel.y;
      strength -= 1;
      colourIx = (colourIx + 1)%colours.length;
    }
  }
  
  void show(){
     int opacity = int(map(strength, 0, 100, 0, maxOpacity));
     stroke(color(colours[colourIx], opacity));
     point(pos.x, pos.y);
  
  }
}
