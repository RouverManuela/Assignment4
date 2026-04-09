Furnace furnace;
ArrayList<Ash> ashes;

boolean startScreen = true;


void setup() {
  size(400, 400);
  ellipseMode (CENTER);

  furnace = new Furnace();
  ashes= new ArrayList<Ash>();

  for (int i = 0; i < 15; i++) {
    float x = random(10, 380);
    float y = random(380, 460);
    ashes.add(new Ash(x, y));
  }
}

void draw() {
  background (25);
  if (startScreen == true) {
    furnace.displayStartScreen();
    return;
  }
  
  furnace.update();
  furnace.display();

  for ( int i = 0; i < ashes.size(); i++) {
    Ash a = ashes.get(i);

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

  if (startScreen == true) {
   startScreen = false;
    return;
  }

  if (key == 'a' || key == 'A') {
    furnace.regCoolant();
  }
  if (key == 'd' || key == 'D') {
    furnace.largeCoolant();
  }
  if ((key == 'r' || key == 'R') && (furnace.winScreen == true || furnace.loseScreen == true)){
    furnace.restart();
    startScreen = true;
    return;
  }
}
