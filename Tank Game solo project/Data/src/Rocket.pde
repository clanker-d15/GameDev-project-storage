class Rocket {
  float x, y, w, h, speed, angle, rocketDamage;
  PImage rocket;

  Rocket(float x, float y) {
    this.x = x;
    this.y = y;
    w = 7;
    h = 20;
    angle = player.turretAngle;
    if (rocketType == 1) {
      rocketDamage = 250;
      speed = 21;
    } else if (rocketType == 2) {
      rocketDamage = 225;
      speed = 18;
    }

    rocket = loadImage("Rocket.png");
  }

  void update() {
    x += cos(angle + HALF_PI) * speed;
    y += sin(angle + HALF_PI) * speed;
  }

  void display() {
    fill(#F0A327);
    noStroke();
    imageMode(CENTER);
    pushMatrix();
    translate(x, y);
    rotate(angle + PI);
    image(rocket, 0, 0);
    popMatrix();
  }

  boolean isOffScreen() {
    return (x < -10 || x > width + 10 || y < -10 || y > height + 10);
  }

  boolean isHit(Tank t) {
    float d = dist(x, y, t.x, t.y);
    if (d < 40) {
      t.health -= rocketDamage;
      return true;
    }
    return false;
  }

  boolean isHit(HeavyEnemy het) {
    float d = dist(x, y, het.x, het.y);
    if (d < 40) {
      het.health -= rocketDamage;
      return true;
    }
    return false;
  }

  boolean isHit(LightEnemy le) {
    float d = dist(x, y, le.x, le.y);
    if (d < 40) {
      le.health -= rocketDamage;
      return true;
    }
    return false;
  }
}
