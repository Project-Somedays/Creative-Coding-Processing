/*
Author: ProjectSomedays
Experimenting with transparency and just randomly generating points
*/
Particle[] swarm;
int n = 200;
float nodeS = 10;
float los;
// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
int interParticles = 25;

void setup(){
    size(1000,1000);
    swarm = new Particle[n];
    for(int i = 0; i < n; i++){
      swarm[i] = new Particle(random(width), random(height));
    }
    los = width/8;
    fill(255);
    stroke(0,150);
    strokeWeight(2);
}

void draw(){
  background(255);
  for(Particle p : swarm){
    p.update();
    //p.show();
  }
  
  for(int i = 0; i < n; i++){
    // no need to check those links already ahead
    for(int j = i; j < n; j++){
      // if self-check, move on
      if(i == j){
        continue;
      }
      
      float d = PVector.dist(swarm[i].pos, swarm[j].pos);
      PVector btw = PVector.sub(swarm[j].pos, swarm[i].pos);
      
      if(d < los){
        for(int k = 0; k < interParticles; k++){
          float randD = random(0, d);
          PVector pt = PVector.add(swarm[i].pos, btw.setMag(randD));
          point(pt.x, pt.y);
        }
        //line(swarm[i].pos.x, swarm[i].pos.y, swarm[j].pos.x, swarm[j].pos.y);
      }
    }
  }
  
  if (frameCount ==  600) {
    saveFrame("../" + sketchname + ".png");
  }
}



void keyPressed() {
  if (keyCode == ' ') {
    //noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
