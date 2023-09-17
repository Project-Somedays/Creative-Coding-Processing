float soldierSize;
Soldier[] battlefield;
int soldiersPerTeam = 20;
Army[] armies = {Army.ROCK, Army.PAPER, Army.Scissors};

void setup(){
    size(1080, 1080);
    soldierSize = width/100;
    battlefield = new Soldier[soldiersPerTeam*3];
    initBattlefield();

}
void draw(){
    background(0);
    for(int i = 0; i < battlefield.length; i++){
        battlefield[i].show();
    }
}

void initBattlefield(){
    for(int j = 0; j < 3; j++){
        for(int i = 0; i < soldierSize){
            battlefield[j*soldiersPerTeam + i] = new Soldier(random(width), random(height), armies[j]);
        }
    }
    
}

