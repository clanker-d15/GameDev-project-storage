class Tank {
  // Member Variables
  int x, y, health, speed, reload, shootDelay, healDelay, ammo, reloadTime;

  float angle, turretAngle, rotationSpeed;

  PImage base, turret;

  boolean movingForward = false;
  boolean movingBackward = false;
  boolean turningLeft = false;
  boolean turningRight = false;


  // Constructor
  Tank() {
    x = 30;
    y = 45;
    health = 1350;
    shootDelay = 8;
    reload = 110;
    rotationSpeed = 0.03;
    speed = 2;
    angle = 0;
    healDelay = 10;
    turretAngle = 0;
    ammo = 12;
    reloadTime = 250;


    base = loadImage("TankBase.png");
    turret = loadImage("TankTurret.png");
  }

  // Member Methods

  void display() {
    imageMode(CENTER);


    pushMatrix();
    translate(x, y);
    rotate(angle);
    image(base, 0, 0);

    pushMatrix();

    rotate(turretAngle - angle);

    float pivotOffsetX = -2;
    float pivotOffsety = 7;

    image(turret, pivotOffsetX, pivotOffsety);
    popMatrix();

    popMatrix();
  }

  void update() {
    if (health > 0) {
      if (movingForward) {
        x += cos(angle) * speed;
        y += sin(angle) * speed;
      }
      if (movingBackward) {
        x -= cos(angle) * speed;
        y -= sin(angle) * speed;
      }

      // Base rotation
      if (turningLeft) angle -= rotationSpeed;
      if (turningRight) angle += rotationSpeed;

      // Turret rotation
      float targetAngle = atan2(mouseY - y, mouseX - x) - HALF_PI;
      float diff = targetAngle - turretAngle;

      while (diff < -PI) diff += TWO_PI;
      while (diff > PI) diff -= TWO_PI;
      turretAngle += diff * 0.5;


      if (ammo == 0) {
        reloadTime = reloadTime - 1;
      }

      if (reloadTime < 0) {
        reloadTime = 250;
        ammo = 12;
        println("Reloaded | Ammo left: " + ammo);
      }
    }
  }

  void move() {
    // Movement input is only processed when PLAYING
    if (key == 'w') player.movingForward = true;
    if (key == 's') player.movingBackward = true;
    if (key == 'a') player.turningLeft = true;
    if (key == 'd') player.turningRight = true;
    if (keyCode == 38) player.movingForward = true;
    if (keyCode == 40) player.movingBackward = true;
    if (keyCode == 37) player.turningLeft = true;
    if (keyCode == 39) player.turningRight = true;
  }

  void stationary() {
    if (key == 'w') player.movingForward = false;
    if (key == 's') player.movingBackward = false;
    if (key == 'a') player.turningLeft = false;
    if (key == 'd') player.turningRight = false;
    if (keyCode == 38) player.movingForward = false;
    if (keyCode == 40) player.movingBackward = false;
    if (keyCode == 37) player.turningLeft = false;
    if (keyCode == 39) player.turningRight = false;
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
  
  
}
