class Furnace {
  //just the center of the blue valve to check if the mouse is holding it.
  PVector valveMiddle;

  //the values fo the heat, the 110 is the initial value and the max is the maximum value it can reach
  float heat = 110;
  float heatMax = 242;
  //Same logic applies (stability included)
  float coolant = 60;
  float coolantMax = 100;

  float stability = 0;
  float stabilityMax = 100;
  //the rates by which the coolant and heat go up or down every frame
  float heatRate = 0.18;
  float coolantRate = 0.35;
  float refillRate = 0.4;

  //theseare the values of the A dn D keys. the a releases the normal amount of coolant which then subtracts from th coolant, while the D releases extra coolant.
  //it was a bit hard to find a value for these two that would not make the game either impossible or too easy ToT but I think it is balanced now lol
  float coolantA = 7;
  float coolantD = 20;
  float costA = 6;
  float costD = 18;
  //this is the range of the green/safe range
  float safeMin = 90;
  float safeMax = 140;
  //stability (purple bar) how much ypou lose when in the green area and how much you lose when beyond the green
  float stabilityGain = 0.14;
  float stabilityLoss = 0.05;
  //how many yellow or red lights are going to light up
  //Borrowed this idea from the cool ship example prof Barry showed us :]
  int stabilityCount = 0;
  int stabilityGoal = 4;
  int failCount = 0;
  int failMax = 4;

  boolean valveHeld = false; //for the refill, check if valve is being pressed
  //what end screen will show
  boolean winScreen = false;///
  boolean loseScreen = false;//
  ////////////////////////////
  boolean heatSurge = false; //check if the heat surge is active
  boolean meltdown = false;//check if meltdown is active

  //how long surge lasts
  int surgeTimer = 0;
  //Constructor for the valve position when furnace is created
  Furnace() {
    valveMiddle = new PVector (60, 60);
  }
  //draw the start screen
  void displayStartScreen() {
    background(234, 232, 232, 150);
    fill(0);
    textAlign (CENTER, CENTER);
    textSize(25);
    text("PRESS A & D TO CONTROL HEAT", width/2, 120);
    text("STAY WITHIN THE GREEN AREA", width/2, 148);
    textSize(18);
    fill (0, 0, 255);
    text("!!Hold the BLUE VALVE to refill coolant", width/2, 190);
    textSize(20);
    fill(188, 28, 28);
    text("press any button to start", width/2, 280);
  }


  void update() {
    //heat rises every frame
    heat += heatRate;
    //reset valve every frame
    valveHeld = false;
    //if furnace overheats count one fail and rest all values***
    if (heat >= heatMax && meltdown == false) {
      failCount ++;
      meltdown = true;
      heat = 110;
      coolant = 60;
      stability = 0;
      heatSurge = false;
    }
    if (heat < heatMax) {
      meltdown = false;
    }
    //randomly start a heat surge, the random range is suuuuper tiny so it wont happen as often
    if (heatSurge == false) {
      if (random(1) < 0.002) {
        heatSurge = true;
        surgeTimer = 180;
        println("SURGE ON");
      }
    }
    //While surge is acrtive add extra heat and count down timer
    if (heatSurge == true) {
      heat += 0.3;
      surgeTimer --;
    }
    //when surge timer ends, stop surge
    if (heatSurge == true && surgeTimer <=0) {
      heatSurge = false;
      println("SURGE ON");
    }
    //check if player is holding the valve
    if (mousePressed && dist(mouseX, mouseY, valveMiddle.x, valveMiddle.y) < 30 ) {
      valveHeld = true;
    }
    //if yes - refill coolant (blue bar)
    if (valveHeld == true) {
      coolant += refillRate;
    }
    //keep the limits
    coolant = constrain(coolant, 0, coolantMax);
    heat = constrain(heat, 0, heatMax);
    //if inside green zone gain stability (purble bar) add, if outside, subtract
    if (heat >= safeMin && heat <= safeMax) {
      stability += stabilityGain;
    } else {
      stability -= stabilityLoss;
    }
    stability = constrain(stability, 0, stabilityMax);
    //add one yellow light player need 4 to win
    if (stability >= stabilityMax) {
      stabilityCount++;
      stability = 0;
    }
    stabilityCount = constrain(stabilityCount, 0, stabilityGoal);
  }
  //regular coolant axction used by 'a' key
  void regCoolant() {
    if (valveHeld == false && coolant >= costA) {
      heat -= coolantA;
      coolant -= costA;
    }
    coolant = constrain(coolant, 0, coolantMax);
    heat = constrain(heat, 0, heatMax);
  }
  //bonus coolant by 'd' key
  //also ends heat surge
  void largeCoolant() {
    if (valveHeld == false && coolant>=costD) {
      heat -= coolantD;
      coolant -= costD;
      heatSurge = false;
    }
    coolant = constrain(coolant, 0, coolantMax);
    heat = constrain(heat, 0, heatMax);
  }

