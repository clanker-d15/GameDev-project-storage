// Franklin Roth | 17 Sept 2026 | TankGame
Tank player;
HeavyEnemy H_enemy;
LightEnemy L_enemy;
Heal healthPack;

import processing.sound.*;
SoundFile laser1;

PImage mouse, reloadMouse;
int tankOffScreen, ax, ay;
boolean play;

ArrayList<HeavyEnemy> H_enemies = new ArrayList<HeavyEnemy>();
ArrayList<LightEnemy> L_enemies = new ArrayList<LightEnemy>();
ArrayList<Heal> healPack = new ArrayList<Heal>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
//ArrayList<Rocket> rockets = new ArrayList<Rocket>();


void setup() {
  size(700, 900);
  player = new Tank();
  H_enemy = new HeavyEnemy(0, 0);
  healthPack = new Heal();
  mouse = loadImage("crossHair.png");
  reloadMouse = loadImage("ReloadCrosshair.png");
  H_enemies.add(new HeavyEnemy(int(random(width)), -60));
  L_enemies.add(new LightEnemy(int(random(width)), -60));
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

    infoPanel();

    if (player.health<1) {
      gameOver();
    }

    if (player.ammo > 0) {
      image(mouse, mouseX, mouseY);
    } else {
      image(reloadMouse, mouseX, mouseY);
    }


    textAlign(CENTER, CENTER);
    rectMode(CENTER);
    textSize(15);
    if (player.ammo > 0) {
      if (mouseY < 25 || mouseX < 25) {
        fill(190, 200);
        rect(mouseX + 23, mouseY + 17, 22, 19, 25);
        fill(0);
        text(player.ammo, mouseX + 23, mouseY + 15);
      } else {
        fill(190, 200);
        rect(mouseX - 23, mouseY - 20, 22, 19, 25);
        fill(0);
        text(player.ammo, mouseX - 23, mouseY - 22);
      }
    } else {
      if (mouseY < 25 || mouseX < 70) {
        fill(190, 200);
        rect(mouseX + 50, mouseY + 23, 82, 19, 25);
        fill(0);
        text("Reloading...", mouseX + 50, mouseY + 21);
      } else {
        fill(190, 200);
        rect(mouseX - 50, mouseY - 23, 82, 19, 25);
        fill(0);
        text("Reloading...", mouseX - 50, mouseY - 25);
      }
    }
  }


  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();

    if (b.isOffScreen()) {
      bullets.remove(i);
    }
  }

  //for (int i = rockets.size() - 1; i >= 0; i--) {
  //  Rocket r = rockets.get(i);
  //  r.update();
  //  r.display();

  //  if (r.isOffScreen()) {
  //    rockets.remove(i);
  //  }
  //}
}

void mousePressed() {
  if (play == true) {
    if (mouseButton == LEFT) {
      if (player.ammo > 0) {
        bullets.add(new Bullet(player.x, player.y));
        player.shoot();
        laser1.play();
      }
    }

    // Note: Change this function after your done
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
    if (key == 'a') player.movingLeft = true;
    if (key == 'd') player.movingRight = true;
    if (keyCode == 38) player.movingForward = true;
    if (keyCode == 40) player.movingBackward = true;
    if (keyCode == 37) player.movingLeft = true;
    if (keyCode == 39) player.movingRight = true;
  }
}

void keyReleased() {
  if (play == true) {
    if (key == 'w') player.movingForward = false;
    if (key == 's') player.movingBackward = false;
    if (key == 'a') player.movingLeft = false;
    if (key == 'd') player.movingRight = false;
    if (keyCode == 38) player.movingForward = false;
    if (keyCode == 40) player.movingBackward = false;
    if (keyCode == 37) player.movingLeft = false;
    if (keyCode == 39) player.movingRight = false;
  }
}

void infoPanel() {
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  stroke(10);
  strokeWeight(2);
  fill(127, 127);
  rect(73, 860, 137, 70, 13);
  textSize(25);


  if (player.health > 750) {
    fill(255);
  }
  if (player.health < 750) {
    fill(#E5AC2E);
  }
  if (player.health < 300) {
    fill(#D82A2A);
  }

  text("Health: " + player.health, 73, 835);


  if (player.ammo == 0) {
    fill(255);
    text("Reloading...", 73, 857);
  } else {
    if (player.ammo > 8) {
      fill(255);
      text("Ammo: " + player.ammo, 65, 857);
    }
    if (player.ammo < 9) {
      fill(#FAE0C0);
      text("Ammo: " + player.ammo, 65, 857);
    }
    if (player.ammo < 4) {
      fill(#FAC0C0);
      text("Ammo: " + player.ammo, 65, 857);
    }
  }
}


void startScreen() {
  background(0);

  // Add more to start screen
  fill(255);
  textSize(50);
  text("Defend the base", width/5, height/2);
  textSize(20);
  text("Press any key to begin", width/2.5, height/1.9);
}

void gameOver() {
  if (player.health < 1) {
    textAlign(CENTER, CENTER);
    fill(0, 190);
    rect(0, 0, 1000, 1000);
    fill(255);

    textSize(25);
    text("Game Over! Your tank was destroyed.", 200, 400);
    text("Rerun the game to restart", 255, 430);
    noLoop();
  }
}
