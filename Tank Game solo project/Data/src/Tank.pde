class Tank {
  // Member Variables
  int x, y, health, speed, reload, healDelay, ammo, reloadTime, damage;

  float angle, turretAngle, rotationSpeed;

  PImage base, turret;

  boolean movingForward = false;
  boolean movingBackward = false;
  boolean movingLeft = false;
  boolean movingRight = false;


  // Constructor
  Tank() {
    x = width/2;
    y = 850;
    health = 1350;
    reload = 110;
    rotationSpeed = 0.03;
    speed = 3;
    angle = -HALF_PI;
    healDelay = 350;
    turretAngle = HALF_PI;
    ammo = 12;
    reloadTime = 200;
    damage = 40;


    base = loadImage("TankBase.png");
    turret = loadImage("TankTurret.png");
  }

  // Member Methods

  void display() {
    imageMode(CENTER);


    pushMatrix();
    translate(x, y);

    // Base
    rotate(angle - HALF_PI);
    image(base, 0, 0);


    // Turret
    pushMatrix();

    rotate(turretAngle - angle + HALF_PI);

    float pivotOffsetX = -2;
    float pivotOffsety = 7;

    image(turret, pivotOffsetX, pivotOffsety);
    popMatrix();

    popMatrix();
  }

  void update() {
    if (health > 0) {

      // Movement and tank direction (Used some older code from former project as a base)
      if (movingForward) {
        y = y - speed;
        angle = -HALF_PI;
      }
      if (movingBackward) {
        y = y + speed;
        angle = HALF_PI;
      }
      if (movingLeft) {
        x = x - speed;
        angle = PI;
      }
      if (movingRight) {
        x = x + speed;
        angle = 0;
      }

      if (movingForward == true && movingRight == true) {
        angle = -HALF_PI/2;
        speed = speed/2;
      }
      if (movingForward == true && movingLeft == true) {
        // Found this absurd angle that worked by experimenting for like 20 minutes
        angle = -10200;
        speed = speed/2;
      }
      if (movingBackward == true && movingRight == true) {
        angle = HALF_PI/2;
        speed = speed/2;
      }
      if (movingBackward == true && movingLeft == true) {
        // Found this angle the same way
        angle = 10200;
        speed = speed/2;
      }

      // Movement debuggers
      if (movingForward == true && movingRight == true && movingLeft == true) {
        angle = -HALF_PI;
      }
      if (movingBackward == true && movingRight == true && movingLeft == true) {
        angle = HALF_PI;
      }

      if (movingBackward == true && movingLeft == true && movingForward == true && movingRight == true) {
        speed = 0;
      } else {
        speed = 3;
      }


      // Turret rotation
      float targetAngle = atan2(mouseY - y, mouseX - x) - HALF_PI;
      float diff = targetAngle - turretAngle;

      while (diff < -PI) diff += TWO_PI;
      while (diff > PI) diff -= TWO_PI;
      turretAngle += diff * 0.4;

      x = constrain(x, 0, width);
      y = constrain(y, 0, height);


      // reload
      if (ammo == 0) {
        reloadTime = reloadTime - 1;
      }

      if (reloadTime < 0) {
        reloadTime = 200;
        ammo = 12;
        println("Reloaded | Ammo left: " + ammo);
      }
    }
  }

  void shoot() {
    if (mouseButton == LEFT) {
      if (ammo > 0) {
        ammo = ammo - 1;
        println("Player Shot | Ammo left: " + ammo);
      } else if (ammo == 0 || reloadTime == 0 || reloadTime < 0) {
        ammo = 0;
        println("Player Reloading... | " + reloadTime + " until reloaded");
      }
    }
  }

  boolean isHit() {
    return true;
  }
}
