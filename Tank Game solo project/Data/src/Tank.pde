class Tank {
  // Member Variables
  int health, speed, maxSpeed, healDelay, ammo, BulletReloadTime, RocketReloadTime, rocketAmmo, shootType, shootDelay;

  float x, y, vx, vy, angle, turretAngle, rotationSpeed, armorProtection, accel, friction;

  PImage base, turret;

  boolean movingForward = false;
  boolean movingBackward = false;
  boolean movingLeft = false;
  boolean movingRight = false;
  boolean turningLeft = false;
  boolean turningRight = false;

  // Make the movement smoother. Make it take time to stop and speed up again
  // Fix the rocket so it comes out of the tank turret's rocket launcher. Do the same with the bullets and the turret
  // Rework the actual movement, keep the legacy unchanged
  // Simplify the crosshair and the counter
  // Implement the extra specs of the tank

  // Constructor
  Tank() {
    x = width/2;
    y = 850;
    vx = 0;
    vy = 0;
    rotationSpeed = 0.03;
    angle = -HALF_PI;
    healDelay = 450;
    turretAngle = HALF_PI;
    shootType = 1;
    ammo = 12;
    maxSpeed = 3;
    health = 1200;
    armorProtection = 1;
    BulletReloadTime = 200;
    shootDelay = 40;
    RocketReloadTime = 475;
    rocketAmmo = 2;
    accel = 0.4;
    friction = 0.94;
    speed = 0;

    base = loadImage("TankBase.png");
    turret = loadImage("TankTurret.png");
  }

  void display() {
    imageMode(CENTER);
    noCursor();

    //if (armorType == 1) {
    //  health = 1200;
    //  maxSpeed = 3;
    //  armorProtection = 1;
    //  accel = 0.4;
    //  friction = 0.94;
    //} else if (armorType == 2) {
    //  health = 925;
    //  maxSpeed = 4;
    //  armorProtection = 0.65;
    //  accel = 0.5;
    //  friction = 0.92;
    //} else if (armorType == 3) {
    //  health = 1750;
    //  maxSpeed = 2;
    //  armorProtection = 1.55;
    //  accel = 0.35;
    //  friction = 0.96;
    //}

    //if (bulletType == 1) {
    //  ammo = 12;
    //  shootDelay = 20;
    //  BulletReloadTime = 200;
    //} else if (bulletType == 2) {
    //  ammo = 6;
    //  shootDelay = 40;
    //  BulletReloadTime = 275;
    //}

    //if (rocketType == 1) {
    //  rocketAmmo = 2;
    //  RocketReloadTime = 475;
    //} else if (rocketType == 2) {
    //  rocketAmmo = 3;
    //  RocketReloadTime = 550;
    //}

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
    if (health < 0) {
      health = 0;
    }

    if (health < 1350) {
      healDelay = 450;
      healDelay -= 1;
    }

    if (healDelay < 1) {
      healDelay = 0;
    }

    if (health > 0) {
      if (health > 1350) {
        health = 1350;
      }

      if (movingForward || movingBackward || movingLeft || movingRight == true) {
        // move.play();
      } else {
        // idle.play();
      }

      // Movement
      if (legacyMovement == true) {
        if (movingForward) {
          y -= maxSpeed;
          angle = -HALF_PI;
        }
        if (movingBackward) {
          y += maxSpeed;
          angle = HALF_PI;
        }
        if (movingLeft) {
          x -= maxSpeed;
          angle = PI;
        }
        if (movingRight) {
          x += maxSpeed;
          angle = 0;
        }

        if (movingForward == true && movingRight == true) {
          angle = -HALF_PI/2;
          maxSpeed /= 2;
        }
        if (movingForward == true && movingLeft == true) {
          angle = -10200;
          maxSpeed /= 2;
        }
        if (movingBackward == true && movingRight == true) {
          angle = HALF_PI/2;
          maxSpeed /= 2;
        }
        if (movingBackward == true && movingLeft == true) {
          angle = 10200;
          maxSpeed /= 2;
        }

        // Movement debuggers
        if (movingForward == true && movingRight == true && movingLeft == true) {
          angle = -HALF_PI;
        }
        if (movingBackward == true && movingRight == true && movingLeft == true) {
          angle = HALF_PI;
        }

        if (movingBackward == true && movingLeft == true && movingForward == true && movingRight == true) {
          maxSpeed = 0;
        } else {
          maxSpeed = 3;
        }
      } else {
        if (movingForward) {
          vx += cos(angle) * accel;
          vy += sin(angle) * accel;
        }
        if (movingBackward) {
          vx -= cos(angle) * accel;
          vy -= sin(angle) * accel;
        }
        if (turningLeft) angle -= rotationSpeed;
        if (turningRight) angle += rotationSpeed;

        float currentSpeed = sqrt(vx * vx + vy * vy);
        if (currentSpeed > maxSpeed) {
          vx = (vx / currentSpeed) * maxSpeed;
          vy = (vy / currentSpeed) * maxSpeed;
        }

        x += vx;
        y += vy;
        vx *= friction;
        vy *= friction;

        if (x < 0 || x > width) vx = 0;
        if (y < 0 || y > height) vy = 0;
      }

      // Turret rotation
      float targetAngle = atan2(mouseY - y, mouseX - x) - HALF_PI;
      float diff = targetAngle - turretAngle;

      while (diff < -PI) diff += TWO_PI;
      while (diff > PI) diff -= TWO_PI;
      turretAngle += diff * 0.25;

      x = constrain(x, 0, width);
      y = constrain(y, 0, height);

      // reload
      if (ammo == 0) {
        BulletReloadTime -= 1;
      }

      if (rocketAmmo == 0) {
        RocketReloadTime -= 1;
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
    if (shootType == 1) {
      if (ammo > 1) {
        ammo -= 1;
        println("Player Shot Bullet | Ammo left: " + ammo);
        shootDelay = 25;
      } else {
        println("No Bullets left | Player Reloading Bullets...");
        ammo = 0;
      }
    }
    if (shootType == 2) {
      if (rocketAmmo > 1) {
        println("Player Rocket Shot | Rockets left: 1");
        rocketAmmo -= 1;
      } else {
        println("No Rockets left | Player Reloading Rockets...");
        rocketAmmo = 0;
      }
    }
  }

  boolean isHit() {
    return true;
  }

  boolean Collision() {
    return true;
  }
}
