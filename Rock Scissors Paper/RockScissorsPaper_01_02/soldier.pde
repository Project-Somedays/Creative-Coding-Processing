class Soldier {
  PVector pos;
  PVector vel;
  Army army;
  PVector closestPreyPos;
  PVector closestPredatorPos;
  PVector closestAllyPos;
  PImage img;
  Soldier(float x, float y, Army army_) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    army = army_;
  }

  void survey() {
    closestPreyPos = findClosest(hunting.get(army), Other.PREY);
    closestPredatorPos = findClosest(huntedBy.get(army), Other.PREDATORS);
    closestAllyPos = findClosest(rosters.get(army), Other.ALLIES);
  }

  void orientate() {
    float predatorDist = PVector.dist(closestPredatorPos, pos);
    float preyDist = PVector.dist(closestPreyPos, pos);
    float allyDist = PVector.dist(closestAllyPos, pos);

    // if the predator gets too close, run away
    if (predatorDist <= DANGERZONERADIUS) {
      vel = PVector.sub(pos, closestPredatorPos).setMag(fleeSpeed);
      return;
    }

    if (allyDist < SOLDIERSIZE/2) {
      vel = PVector.sub(pos, closestAllyPos).setMag(chaseSpeed);
      return;
    }

    vel = PVector.sub(closestPreyPos, pos).setMag(chaseSpeed);
  }

  void update() {

    pos.add(vel);
    handleBoundaries();
    //wrap(); // in this version, prey hits a wall
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

  PVector findClosest(ArrayList<Soldier> otherList, Other category) {
    // setting the default behaviour 
    switch(category) {
    case PREY:
      if(otherList.size() == 0){
        return new PVector(width/2, height/2);
      }
      break;

    case PREDATORS:
      if(otherList.size() == 0){
        return new PVector(-width/2, -height/2);
      }
      break;

    case ALLIES:
      if(otherList.size() == 1){
        return new PVector(width/2, height/2);
      }
      break;
    }


    PVector closestPos = null;
    float minDistance = MAXDISTANCE;

    for (Soldier other : otherList) {
      // if measuring distance to self, start the loop over
      if (pos == other.pos) {
        continue;
      }
      float d = PVector.dist(pos, other.pos);
      if (d < minDistance) {
        minDistance = d;
        closestPos = other.pos.copy();
      }
    }
    return closestPos;
  }

  void wrap() {
    if (pos.x < -SOLDIERSIZE/2) {
      pos.x = width + SOLDIERSIZE/2;
    }

    if (pos.x > width + SOLDIERSIZE/2) {
      pos.x = -SOLDIERSIZE/2;
    }

    if (pos.y < -SOLDIERSIZE/2) {
      pos.y = height + SOLDIERSIZE/2;
    }

    if (pos.x > height + SOLDIERSIZE/2) {
      pos.y = -SOLDIERSIZE/2;
    }
  }

  void handleBoundaries() {
    if (pos.x < 0) {
      pos.x = 0;
    }

    if (pos.x > width ) {
      pos.x = width;
    }

    if (pos.y < 0) {
      pos.y = 0;
    }

    if (pos.y > height) {
      pos.y = height;
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
