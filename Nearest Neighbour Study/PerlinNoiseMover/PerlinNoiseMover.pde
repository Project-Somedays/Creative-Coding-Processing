color[] colours = {#001219,#005f73,#0a9396,#94d2bd,#e9d8a6,#ee9b00,#ca6702,#bb3e03,#ae2012,#9b2226};
Mover m;
Mover[] swarm;
float r;
void setup(){
  size(1000, 1000);
  r = 15;
  swarm = new Mover[50];
  for(int i = 0; i < swarm.length; i++){
    swarm[i] = new Mover(i);
  }
  ellipseMode(RADIUS);
  background(0);
}

void draw(){
  //background(0);
  for(Mover m: swarm){
    m.update();
    m.show();
  }
}

void keyPressed(){
  if(keyCode == ' '){
    save("Perlin Swarm.png");
    noLoop();
  }
}
