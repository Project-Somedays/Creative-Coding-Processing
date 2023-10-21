/*
Author: ProjectSomedays
Experimenting with making the brush a spiral pattern of particles
Now it's like they are bugs floating around a lantern. Getting shocked sends them to a firey grave.
*/
Particle[] swarm;
Electrode[] electrodes;
float globA = 0;
float globARate = 0.01;
int n = 80;
int eN = 10;
float nodeS = 10;
float los;
// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
PVector gravity;
float gravStrength = 0.1;
int trailFadeRate = 1;
int trailFadeDelta = 120;


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
    los = width/6;
    fill(255);
    stroke(255,100);
    strokeWeight(3);
    gravity = new PVector(0, gravStrength);

}

void draw(){
  background(0);
  fill(255,100);
  for(Particle p : swarm){
    p.update();
    p.show();
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
      stroke(255, 200);
      if(d < los){
        line(e.pos.x, e.pos.y, p.pos.x, p.pos.y);
        p.kill();
        // now see if we get a secondary connection
        stroke(255,100);
        for(int i = 0; i < swarm.length; i++){
          if(PVector.dist(p.pos, swarm[i].pos) <  los*0.75){
            line(p.pos.x, p.pos.y, swarm[i].pos.x, swarm[i].pos.y);
            swarm[i].kill();
          } 
        }
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
