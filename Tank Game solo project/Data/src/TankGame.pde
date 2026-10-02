// Franklin Roth | 17 Sept 2026 | TankGame
Tank player;
Enemy enemy;
Heal healthPack;

import processing.sound.*;
SoundFile laser1;

PImage mouse, reloadMouse;
int tankOffScreen, ax, ay;
boolean play;

ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Heal> healPack = new ArrayList<Heal>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
//ArrayList<Wall> walls = new ArrayList<Wall>();


void setup() {
  size(800, 800);
  player = new Tank();
  enemy = new Enemy(0, 0);
  healthPack = new Heal();
  mouse = loadImage("crossHair.png");
  reloadMouse = loadImage("ReloadCrosshair.png");
  enemies.add(new Enemy(int(random(width)), -60));
  noCursor();
  play = false;

  ax = mouseX + 15;
  ay = mouseY + 15;

  laser1 = new SoundFile(this, "laser1.mp3");
}

void draw() {
  if (play == false) {
    startScreen();
  }
  
  if (play == true) {
    background(255);

    // add enemy and healPacks

    player.update();
    player.display();

    enemy.update();
    enemy.display();

    infoPanel();

    if (player.health<1) {
      gameOver();
    }

    if (player.ammo > 0) {
      image(mouse, mouseX, mouseY);
    } else {
      image(reloadMouse, mouseX, mouseY);
    }

    textSize(15);
    if (player.ammo > 0) {
      if (mouseX > 774) {
        fill(190, 200);
        rect(mouseX - 32, mouseY + 3, 22, 19, 25);
        fill(0);
        text(player.ammo, mouseX - 28, mouseY + 18);
      } else {
        fill(190, 200);
        rect(mouseX + 11, mouseY + 3, 22, 19, 25);
        fill(0);
        text(player.ammo, mouseX + 15, mouseY + 18);
      }

      if (mouseY > 784) {
        fill(190, 200);
        rect(mouseX + 11, mouseY - 30, 22, 19, 25);
        fill(0);
        text(player.ammo, mouseX + 15, mouseY - 14);
      }

      if (mouseY > 780 && mouseX > 770) {
        fill(190, 200);
        rect(mouseX - 31, mouseY - 30, 22, 19, 25);
        fill(0);
        text(player.ammo, mouseX - 25, mouseY - 14);
      }
    } else {
      if (mouseX > 760) {
        fill(190, 200);
        rect(mouseX - 99, mouseY + 3, 82, 19, 25);
        fill(0);
        text("Reloading...", mouseX - 95, mouseY + 18);
      } else {
        fill(190, 200);
        rect(mouseX + 11, mouseY + 3, 82, 19, 25);
        fill(0);
        text("Reloading...", mouseX + 15, mouseY + 18);
      }
    }
  }
}

//for (int i = 0; i < bullets.size(); i++) {
//  Bullet b = bullets.get(i);
//  b.display();
//  b.move();
//  if (b.isOffScreen() == true) {
//    bullets.remove(b);
//  }
//}

void mousePressed() {
  if (play == true) {
    if (mouseButton == LEFT) {
      bullets.add(new Bullet(player.x, player.y));
      player.shoot();
      laser1.play();
    }
    
    // Note: remove this function after your done with the game
    if (mouseButton == RIGHT) {
      player.health = 0;
      gameOver();
    }
    
  }
}

void keyPressed() {
  if (play == false) {
    if (keyPressed) play = true;
  }

  if (play == true) {
    if (key == 'w') player.movingForward = true;
    if (key == 's') player.movingBackward = true;
    if (key == 'a') player.turningLeft = true;
    if (key == 'd') player.turningRight = true;
    if (keyCode == 38) player.movingForward = true;
    if (keyCode == 40) player.movingBackward = true;
    if (keyCode == 37) player.turningLeft = true;
    if (keyCode == 39) player.turningRight = true;
  }
}

void keyReleased() {
  if (play == true) {
    if (key == 'w') player.movingForward = false;
    if (key == 's') player.movingBackward = false;
    if (key == 'a') player.turningLeft = false;
    if (key == 'd') player.turningRight = false;
    if (keyCode == 38) player.movingForward = false;
    if (keyCode == 40) player.movingBackward = false;
    if (keyCode == 37) player.turningLeft = false;
    if (keyCode == 39) player.turningRight = false;
  }
}

void infoPanel() {
  fill(127, 127);
  rect(0, 729, 137, 70, 13);

  if (player.health > 750) {
    fill(255);
  }
  if (player.health < 750) {
    fill(#E5AC2E);
  }
  if (player.health < 300) {
    fill(#D82A2A);
  }

  stroke(0);
  strokeWeight(2);
  textSize(25);
  text("Health: " + player.health, 3, 750);
  if (player.ammo == 0) {
    text("Reloading...", 3, 770);
  } else {
    text("Ammo: " + player.ammo, 3, 770);
  }
}


void startScreen() {
  background(0);

  // Add start screen graphic
  fill(255);
  textMode(CENTER);
  textSize(50);
  text("Press any key to begin", 150, 400);
}

void gameOver() {
  if (player.health < 1) {
    fill(0,190);
    rect(0,0,1000,1000);
    // Add game over screen graphic
    fill(255);
    textMode(CENTER);
    textSize(25);
    text("Game Over! Your tank was destroyed.", 200, 400);
    text("Rerun the game to restart", 255, 430);
    noLoop();
  }
}
