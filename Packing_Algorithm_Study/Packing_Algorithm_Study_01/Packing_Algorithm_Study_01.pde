/*Starting with the most basic:
 Randomly spawn a circle somewhere on the screen that sits outside every other circle
 */

// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
ArrayList<Bubble> bubbles;
//color[] colours = {#870058, #a4303f, #f2d0a4, #ffeccc, #c8d6af};
//color[] colours = {#80870058, #80a4303f, #80f2d0a4, #80ffeccc, #80c8d6af};
color[] colours=  {#f94144, #f3722c, #f8961e, #f9844a, #f9c74f, #90be6d, #43aa8b, #4d908e, #577590, #277da1};

void setup() {
  size(1080, 1080);
  ellipseMode(RADIUS);
  bubbles = new ArrayList<Bubble>();
  noFill();
  strokeWeight(2);
}

void draw() {
  background(0);
  // every 20 frames, add another circle
  if (frameCount%2 == 0) {
    spawnBubble();
  }
  //update
  for (int i = 0; i < bubbles.size(); i++) {
    for (int j = 0; j < bubbles.size(); j++) {
      if (i == j) {
        continue;
      }
      if (PVector.dist(bubbles.get(i).pos, bubbles.get(j).pos) <= bubbles.get(i).r + bubbles.get(j).r) {
        bubbles.get(i).detectCollision();
        bubbles.get(j).detectCollision();
        break;
      }
    }
    bubbles.get(i).update();
    bubbles.get(i).show();
  }



  if (frameCount ==  1200) {
    saveFrame("../" + sketchname + ".png");
  }
}

void spawnBubble() {
  // make 100 attempts
  int attempts = 0;
  while (attempts < 100) {
    float x = random(width);
    float y = random(height);
    boolean isOutsideAllBubbles = true;
    //cheecking
    for (int i = 0; i < bubbles.size(); i++) {
      // if the point lies inside another bubble, stop
      if (dist(x, y, bubbles.get(i).pos.x, bubbles.get(i).pos.y) < bubbles.get(i).r) {
        attempts ++;
        isOutsideAllBubbles = false;
        break;
      }
    }
    if (isOutsideAllBubbles) {
      bubbles.add(new Bubble(x, y));
      return;
    }
  }
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}
