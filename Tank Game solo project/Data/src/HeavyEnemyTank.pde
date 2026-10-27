class HeavyEnemy {
  int x, y, health, damage, speed, shootDelay, BulletReloadTime, ammo;
  float angle, turretAngle;
  PImage base, turret;

  boolean movingForward = false;
  boolean movingBackward = false;
  boolean movingLeft = false;
  boolean movingRight = false;

  // Contructor
  HeavyEnemy(int x, int y) {
    x = width/5;
    y = 100;
    health = 1000;
    damage = 30;
    base = loadImage("HeavyEnemyBase.png");
    turret = loadImage("HeavyEnemyTurret.png");
    speed = 3;
    angle = HALF_PI;
    turretAngle = -HALF_PI;
    ammo = 12;
    BulletReloadTime = 190;
    shootDelay = 40;
  }

  // Member Methods
  void display() {
    if (health > 0) {
      imageMode(CENTER);

      pushMatrix();

      rotate(angle + HALF_PI);
      image(base, x, y);

      pushMatrix();

      float pivotOffsetX = -2;
      float pivotOffsety = 7;

      rotate(turretAngle - angle - HALF_PI);
      image(turret, pivotOffsetX, pivotOffsety);

      popMatrix();
      popMatrix();
    }
  }

  void update() {
    if (health < 0) {
      health = 0;
    }

    if (health > 0) {
      if (health > health) {
        health = 1000;
      }
    }

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
      angle = -10200;
      speed = speed/2;
    }
    if (movingBackward == true && movingRight == true) {
      angle = HALF_PI/2;
      speed = speed/2;
    }
    if (movingBackward == true && movingLeft == true) {
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

    if (ammo == 0) {
      BulletReloadTime = BulletReloadTime - 1;
      shootDelay = 0;
    }

    if (BulletReloadTime < 0) {
      BulletReloadTime = 200;
      ammo = 12;
      println("Heavy enemy reloaded | Heavy enemy ammo left: " + ammo);
    }
  }

  // Add a delay to shooting

  void shoot() {
    if (ammo > 1) {
      ammo = ammo - 1;
      println("Heavy enemy shot bullet | Heavy enemy ammo left: " + ammo);
    } else {
      println("Heavy enemy reloading...");
      ammo = 0;
    }
  }

  void move(int tempX, int tempY) {
    x = tempX;
    y = tempY;
  }

  boolean isHit() {
    return true;
  }
}
