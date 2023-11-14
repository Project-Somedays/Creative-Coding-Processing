/*
Spawn from the outside of a circle
 */


// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();

//color[] colours = {#870058, #a4303f, #f2d0a4, #ffeccc, #c8d6af};
//color[] colours = {#80870058, #80a4303f, #80f2d0a4, #80ffeccc, #80c8d6af};
color[] colours=  {#f94144, #f3722c, #f8961e, #f9844a, #f9c74f, #90be6d, #43aa8b, #4d908e, #577590, #277da1};

int strWeight = 2;
ArrayList<Bubble> bubbles;
float maxD;
float minSize;

void setup() {
  size(1000, 1000);
  maxD = width/4;
  minSize = width/25;
  noFill();
  strokeWeight(strWeight);

  // start with a random bubble out from the border with itself as parent
  bubbles = new ArrayList<Bubble>();
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j < 6; j++) {
      float x = width/6*(i + 0.5);
      float y = height/6*(j+0.5);
      bubbles.add(new Bubble(x, y, new PVector(0, 0), colours[int(random(colours.length))]));
    }
  }
  for(Bubble b : bubbles){
    b.setD(random(width/20, width/10));
  }
}

void draw() {
  background(0);

  // every 20 frames, add another circle
  if (frameCount%2 == 0) {
    for (int i = 0; i < 5; i++) {
      spawnBubble();
    }
  }

  //update
  for (int i = 0; i < bubbles.size(); i++) {
    Bubble currentBubble = bubbles.get(i);
    currentBubble.update();
    for (int j = i; j < bubbles.size(); j++) {
      Bubble otherBubble = bubbles.get(j);
      // ignore self checks
      if (i == j) {
        continue;
      }
      if (PVector.dist(currentBubble.pos, otherBubble.pos) < 0.5*currentBubble.d + 0.5*otherBubble.d) {
        currentBubble.detectCollision();
        otherBubble.detectCollision();
      }
    }
    currentBubble.show();
  }




  if (frameCount ==  1200) {
    saveFrame("../" + sketchname + ".png");
  }
}

void spawnBubble() {
  // pick a random existing bubble
  color col = colours[int(random(colours.length))];
  int ix = int(random(bubbles.size()));
  // try to find a parent of sufficient size... and still on the board
  int attempts = 0;
  while (attempts < 100) {
    attempts ++;
    Bubble parent = bubbles.get(ix);
    if (parent.d > minSize && isStillOnScreen(parent.pos)) {
      // get a random2D vector
      PVector dir = PVector.random2D().setMag(parent.d/2+ 2*strWeight);
      PVector startPos = parent.pos.copy().add(dir);
      bubbles.add(new Bubble(startPos.x, startPos.y, dir.normalize(), col));
      break;
    }
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}

boolean isStillOnScreen(PVector pos) {
  return pos.x > -maxD && pos.x < width + maxD && pos.y > -maxD && pos.y < height + maxD;
}
