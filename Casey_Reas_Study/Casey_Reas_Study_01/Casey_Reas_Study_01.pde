// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
Mover[] swarm;
int n = 100;
float proximity;

void setup(){
    size(1920,1080, P2D);
    background(0);
    swarm = new Mover[n];
    for(int i = 0; i < n; i++){
      int col = int(random(50, 200));
      swarm[i] = new Mover(random(width), height/2, PVector.random2D(), color(col,5));
    }
    noFill();
    proximity = height/5;
}

void draw(){
  //background(0);
  for(int i = 0; i < swarm.length; i++){
    swarm[i].update();
    //swarm[i].show();
    for(int j= i; j < swarm.length; j++){
      if(i == j){
        continue;
      }
      float d = PVector.dist(swarm[i].pos, swarm[j].pos);
      if(d < proximity){
        PVector a2b = PVector.sub(swarm[i].pos, swarm[j].pos);
        float repulseStrength = map(d, 0, proximity, 0.5, 0.01);
        swarm[i].applyForce(a2b.setMag(repulseStrength));
        swarm[j].applyForce(a2b.setMag(-repulseStrength));
        swarm[i].showLine(swarm[j].pos);
      }
    }
  }

  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
