// Franklin Roth | 17 Sept 2026 | TankGame
Tank player;
Enemy enemy;
Heal healthPack;
PImage mouse;

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Heal> healPack = new ArrayList<Heal>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
//ArrayList<Wall> walls = new ArrayList<Wall>();


void setup() {
  size(700, 700);
  player = new Tank();
  enemy = new Enemy(0, 0);
  healthPack = new Heal();
  mouse = loadImage("crossHair.png");
  enemies.add(new Enemy(int(random(width)), -60));
  noCursor();
}

void draw() {
  background(255);

  // add enemy and healPacks

  player.update();
  player.display();

  enemy.update();
  enemy.display();

  player.move();
  player.stationary();

  infoPanel();


  image(mouse, mouseX, mouseY);
}

//for () {
//  Bullet b = bullets.get(i);
//  b.display();
//  b.move();
//  if (b.isOffScreen() == true) {
//    bullets.remove(b);
//  }
//}


void mousePressed() {
  bullets.add(new Bullet(player.x, player.y));

  if (mouseButton == LEFT) {
    player.shoot();
  }
}

void infoPanel() {
  fill(127, 127);
  rect(0, 629, 135, 70);
  fill(255);
  textSize(25);
  text("Health: " + player.health, 3, 650);
  if (player.ammo == 0) {
    text("Reloading...", 3, 670);
  } else {
    text("Ammo: " + player.ammo, 3, 670);
  }
}
