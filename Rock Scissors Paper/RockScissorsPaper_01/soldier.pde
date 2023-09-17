class Soldier {
  PVector pos;
  PVector vel;
  Army army;
  PVector closestPreyPos;
  PVector closestPredatorPos;
  PImage img;
  Soldier(float x, float y, Army army_) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    army = army_;
  }

  void survey() {
    closestPreyPos = findClosest(hunting.get(army), true);
    closestPredatorPos = findClosest(huntedBy.get(army), false);
  }

  void orientate() {
    float predatorDist = PVector.dist(closestPredatorPos, pos);
    float preyDist = PVector.dist(closestPreyPos, pos);

    // if the predator gets too close, run away
    if (predatorDist <= DANGERZONERADIUS) {
      vel = PVector.sub(pos, closestPredatorPos).setMag(fleeSpeed);
    } else {
      // else, pursue
      vel = PVector.sub(closestPreyPos, pos).setMag(chaseSpeed);
    }
  }

  void update() {
    
    pos.add(vel);
    wrap();
    // get eaten
    if (PVector.dist(pos, closestPredatorPos) <= DEATHZONERADIUS) {
      //println("Oooft! " + army.toString() + " is eaten by " + loseTable.get(army).toString());
      army = loseTable.get(army);
      //println("Switched to " + army.toString());
    }
  }

  void show() {
    //stroke(255, 0, 0);
    //ellipse(pos.x, pos.y, DEATHZONERADIUS, DEATHZONERADIUS);
    //stroke(255, 255, 0);
    //ellipse(pos.x, pos.y, DANGERZONERADIUS, DANGERZONERADIUS);
    image(imageMap.get(army), pos.x-SOLDIERSIZE/2, pos.y - SOLDIERSIZE/2, SOLDIERSIZE, SOLDIERSIZE);
  }

  PVector findClosest(ArrayList<Soldier> otherList, boolean isHunting) {
    if (otherList.size() == 0) {
      if (isHunting) {
        return new PVector(width/2, height/2); // if no prey remains, head to the middle? Probably should be away from the predators...
      } else {
        return new PVector(-width, -height); // if no predators remain, we'll locate the closest point way off the screen
      }
    }

    PVector closestPos = null;
    float minDistance = MAXDISTANCE;

    for (Soldier other : otherList) {
      float d = PVector.dist(pos, other.pos);
      if (d < minDistance) {
        minDistance = d;
        closestPos = other.pos.copy();
      }
    }
    return closestPos;
  }
  
  void wrap(){
    if(pos.x < -SOLDIERSIZE/2){
      pos.x = width + SOLDIERSIZE/2;
    }
    
     if(pos.x > width + SOLDIERSIZE/2){
      pos.x = -SOLDIERSIZE/2;
    }
    
     if(pos.y < -SOLDIERSIZE/2){
      pos.y = height + SOLDIERSIZE/2;
    }
    
     if(pos.x > height + SOLDIERSIZE/2){
      pos.y = -SOLDIERSIZE/2;
    }
    
  }
  
  
}


//PVector findClosest(ArrayList<Soldier> foreignSoldier) {

//Soldier closestPos = null; // problems will arise when there are no more foreignSoldier
//float minDistance = MAXDISTANCE; // max distance

//for (Soldier obj : foreignSoldier) {
//  float distance = PVector.dist(pos, foreignSoldier.pos);
//  if (distance < MAXDISTANCE && distance < minDistance) {
//    minDistance = distance;
//    closestPos = obj.pos.copy();
//  }
//}

//return closestPos;
