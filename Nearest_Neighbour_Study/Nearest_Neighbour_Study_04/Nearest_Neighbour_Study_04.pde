/*
Author: ProjectSomedays
Experimenting with making the brush a spiral pattern of particles
*/
Particle[] swarm;
Electrode[] electrodes;
float globA = 0;
float globARate = 0.01;
int n = 80;
int eN = 5;
float nodeS = 10;
float los;
// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();

void setup(){
    size(1000,1000);
    swarm = new Particle[n];
    for(int i = 0; i < n; i++){
      swarm[i] = new Particle(random(width), random(height));
    }
    electrodes = new Electrode[eN];
    for(int i = 0; i < eN; i++){
      electrodes[i] = new Electrode(-TWO_PI + i*2*TWO_PI/eN);
    }
    los = width/8;
    fill(255);
    stroke(255,100);
    strokeWeight(2);
}

void draw(){
  background(0);
  fill(255,100);
  for(Particle p : swarm){
    p.update();
    //p.show();
  }
  fill(255);
  for(Electrode e : electrodes){
    e.update();
    //e.show();
  }
  stroke(255);
  drawConnections();
  globA += globARate;
  
  if (frameCount ==  600) {
    saveFrame("../" + sketchname + ".png");
  }
}

void drawConnections(){
  for(Electrode e : electrodes){
    for(Particle p : swarm){
      float d = PVector.dist(e.pos, p.pos);
      if(d < los){
        line(e.pos.x, e.pos.y, p.pos.x, p.pos.y);
      }
    }
  }
}


void keyPressed() {
  if (keyCode == ' ') {
    //noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
