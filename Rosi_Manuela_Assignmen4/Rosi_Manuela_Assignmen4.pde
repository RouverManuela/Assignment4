//Furnace object
Furnace furnace;
//Stores the ash particles
ArrayList<Ash> ashes;
//Boolean controls if startScreen is showing or not
boolean startScreen = true;

void setup() {
  size(400, 400);
  ellipseMode (CENTER);
  //Main furnace obj
  furnace = new Furnace();
  //ArrayList that will hold the ashes
  ashes= new ArrayList<Ash>();

//create 15 ash particles
  for (int i = 0; i < 15; i++) {
    //Random starting pt for each 
    float x = random(10, 380);
    float y = random(380, 460);
    //New ash obj add to arrayList
    ashes.add(new Ash(x, y));
  }
}

void draw() {
  background (25);
  //If startScreen is active, draw it, stop draw reset
  if (startScreen == true) {
    furnace.displayStartScreen();
    //so furnace and ash will not run ebeneath the screen
    return;
  }

  furnace.update();
  furnace.display();
//Loop through every ash obj in ArrayList
  for ( int i = 0; i < ashes.size(); i++) {
    Ash a = ashes.get(i);
//If the heat is above the safe/green zone max
//turn the ash into the scorching state, otherwise keep it as is
    if (furnace.heat > furnace.safeMax) {
      a.scorching = true;
    } else {
      a.scorching = false;
    }
    a.update();
    a.display();
  }
}

void keyPressed() {
  //While the startScreen is active, pressinf any key will begin the game
  if (startScreen == true) {
    startScreen = false;
    return;
  }
//triggers regular coolant 
  if (key == 'a' || key == 'A') {
    furnace.regCoolant();
  }
  //triggers bonus coolant
  if (key == 'd' || key == 'D') {
    furnace.largeCoolant();
  }
  //press r to restart when you get lose or win screen 
  if (furnace.winScreen == true || furnace.loseScreen == true) {
    if (key == 'r' ||key == 'R') {
      furnace.restart();
      startScreen = true;
    }
    return;
  }
}
