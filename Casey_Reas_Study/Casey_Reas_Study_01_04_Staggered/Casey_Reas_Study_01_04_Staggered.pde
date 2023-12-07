/*
Wrap off
Starting angles range from -120 to -60 degrees
Add 5 per frame
*/

// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
//Mover[] swarm;
ArrayList<Mover> swarm;
int nPerFrame = 2;
float proximity;
float globA = 0;
//color[] colours = {#d9ed92, #b5e48c, #99d98c, #76c893, #52b69a, #34a0a4, #168aad, #1a759f, #1e6091, #184e77};
color[] colours = {#f72585, #b5179e, #7209b7, #560bad, #480ca8, #3a0ca3, #3f37c9, #4361ee, #4895ef, #4cc9f0};
void setup(){
    size(1080,1080, P2D);
    background(0);
    //swarm = new Mover[n];
    swarm = new ArrayList<Mover>();
    
    noFill();
    proximity = height/50;
}

void draw(){
  //background(0);
  if(frameCount%10 == 0){
    spawn(nPerFrame);
  }
  
  for(int i = 0; i < swarm.size(); i++){
    swarm.get(i).update();
    //swarm[i].show();
    for(int j= i; j < swarm.size(); j++){
      if(i == j){
        continue;
      }
      float d = PVector.dist(swarm.get(i).pos, swarm.get(i).pos);
      if(d < proximity){
        PVector a2b = PVector.sub(swarm.get(i).pos, swarm.get(i).pos);
        float repulseStrength = map(d, 0, proximity, 0.5, 0.01);
        swarm.get(i).applyForce(a2b.setMag(repulseStrength));
        swarm.get(j).applyForce(a2b.setMag(-repulseStrength));
        swarm.get(i).showLine(swarm.get(j).pos);
      }
    }
  }
  
  for(int i = swarm.size() - 1; i >= 0; i--){
    if(isOffScreen(swarm.get(i).pos)){
      swarm.remove(i);
    }
  }

  if (frameCount ==  500) {
    saveFrame("../" + sketchname + ".png");
  }
}

boolean isOffScreen(PVector pos){
  return pos.x < -proximity || pos.x > width + proximity || pos.y < -proximity || pos.y > height + proximity;
}

void spawn(int n){
  for(int i = 0; i < n; i++){
      int col = colours[int(random(colours.length))];
      //float a = random(-PI/6, PI/6);
      //swarm.add(new Mover(width/2, height/2, PVector.fromAngle(a), color(col,10)));
      swarm.add(new Mover(width/2, height/2, PVector.fromAngle(globA), color(col,10)));
      globA += 0.1;
    }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
