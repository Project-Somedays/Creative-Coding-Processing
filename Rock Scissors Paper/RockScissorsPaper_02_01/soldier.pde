class Soldier {
  PVector pos;
  PVector vel;
  PVector acc;
  Army army;
  PVector closestPreyPos;
  PVector closestPredatorPos;
  PVector closestAllyPos;
  PImage img;
  boolean isChasing;
  Soldier(float x, float y, Army army_) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0,0);
    army = army_;
    isChasing = false;
  }

  PVector getWrappedPos(WrapDir dir) {
    // search distance if you were to travel North
    switch(dir) {
    case NORTH:
      return new PVector(pos.x, pos.y - height);
    case SOUTH:
      return new PVector(pos.x, pos.y + height);
    case EAST:
      return new PVector(pos.x - width, pos.y);
    case WEST:
      return new PVector(pos.x + width, pos.y);
    default:
      return pos.copy();
    }
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
      acc = PVector.sub(pos, closestPredatorPos).setMag(fleeAcceleration);
      isChasing = false;
      return;
    }

    //if (allyDist < SOLDIERSIZE/2) {
    //  vel = PVector.sub(pos, closestAllyPos).setMag(chaseSpeed);
    //  return;
    //}
    isChasing = true;
    acc = PVector.sub(closestPreyPos, pos).setMag(chaseAcceleration);
  }

  void update() {
    
    pos.add(vel);
    vel.add(acc);
    if(isChasing){
      vel.setMag(min(vel.mag(), MAXSPEEDCHASE));
    } else 
    {
      vel.setMag(min(vel.mag(), MAXSPEEDFLEE));
    }
     // can't beat top speed
    acc.mult(0);
    // handleBoundaries();
    wrap(); // in this version, prey hits a wall
    // get eaten
    if (PVector.dist(pos, closestPredatorPos) <= DEATHZONERADIUS) {
      //println("Oooft! " + army.toString() + " is eaten by " + loseTable.get(army).toString());
      army = loseTable.get(army);
      //println("Switched to " + army.toString());
    }
  }

  void show() {

    switch(army) {
      case ROCK:
        fill(colours[0]);
        break;
      case PAPER:
        fill(colours[1]);
        break;
      case SCISSORS:
        fill(colours[2]);
        break;
      default:
        fill(0);
        break;
    }
    ellipse(pos.x, pos.y, SOLDIERSIZE, SOLDIERSIZE);
  }

  PVector findClosest(ArrayList<Soldier> otherList, Other category) {
    // setting the default behaviour
    switch(category) {
    case PREY:
      if (otherList.size() == 0) {
        return new PVector(width/2, height/2);
      }
      break;

    case PREDATORS:
      if (otherList.size() == 0) {
        return new PVector(-width/2, -height/2);
      }
      break;

    case ALLIES:
      if (otherList.size() == 1) {
        return new PVector(width/2, height/2);
      }
      break;
    }


    PVector closestPos = null;
    float minDistance = MAXDISTANCE;
    float d;

    for (Soldier other : otherList) {
      // if measuring distance to self, skip and start the loop over
      if (pos == other.pos) {
        continue;
      }
      // direct measure
      d = PVector.dist(pos, other.pos);
      if (d < minDistance) {
        minDistance = d;
        closestPos = other.pos.copy();
      }
      // wrap measures
      for (WrapDir wrapDir : WrapDir.values()) {
        PVector wrappedPos = other.getWrappedPos(wrapDir).copy();
        d = PVector.dist(pos, wrappedPos);
        if (d < minDistance) {
          minDistance = d;
          closestPos = wrappedPos;
        }
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

    if (pos.y > height + SOLDIERSIZE/2) {
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
