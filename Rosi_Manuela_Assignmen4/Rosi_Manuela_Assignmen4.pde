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

void keyPressed() {
  if (key == 'a' || key == 'A') {
    furnace.regCoolant();
  }
  if (key == 'd' || key == 'D') {
    furnace.largeCoolant();
  }
    if ((key == 'r' || key == 'R') && furnace.winScreen == true){
      furnace.restart();
    }
}
