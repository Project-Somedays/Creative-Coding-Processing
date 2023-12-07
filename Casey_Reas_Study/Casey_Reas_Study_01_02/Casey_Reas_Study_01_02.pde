/*
Wrap off
Starting angles range from -120 to -60 degrees
*/

// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
Mover[] swarm;
int n = 100;
float proximity;
color[] colours = {#d9ed92, #b5e48c, #99d98c, #76c893, #52b69a, #34a0a4, #168aad, #1a759f, #1e6091, #184e77};
//color[] colours = {#f72585, #b5179e, #7209b7, #560bad, #480ca8, #3a0ca3, #3f37c9, #4361ee, #4895ef, #4cc9f0};
void setup(){
    size(1080,1080, P2D);
    background(0);
    swarm = new Mover[n];
    for(int i = 0; i < n; i++){
      int col = colours[int(random(colours.length))];
      float a = random(-TWO_PI/3, -PI/3);
      swarm[i] = new Mover(width/2, height/2, PVector.fromAngle(a), color(col,10));
    }
    noFill();
    proximity = height/12;
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

  if (frameCount ==  500) {
    saveFrame("../" + sketchname + ".png");
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
