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
  float coolantA = 7;
  float coolantD = 20;
  float costA = 6;
  float costD = 18;
//this is the range of the green/safe range
  float safeMin = 90;
  float safeMax = 140;

  float stabilityGain = 0.14;
  float stabilityLoss = 0.05;

  int stabilityCount = 0;
  int stabilityGoal = 4;
  int failCount = 0;
  int failMax = 4;

  boolean valveHeld = false;
  boolean winScreen = false;
  boolean loseScreen = false;
  boolean heatSurge = false;
  boolean meltdown = false;

  int surgeTimer = 0;



  Furnace() {
    valveMiddle = new PVector (60, 60);
  }

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
    heat += heatRate;

    valveHeld = false;

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

    if (heatSurge == false) {
      if (random(1) < 0.001) {
        heatSurge = true;
        surgeTimer = 180;
        println("SURGE ON");
      }
    }
    if (heatSurge == true) {
      heat += 0.3;
      surgeTimer --;
    }
    if (heatSurge == true && surgeTimer <=0) {
      heatSurge = false;
      println("SURGE ON");
    }


    if (mousePressed && dist(mouseX, mouseY, valveMiddle.x, valveMiddle.y) < 30 ) {
      valveHeld = true;
    }
    if (valveHeld == true) {
      coolant += refillRate;
    }

    coolant = constrain(coolant, 0, coolantMax);
    heat = constrain(heat, 0, heatMax);

    if (heat >= safeMin && heat <= safeMax) {
      stability += stabilityGain;
    } else {
      stability -= stabilityLoss;
    }
    stability = constrain(stability, 0, stabilityMax);

    if (stability >= stabilityMax) {
      stabilityCount++;
      stability = 0;
    }
    stabilityCount = constrain(stabilityCount, 0, stabilityGoal);
  }

  void regCoolant() {
    if (valveHeld == false && coolant >= costA) {
      heat -= coolantA;
      coolant -= costA;
    }
    coolant = constrain(coolant, 0, coolantMax);
    heat = constrain(heat, 0, heatMax);
  }

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

    //temp - how can I make it constrained to the thermometer and how can I make it
    //activate the stability while only insde the thermometer?
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

    //more heat surge effects
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




    //simulation of win screen
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
      text("womp womp, you lose", width/2, 200);
      text("Press R to restart", width/2, 280);
    }
  }


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