  void display() {

    //warning light
    stroke (0);
    strokeWeight (2);
    if (heatSurge == true) {
      fill(255, 0, 0);
    } else {
      fill(50);
    }
    ellipse(200, 125, 20, 26);

    //fail and win lights
    for (int i = 0; i < 4; i++) {
      //fail lights
      if (i < failCount) {
        fill(255, 0, 0);
      }
      //win lights
      else if (i < stabilityCount) {
        fill(255, 255, 0);
      } else {
        fill(80);
      }

      ellipse(120 + i *25, 70, 15, 15);
    }

    //valve coolant
    stroke(0, 63, 232);
    strokeWeight(8);
    noFill();
    ellipse (60, 60, 60, 60);

    strokeWeight(5);
    ellipse( 60, 60, 10, 10);
    line(60, 30, 60, 90);
    line(30, 60, 90, 60);



    //furnace
    noStroke ();
    fill(152);
    rect(80, 220, 240, 220);
    ellipse(200, 230, 240, 200);

    //temp
    fill(255, 0, 0);
    rect(355, 377 - heat, 10, heat);

    //thermometer
    stroke(0);
    strokeWeight(2);
    fill(150, 150, 150, 80);
    rect(352, 160, 15, 220);
    ellipse( 360, 145, 40, 40);

    //red line represents the heat max
    strokeWeight(5);
    stroke(255, 0, 0);
    line(335, 135, 360, 135);


    //green range
    noStroke();
    fill(0, 255, 0, 100);
    rect(352, 240, 15, 50);

    //coolant
    noStroke();
    fill( 0, 0, 255);
    rect(55, 210 -coolant, 10, coolant);

    noFill();
    stroke(255);
    rect(110, 30, 160, 12);

    noStroke();
    fill(180, 0, 255);
    float stabilityWidth = map(stability, 0, stabilityMax, 0, 160);
    rect(110, 30, stabilityWidth, 12);

    //more heat surge effects - filter and light
    noStroke();
    if (heatSurge == true) {
      fill(255, 0, 0, frameCount%65);
    } else {
      noFill();
    }
    rect(0, 0, width, height);
    noStroke();
    if (heatSurge == true) {
      fill(255);
    } else {
      noFill();
    }
    ellipse(200, 126, 4, 4);

    if (heatSurge == true) {
      fill(255, 0, 0, 50);
    } else {
      noFill();
    }
    ellipse(200, 126, 30, 30);
    ellipse(200, 126, 80, 80);
    ellipse(200, 126, 130, 130);




    //win screen
    if (stabilityCount >= stabilityGoal) {
      winScreen = true;
    }
    if (winScreen == true) {
      fill(19, 160, 76);
      rect(0, 0, width, height);
      fill(0);
      textAlign (CENTER, CENTER);
      textSize(25);
      text("Congrats, you win", width/2, 200);
      text("Press R to restart", width/2, 280);
    }

    //lose screen
    if (failCount >= failMax) {
      loseScreen = true;
    }
    if (loseScreen == true) {
      fill(188, 28, 28);
      rect(0, 0, width, height);
      fill(0);
      textAlign (CENTER, CENTER);
      textSize(25);
      text("womp womp, you lose", width/2, 200); //haha LLLLLLLLL
      text("Press R to restart", width/2, 280);
    }
  }

  //this restarts the game upon pressin the 'r' key as established in the main tab :]
  void restart() {
    heat = 110;
    coolant = 60;
    stability = 0;
    stabilityCount = 0;
    failCount= 0;
    heatSurge = false;
    valveHeld = false;

    surgeTimer = 0;

    winScreen = false;
    loseScreen = false;
  }
}
