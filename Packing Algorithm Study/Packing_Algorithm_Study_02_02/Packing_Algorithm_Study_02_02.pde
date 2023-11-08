/*Starting with the most basic:
 Spawn arrows following a 2D perlin noise flowfield
 Draw larger arrows on top to give the impression of depth
 Increase opacity by size
 */
 
import java.util.Collections;

// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
String sketchname = getClass().getName();
ArrayList<Arrow> swarm;
//color[] colours = {#870058, #a4303f, #f2d0a4, #ffeccc, #c8d6af};
//color[] colours = {#80870058, #80a4303f, #80f2d0a4, #80ffeccc, #80c8d6af};
color[] colours=  {#f94144, #f3722c, #f8961e, #f9844a, #f9c74f, #90be6d, #43aa8b, #4d908e, #577590, #277da1};
float[][] flowField;
float step = 0.0005;
float yOff, xOff;
int additionalArrowsPerFrame = 5;


void setup() {
  size(1080, 1080);
  ellipseMode(RADIUS);
  swarm = new ArrayList<Arrow>();
  //noFill();
  noStroke();
 
  flowField = new float[width][height];
  yOff = 0;
  xOff = 0;
  for(int i = 0; i < width; i++){
    for(int j = 0; j < height; j++){
      flowField[i][j] = TWO_PI*noise(xOff, yOff);
      yOff += step;
    }
    xOff += step;
  }
}

void draw() {
  background(0);
  //for(int i = 0; i < width; i++){
  //  for(int j = 0; j < height; j++){
  //    int visfill = int(map(flowField[i][j], 0, TWO_PI, 0, 255));
  //    fill(visfill);
  //    rect(i,j,1,1);
  //  }
  //}
   //every 20 frames, add another circle
  if (frameCount%2 == 0) {
    for(int i = 0; i < additionalArrowsPerFrame; i++){
      spawnArrow();
    }
  }
  //update
  for (int i = 0; i < swarm.size(); i++) {
    for (int j = 0; j < swarm.size(); j++) {
      if (i == j) {
        continue;
      }
      if (PVector.dist(swarm.get(i).pos, swarm.get(j).pos) <= 0.75*(swarm.get(i).r + swarm.get(j).r)) {
        swarm.get(i).detectCollision();
        swarm.get(j).detectCollision();
        break;
      }
    }
    swarm.get(i).update();
  }
  
  Collections.sort(swarm);
  
  for(Arrow a: swarm){
    a.show();
  }
  



  if (frameCount ==  600) {
    saveFrame("../" + sketchname + ".png");
  }
}

void spawnArrow() {
  float x = random(width);
  float y = random(height);
   swarm.add(new Arrow(x,y, flowField[int(y)][int(x)]));
  //// make 100 attempts
  //int attempts = 0;
  //while (attempts < 100) {
  //  float x = random(width);
  //  float y = random(height);
  //  boolean isOutsideAllBubbles = true;
  //  //cheecking
  //  for (int i = 0; i < swarm.size(); i++) {
  //    // if the point lies inside another bubble, stop
  //    if (dist(x, y, swarm.get(i).pos.x, swarm.get(i).pos.y) < swarm.get(i).r) {
  //      attempts ++;
  //      isOutsideAllBubbles = false;
  //      break;
  //    }
  //  }
  //  if (isOutsideAllBubbles) {
  //    swarm.add(new Arrow(x, y));
  //    return;
  //  }
  //}
}

void keyPressed() {
  if (keyCode == ' ') {
    noLoop();
    saveFrame(sketchname + "_" + year()+"-"+month()+"-"+day()+"_"+hour()+"-"+minute()+"-"+second() + ".png");
  }
}

color setAlpha(int hexColor, int alphaValue) {
  int red = (hexColor >> 16) & 0xFF;
  int green = (hexColor >> 8) & 0xFF;
  int blue = hexColor & 0xFF;
  return color(red, green, blue, alphaValue);
}

color hexToRgb(String hexValue, int alpha) {
  int hexNumber = unhex(hexValue); // Convert the hexadecimal string to an integer
  int r = (hexNumber >> 16) & 0xFF; // Extract the red component
  int g = (hexNumber >> 8) & 0xFF;  // Extract the green component
  int b = hexNumber & 0xFF;         // Extract the blue component
  return color(r, g, b, alpha);            // Create a color object and return it
}
