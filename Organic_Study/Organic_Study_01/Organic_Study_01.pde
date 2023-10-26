// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
//I want to mimic a lava lamp. First step is getting two objects to seamlessly form
String sketchname = getClass().getName();
int res = 25;
ArrayList<PVector> globPts;
int blobCount = 2;

Blob[] blobs;
float globA = 0;
float r;
void setup() {
  size(1080, 1080);
  blobs = new Blob[blobCount];
  blobs[0] = new Blob(0, 0, 0.25*width, 0);
  blobs[1] = new Blob(0, 0, 0.25*width, PI);
  globPts = new ArrayList<>();
  noStroke();
}

void draw() {
  background(0);
  for (Blob b : blobs) {
    b.update();
    //b.show();
  }
  
  globPts = new ArrayList<PVector>();

  // starting with the rightmost point
  for (int i = 0; i < blobCount; i++) {
    // note: curved vertexes need to wrap around... but we can just use the first couple of points from this list?
    // I want to collect all the
    for (int j = i; j < blobCount; j++) {

      // if comparing to self, continue
      if (i == j) {
        continue;
      }

      //if there's no interaction between the blobs, continue
      if (PVector.dist(blobs[i].pos, blobs[j].pos) > blobs[i].r + blobs[j].r) {
        continue;
      }

      // add all the points from blob[i] that are NOT in blob[j]
      //for(int k = 0; k < blobs[i].pts.length; k++){
      for (int k = 0; k < res; k++) {
        if (PVector.dist(blobs[i].pts[k], blobs[j].pos) < blobs[j].r) {
          continue;
        }
        globPts.add(blobs[i].pts[k]);
      }
      // add all the points from blob[j] that are not in blob[i]
      for (int k = 0; k < res; k++) {
        if (PVector.dist(blobs[j].pts[k], blobs[i].pos) < blobs[i].r) {
          continue;
        }
        globPts.add(blobs[j].pts[k]);
      }
    }
  }
  

  beginShape();
  for(PVector p : globPts){
    vertex(p.x, p.y);
  }
  endShape();

  globA += 0.01;


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
