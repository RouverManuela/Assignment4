class Furnace {
  PVector valveMiddle;

  float heat = 110;
  float heatMax = 242;

  float coolant = 60;
  float coolantMax = 100;

  float stability = 0;
  float stabilityMax = 100;

  float heatRate = 0.18;
  float coolantRate = 0.35;

  float refillRate = 0.35;

  float coolantA = 7;
  float coolantD = 20;
  float costA = 6;
  float costD = 18;

  float safeMin = 90;
  float safeMax = 140;

  float stabilityGain = 0.14;
  float stabilityLoss = 0.05;
  int stabilityCount = 0;
  int stabilityGoal = 4;

  boolean valveHeld = false;
  boolean winScreen = false;
  boolean heatSurge = false;

  int surgeTimer = 0;



  Furnace() {
    valveMiddle = new PVector (60, 60);
  }

  void update() {
    heat += heatRate;

    valveHeld = false;

    if (heatSurge == false) {
      if (random(1) < 0.003) {
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
   

    for (int i = 0; i < 4; i++) {
      if (i < stabilityCount) {
        fill(255, 255, 0);
      } else {
        fill(80);
      }

      ellipse(120 + i *25, 70, 15, 15);
    }

    //valve coolant ADD PIMAGE FOR IT, SPRITES TO SHOW IT ROTATING
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


    strokeWeight(5);
    stroke(255, 0, 0);
    line(335, 135, 360, 135);
    stroke(0, 0, 255);
    line(335, 370, 360, 370);

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
    if (heatSurge == true){
      fill(255);
    }else{
      noFill();
    }
     ellipse(200, 126, 4, 4);
     
      if (heatSurge == true){
      fill(255, 0, 0, 50);
    }else{
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
    }
  }


  void restart() {
    heat = 110;
    coolant = 60;
    stability = 0;
    stabilityCount = 0;
    winScreen = false;
  }
}
