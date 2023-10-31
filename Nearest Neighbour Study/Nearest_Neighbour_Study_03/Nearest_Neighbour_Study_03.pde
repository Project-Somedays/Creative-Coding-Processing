/*
Author: ProjectSomedays
Experimenting with transparency and just randomly generating points
*/
Particle[] swarm;
int n = 50;
float nodeS = 10;
float los;
// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
float fov;
float cameraZ;


void setup(){
    size(1000,1000,P3D);
    swarm = new Particle[n];
    for(int i = 0; i < n; i++){
      swarm[i] = new Particle(random(width), random(height), random(width));
    }
    los = width/4;
    fill(255);
    stroke(255,100);
    strokeWeight(2);
    fov = THIRD_PI;
    cameraZ = (height/2.0) / tan(fov/2.0);
    perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
    directionalLight(0, 255, 0, 0, -1, 0);
    noFill();
}

void draw(){
  background(0);
  box(width/2);
  camera(mouseX, 0, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  translate(0, 0, -1000);
  
  
  for(Particle p : swarm){
    p.update();
    p.show();
  }
  
  for(int i = 0; i < n; i++){
    // no need to check those links already ahead
    for(int j = i; j < n; j++){
      // if self-check, move on
      if(i == j){
        continue;
      }
      
      float d = PVector.dist(swarm[i].pos, swarm[j].pos);
      //PVector btw = PVector.sub(swarm[j].pos, swarm[i].pos);
      
      if(d < los){
        line(swarm[i].pos.x, swarm[i].pos.y, swarm[i].pos.z,  swarm[j].pos.x, swarm[j].pos.y,swarm[j].pos.z);
        //for(int k = 0; k < 50; k++){
        //  float randD = random(0, d);
        //  PVector pt = PVector.add(swarm[i].pos, btw.setMag(randD));
        //  point(pt.x, pt.y);
        //}
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
