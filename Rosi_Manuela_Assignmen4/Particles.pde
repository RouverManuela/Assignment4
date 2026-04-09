class Ash {
  PVector pos;
  PVector velocity;
  PVector acceleration;

  boolean scorching = false;


  float maxSpeed = 1;
  float swayStrength = 0.03;
  float mouseRadius = 60;

  Ash(float x, float y) {
    pos = new PVector(x, y);
    velocity = new PVector(0, -0.6);
    acceleration = new PVector (0, 0);
  }

  void update () {
    //upward motion
    acceleration.mult (0);
    PVector up = new PVector(0, -0.01);
    acceleration.add(up);

    //random movement
    PVector sway = new PVector (random(-swayStrength, swayStrength), 0);
    acceleration.add(sway);

    //mouse interaction
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector away = PVector.sub(pos, mousePos);
    float ew = away.mag();

    if (ew < mouseRadius) {
      away.normalize();
      away.mult(0.08);
      acceleration.add(away);
    }
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    pos.add(velocity);

    if (pos.y < -10) {
      pos.x = random(10, 380);
      pos.y = random(380, 460);
    }
  }

  void display () {
    noStroke();

    if (scorching == true) {
      fill(255, 120, 0, 90);
    } else {
      fill (220, 220, 220, 90);
    }

    ellipse(pos.x, pos.y, 8, 12);
    ellipse(pos.x, pos.y, 8, 10);
  }
}
