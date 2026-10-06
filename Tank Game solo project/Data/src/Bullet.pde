class Bullet {
  float StartX, StartY, StartAngle, w, h, speed, damage;

  Bullet(float StartX, float StartY, float StartAngle) {
    this.x = x;
    this.y = y;
    w = 6;
    h = 15;
    speed = 8;
    damage = 30;
    angle = StartAngle;
  }

  void update() {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  void display() {
    fill(#F0A327);
    rectMode(CENTER);
    rect(x, y, w, h);
  }

  void move() {
    float dx = mouseX - x;
    float dy = mouseY - y;

    x += cos(angle) * speed;
    y += sin(angle) * speed;
  }

  boolean isOffScreen() {
    if (x>width+10 || x<width-10 || y>height+10 || y<height-10) {
      return true;
    } else {
      return false;
    }
  }

  boolean isHit(Tank t) {
    float d = dist(x, y, t.x, t.y);
    if (d<40) {
      player.health = player.health - 30;
      return true;
    } else {
      return false;
    }
  }
}
