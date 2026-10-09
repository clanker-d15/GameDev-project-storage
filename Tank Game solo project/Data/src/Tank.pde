class Tank {
  // Member Variables
  int x, y, health, speed, reload, healDelay, ammo, BulletReloadTime, RocketReloadTime, rocketAmmo;

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
    BulletReloadTime = 200;
    RocketReloadTime = 550;
    rocketAmmo = 2;


    base = loadImage("TankBase.png");
    turret = loadImage("TankTurret.png");
  }

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

      // Movement and tank direction (Used old code as base)
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
        // Found this absurd angle that worked by experimenting for 20 minutes
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
        BulletReloadTime = BulletReloadTime - 1;
      }

      if (rocketAmmo == 0) {
        RocketReloadTime = RocketReloadTime - 1;
      }

      if (BulletReloadTime < 0) {
        BulletReloadTime = 200;
        ammo = 12;
        println("Reloaded | Ammo left: " + ammo);
      }

      if (RocketReloadTime < 0) {
        RocketReloadTime = 350;
        rocketAmmo = 2;
        println("Reloaded | " + rocketAmmo + " Rockets Left");
      }
    }
  }

  void shoot() {
    if (mouseButton == LEFT) {
      if (ammo > 1) {
        ammo = ammo - 1;
        println("Player Shot Bullet | Ammo left: " + ammo);
      } else {
        println("No Bullets left | Player Reloading Bullets...");
        ammo = 0;
      }
    }
    if (mouseButton == RIGHT) {
      if (rocketAmmo > 1) {
        println("Player Rocket Shot | Rockets left: 1");
        rocketAmmo = rocketAmmo - 1;
      } else {
        println("No Rockets left | Player Reloading Rockets...");
        rocketAmmo = 0;
      }
    }
  }

  boolean isHit() {
    return true;
  }
}
