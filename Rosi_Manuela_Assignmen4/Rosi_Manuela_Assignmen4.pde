float heat = 50;
float coolantMax = 100;
float coolant = 80;


void setup() {
  size(400,400);
  ellipseMode (CENTER);
}

void draw(){
  background (165);
  
  heat += 0.6;
  coolant += 0.01;
  
  coolant = constrain(coolant, 0, coolantMax);
  heat = constrain(heat, 0, 245);
  
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
  fill(255);
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
  fill(0, 255, 0, 200);
  rect(352, 240, 15, 50);
  
  //coolant
  noStroke();
  fill( 0, 0, 255);
  rect(55, 210 -coolant, 10, coolant);
}

void keyPressed(){
  heat -= 10;
  coolant -=30;
  
  heat = constrain(heat, 0, 245);
  coolant = constrain(coolant, 0, coolantMax);
  
  if(coolant > 30){
    heat -= 10;
    coolant -= 30;
  }
}

void mousePressed(){
  heat -= 30;
  coolant -= 70;

  heat = constrain(heat, 0, 245);
  coolant = constrain(coolant, 0, coolantMax);
  
   if(coolant > 70){
    heat -= 10;
    coolant -= 30;
  }
}



  //ises so far- 
  //A- the coolant and the temp lines when they reach a minimum size they are invertin directions meaning they are decreasing each frame 
  //B- the coolant is increasing too quick and I cans still decrease the temp even if coolant is at minimu
  //C- how can I add a cooldown for the coolant? Because if I make a conditional statement that if the coolant is over you cant lower the temp, how can I make a cooldown?
  //D - how can I constrain both the coolant and the temp to only be drawn within their "tanks" rectangles 
  //E- cannot figure out how to make the temp actually activate the stability meter if it is within the green range
