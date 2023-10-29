// auto thumbnail generation script: https://timrodenbroeker.de/courses/sketching-with-code/thumbnails/
//I want to mimic a lava lamp. First step is getting two objects to seamlessly form.
//Now I want to experiment with having the points on springs
import java.util.Collections;
import java.util.Comparator;


String sketchname = getClass().getName();
int res = 40;
ArrayList<PVector> globPts;
int blobCount = 2;
PVector centre;

Blob[] blobs;
float globA = 0;
float r;
void setup() {
  size(1080, 1080);
  blobs = new Blob[blobCount];
  blobs[0] = new Blob(0, 0, 0.25*width, 0);
  blobs[1] = new Blob(0, 0, 0.2*width, PI);
  globPts = new ArrayList<>();
  noStroke();
  centre = new PVector(width/2, height/2);
}

void draw() {
  background(0);
  for (Blob b : blobs) {
    b.update();
    b.show();
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
        if (PVector.dist(blobs[i].pts[k].pos, blobs[j].pos) < blobs[j].r) {
          continue;
        }
        globPts.add(blobs[i].pts[k].pos);
      }
      // add all the points from blob[j] that are not in blob[i]
      for (int k = 0; k < res; k++) {
        if (PVector.dist(blobs[j].pts[k].pos, blobs[i].pos) < blobs[i].r) {
          continue;
        }
        globPts.add(blobs[j].pts[k].pos);
      }
    }
  }

  sortPointsByPolar(globPts);
  if (globPts.size() > 3) {
    globPts.add(globPts.get(0));
    globPts.add(globPts.get(1));
    globPts.add(globPts.get(2));
  }

  //if (globPts.size() > 10) {
  //  beginShape();
  //  for (PVector p : globPts) {
  //    curveVertex(p.x, p.y);
  //    ellipse(p.x, p.y, 5, 5);
  //  }
  //  endShape();
  //}




  globA += 0.005;


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

void sortPointsByPolar(ArrayList<PVector> points) {
  Collections.sort(points, new PolarComparator());
}

class PolarComparator implements Comparator<PVector> {
  @Override
    public int compare(PVector a, PVector b) {
    float angleA = atan2(a.y - height / 2, a.x - width / 2);
    float angleB = atan2(b.y - height / 2, b.x - width / 2);

    // Compare angles
    if (angleA < angleB) {
      return -1;
    } else if (angleA > angleB) {
      return 1;
    } else {
      // If angles are equal, compare distances
      float distA = dist(a.x, a.y, width / 2, height / 2);
      float distB = dist(b.x, b.y, width / 2, height / 2);

      if (distA < distB) {
        return -1;
      } else if (distA > distB) {
        return 1;
      } else {
        return 0;
      }
    }
  }
}
