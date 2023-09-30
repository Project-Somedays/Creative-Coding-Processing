/*
In this version, there IS wrapping and no overlap
Things can decide whether they want to chase through the wall or not 
 */

import java.util.HashMap;

enum Army {
  ROCK,
    PAPER,
    SCISSORS
}

enum Other {
  PREY,
  PREDATORS,
  ALLIES
}

enum WrapDir{
  NORTH,
  SOUTH,
  EAST,
  WEST
}

String sketchname = getClass().getName();
float MAXDISTANCE;
float SOLDIERSIZE;
Soldier[] battlefield;
int SOLDIERSPERTEAM = 150;
int BATTLEFIELDSIZE;
Army[] armies = {Army.ROCK, Army.PAPER, Army.SCISSORS};
ArrayList<Soldier> rocks;
ArrayList<Soldier> paper;
ArrayList<Soldier> scissors;
HashMap<Army, ArrayList<Soldier>> hunting;
HashMap<Army, ArrayList<Soldier>> huntedBy;
HashMap<Army, ArrayList<Soldier>> rosters;
HashMap<Army, Army> winTable;
HashMap<Army, Army> loseTable;
HashMap<Army, PImage> imageMap;
float DANGERZONERADIUS;
float DEATHZONERADIUS;
float fleeSpeed = 1.5;
float chaseSpeed = 2;
PImage rockIcon;
PImage paperIcon;
PImage scissorsIcon;


void setup() {
  size(1000, 1000);
  MAXDISTANCE = width * sqrt(2);
  SOLDIERSIZE = width / 75;
  BATTLEFIELDSIZE = SOLDIERSPERTEAM * 3;
  DEATHZONERADIUS = SOLDIERSIZE;
  DANGERZONERADIUS = SOLDIERSIZE * 4;
  battlefield = new Soldier[BATTLEFIELDSIZE];
  rockIcon = loadImage("../RockColoured.png");
  paperIcon = loadImage("../PaperColoured.png");
  scissorsIcon = loadImage("../ScissorsColoured.png");
  imageMap = new HashMap<Army, PImage>();
  imageMap.put(Army.ROCK, rockIcon);
  imageMap.put(Army.PAPER, paperIcon);
  imageMap.put(Army.SCISSORS, scissorsIcon);


  initBattlefield();
  initArmyLists();
  initWinLoseTables();

  initArmyHashMaps();

  //frameRate(10);
  noFill();
}
void draw() {
  background(0);
  // save a thumbnail
  if (frameCount ==  120) {
    saveFrame("../" + sketchname + ".png");
  }

  populateArmyRosters();
  for (Soldier s : battlefield) {
    s.survey();
    s.orientate();
    s.update();
    s.show();
  }

  text("Rocks: " + str(rocks.size()), 0, height - 50);
  text("Paper: " + str(paper.size()), 0, height - 30);
  text("Scissors: " + str(scissors.size()), 0, height - 10);

  EndState end = evalGameOver();
  if (end.gameIsOver) {
    textSize(20);
    textAlign(CENTER, CENTER);
    text(end.winningArmy.toString() + " WINS!", width/2, height/2);
    noLoop();
  }
}

void initWinLoseTables() {
  //winTable = new HashMap<Army, Army>();
  //winTable.put(Army.ROCK, Army.SCISSORS);
  //winTable.put(Army.SCISSORS, Army.PAPER);
  //winTable.put(Army.PAPER, Army.ROCK);

  loseTable = new HashMap<Army, Army>();
  loseTable.put(Army.ROCK, Army.PAPER);
  loseTable.put(Army.SCISSORS, Army.ROCK);
  loseTable.put(Army.PAPER, Army.SCISSORS);
}

void initArmyLists() {
  rocks = new ArrayList<Soldier>();
  paper = new ArrayList<Soldier>();
  scissors = new ArrayList<Soldier>();
}

void initArmyHashMaps() {
  hunting = new HashMap<Army, ArrayList<Soldier>>();
  hunting.put(Army.ROCK, scissors);
  hunting.put(Army.PAPER, rocks);
  hunting.put(Army.SCISSORS, paper);

  huntedBy = new HashMap<Army, ArrayList<Soldier>>();
  huntedBy.put(Army.ROCK, paper);
  huntedBy.put(Army.PAPER, scissors);
  huntedBy.put(Army.SCISSORS, rocks);

  rosters = new HashMap<Army, ArrayList<Soldier>>();
  rosters.put(Army.ROCK, rocks);
  rosters.put(Army.PAPER, paper);
  rosters.put(Army.SCISSORS, scissors);
}

void populateArmyRosters() {
  rosters.get(Army.ROCK).clear();
  rosters.get(Army.PAPER).clear();
  rosters.get(Army.SCISSORS).clear();
  for (Soldier s : battlefield) {
    rosters.get(s.army).add(s);
  }
}


void initBattlefield() {
  //battlefield[0] = new Soldier(random(width), random(height), Army.ROCK);
  //battlefield[1] = new Soldier(random(width), random(height), Army.PAPER);
  for (int i = 0; i < battlefield.length; i += 3) {
      //println("Init soldier " + str(i));
      battlefield[i] = new Soldier(random(width), random(height), Army.ROCK);
      //println("Init soldier " + str(i + 1));
      battlefield[i + 1] = new Soldier(random(width), random(height), Army.SCISSORS);
      //println("Init soldier " + str(i + 2));
      battlefield[i + 2] = new Soldier(random(width), random(height), Army.PAPER);
  }
}

class EndState {
  boolean gameIsOver;
  Army winningArmy;
  EndState(boolean gameOver, Army army) {
    winningArmy = army;
    gameIsOver = gameOver;
  }
}

EndState evalGameOver() {
  Army winner = Army.ROCK;

  if ((rocks.size() != BATTLEFIELDSIZE) && (paper.size() != BATTLEFIELDSIZE) && (scissors.size() != BATTLEFIELDSIZE)) {
    return new EndState(false, Army.ROCK);
  }
  if (rocks.size() == BATTLEFIELDSIZE) {
    winner = Army.ROCK;
  }
  if (paper.size() == BATTLEFIELDSIZE) {
    winner = Army.PAPER;
  }
  if (scissors.size() == BATTLEFIELDSIZE) {
    winner = Army.SCISSORS;
  }
  

  return new EndState(true, winner);
}
