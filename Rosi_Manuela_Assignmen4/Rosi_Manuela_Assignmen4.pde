Furnace furnace;

//ArrayList<Particle> hotParticles;

void setup() {
  size(400, 400);
  ellipseMode (CENTER);
  
  //hotParticles = new ArrayList<Particle>();
  
  furnace = new Furnace();
  
  //for (int i = 0; i < 5; i++){
  //  hotParticles.add(new Particle(170 + i * 15, 170));
  //} 
}

void draw() {
  background (25);
  
  furnace.update();
  furnace.display();
  
  //if(furnace.heat > furnace.safeMax){
  //  for (int i = 0; i < hotParticles.size(); i++){
  //  particle.p = hotParticles.get(i);
  //  p.display();
  //}
}
//}

 



  ////valve coolant ADD PIMAGE FOR IT, SPRITES TO SHOW IT ROTATING
  //stroke(0, 63, 232);
  //strokeWeight(8);
  //noFill();
  //ellipse (60, 60, 60, 60);

  //strokeWeight(5);
  //ellipse( 60, 60, 10, 10);
  //line(60, 30, 60, 90);
  //line(30, 60, 90, 60);

  ////furnace
  //noStroke ();
  //fill(152);
  //rect(80, 220, 240, 220);
  //ellipse(200, 230, 240, 200);

  ////temp - how can I make it constrained to the thermometer and how can I make it
  ////activate the stability while only insde the thermometer?
  //fill(255, 0, 0);
  //rect(355, 377 - heat, 10, heat);

  ////thermometer
  //stroke(0);
  //strokeWeight(2);
  //fill(150, 150, 150, 80);
  //rect(352, 160, 15, 220);
  //ellipse( 360, 145, 40, 40);


  //strokeWeight(5);
  //stroke(255, 0, 0);
  //line(335, 135, 360, 135);
  //stroke(0, 0, 255);
  //line(335, 370, 360, 370);

  ////green range
  //noStroke();
  //fill(0, 255, 0, 100);
  //rect(352, 240, 15, 50);

  ////coolant
  //noStroke();
  //fill( 0, 0, 255);
  //rect(55, 210 -coolant, 10, coolant);


void keyPressed() {
  if (key == 'a' || key == 'A') {
    furnace.regCoolant();
  }
  if (key == 'd' || key == 'D') {
    furnace.largeCoolant();
  }
}

//void updateParticles {
//  for (int i = hotParticles.size() - 1; i >= 0; i--) {
//    Particle p= hotParticles.get(i);

//    p.update();
//    p.display();

//    if (p.isOver()) {
//      hotParticles.remove(i);
//    }
//  }
//}



//ises so far-
//A- the coolant and the temp lines when they reach a minimum size they are invertin directions meaning they are decreasing each frame
//B- the coolant is increasing too quick and I cans still decrease the temp even if coolant is at minimu
//C- how can I add a cooldown for the coolant? Because if I make a conditional statement that if the coolant is over you cant lower the temp, how can I make a cooldown?
//D - how can I constrain both the coolant and the temp to only be drawn within their "tanks" rectangles
//E- cannot figure out how to make the temp actually activate the stability meter if it is within the green range
