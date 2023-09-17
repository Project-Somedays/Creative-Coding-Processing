class Soldier{
    PVector pos;
    PVector vel;
    Army army;
    Soldier(float x, float y, Army army_){
        pos = new PVector(x,y);
        val = new PVector(0,0);
        army = army_;
    }

    void show(){
        switch(army){
            case Army.ROCK:
                fill(255,0,0);
                ellipse(pos.x, pos.y, soldierSize, soldierSize);
        }
    }

}