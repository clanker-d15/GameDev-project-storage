class LightEnemy {
  int x, y, health, damage, speed, reload, shootDelay, ammo;
  float angle, turretAngle;
  PImage base, turret;

  boolean movingForward = false;
  boolean movingBackward = false;
  boolean movingLeft = false;
  boolean movingRight = false;

  // Contructor
  LightEnemy(int x, int y) {
    x = width/2;
    y = y + 100;
    health = 475;
    damage = 7;
    speed = 5;
    ammo = 50;
    reload = 300;
    shootDelay = 20;
    angle = HALF_PI;
    turretAngle = -HALF_PI;

    base = loadImage("LightEnemyBase.png");
    turret = loadImage("LightEnemyTurret.png");
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
        health = 475;
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
      speed = 5;
    }

    if (ammo == 0) {
      reload = reload - 1;
      shootDelay = 0;
    }

    if (reload < 0) {
      reload = 300;
      ammo = 50;
      println("Light enemy reloaded | Light enemy ammo left: " + ammo);
    }
  }

  void shoot() {
    if (ammo > 1) {
      ammo = ammo - 1;
      println("Light enemy shot bullet | Light enemy ammo left: " + ammo);
    } else {
      println("Light enemy reloading...");
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
