class Tank {
  // Member Variables
  int x, y, health, speed, healDelay, ammo, BulletReloadTime, RocketReloadTime, rocketAmmo, shootType, shootDelay;

  float angle, turretAngle, rotationSpeed, armorProctection;

  PImage base, turret;

  boolean movingForward = false;
  boolean movingBackward = false;
  boolean movingLeft = false;
  boolean movingRight = false;
  boolean turningLeft = false;
  boolean turningRight = false;

  // Make the movement smoother. Make it take time to stop and speed up again
  // Fix the rocket so it comes out of the tank turret's rocket launcher. Do the same with the bullets and the turret
  // Revamp the movement to be more realistic
  // Simplify the crosshair and the counter
  // Implement the extra specs of the tank

  // Constructor
  Tank() {
    x = width/2;
    y = 850;
    if (armorType == 1) {
      health = 1200;
      speed = 3;
      armorProctection = 1;
    } else if (armorType == 2) {
      health = 925;
      speed = 4;
      armorProctection = 0.65;
    } else if (armorType == 3) {
      health = 1750;
      speed = 2;
      armorProctection = 1.55;
    }
    rotationSpeed = 0.03;
    angle = -HALF_PI;
    healDelay = 450;
    turretAngle = HALF_PI;

    if (bulletType == 1) {
      ammo = 12;
      shootDelay = 20;
      BulletReloadTime = 200;
    } else if (bulletType == 2) {
      ammo = 6;
      shootDelay = 40;
      BulletReloadTime = 275;
    }

    if (rocketType == 1) {
      rocketAmmo = 2;
      RocketReloadTime = 475;
    } else if (rocketType == 2) {
      rocketAmmo = 3;
      RocketReloadTime = 550;
    }

    shootType = 1;

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
          y -= speed;
          angle = -HALF_PI;
        }
        if (movingBackward) {
          y += speed;
          angle = HALF_PI;
        }
        if (movingLeft) {
          x -= speed;
          angle = PI;
        }
        if (movingRight) {
          x += speed;
          angle = 0;
        }

        if (movingForward == true && movingRight == true) {
          angle = -HALF_PI/2;
          speed /= 2;
        }
        if (movingForward == true && movingLeft == true) {
          angle = -10200;
          speed /= 2;
        }
        if (movingBackward == true && movingRight == true) {
          angle = HALF_PI/2;
          speed /= 2;
        }
        if (movingBackward == true && movingLeft == true) {
          angle = 10200;
          speed /= 2;
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
      } else {
        if (movingForward) {
          x += cos(angle) * speed;
          y += sin(angle) * speed;
        }
        if (movingBackward) {
          x -= cos(angle) * speed;
          y -= sin(angle) * speed;
        }
        if (turningLeft) angle -= rotationSpeed;
        if (turningRight) angle += rotationSpeed;
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
