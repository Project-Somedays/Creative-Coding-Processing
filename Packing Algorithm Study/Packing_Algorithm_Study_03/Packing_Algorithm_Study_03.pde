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
float maxR;

void setup() {
  size(1080, 1080);
  maxR = width/10;
  ellipseMode(RADIUS);
  noFill();
  strokeWeight(strWeight);

  // start with a random bubble out from the border with itself as parent
  bubbles = new ArrayList<Bubble>();
  bubbles.add(new Bubble( random(0.25*width, 0.5*width), random(0.25*height, 0.5*height), new PVector(0, 0), colours[int(random(colours.length))]));
  bubbles.add(new Bubble( random(0.25*width, 0.5*width), random(0.5*height, 0.75*height), new PVector(0, 0), colours[int(random(colours.length))]));
  bubbles.add(new Bubble( random(0.5*width, 0.75*width), random(0.25*height, 0.5*height), new PVector(0, 0), colours[int(random(colours.length))]));
  bubbles.add(new Bubble( random(0.5*width, 0.75*width), random(0.5*height, 0.75*height), new PVector(0, 0), colours[int(random(colours.length))]));
  bubbles.get(0).setR(random(width/20, width/10));
  bubbles.get(1).setR(random(width/20, width/10));
  bubbles.get(2).setR(random(width/20, width/10));
  bubbles.get(3).setR(random(width/20, width/10));
}

void draw() {
  background(0);

  // every 20 frames, add another circle
  if (frameCount%2 == 0) {
    spawnBubble();
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
      if (PVector.dist(currentBubble.pos, otherBubble.pos) < currentBubble.r + otherBubble.r + 2*strWeight) {
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
  Bubble parent = bubbles.get(ix);
  // get a random2D vector
  PVector dir = PVector.random2D().setMag(parent.r+4*strWeight);
  PVector startPos = parent.pos.copy().add(dir);
  bubbles.add(new Bubble(startPos.x, startPos.y, dir.normalize(), col));
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
