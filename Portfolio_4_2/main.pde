import java.util.ArrayList;

PImage background;

int bgX = 0;
int score = 0;

ArrayList<Alien> storedAliens;
ArrayList<Bullet> storedBullets;
ArrayList<Explosion> storedExplosions;

Defender defender;
Asteroid asteroid;

void showInformation(Defender defender){ // score, bullets etc
  fill(255);
  textSize(16);
  text("SCORE: "+score, 16, 16);
  
  text("BULLETS: "+defender.bullets, width-100, 16);
}

void createNewAlien(){
  Alien replacedAlien = new Alien((int)random(900, 1000), (int)random(25, 375));
  storedAliens.add(replacedAlien);
}

public void settings() {
  size(800, 400);
}

void setup(){
  storedAliens = new ArrayList<Alien>();
  storedBullets = new ArrayList<Bullet>();
  storedExplosions = new ArrayList<Explosion>();
  
  asteroid = new Asteroid(1200, 50);
  
  createNewAlien();
  createNewAlien();
  createNewAlien();
  createNewAlien();
  createNewAlien();
  
  background = loadImage("spaceBackground.jpg");
  background.resize(width,  height);
  
  defender = new Defender(200);
}


void draw(){
  // BACKGROUND
  image(background, bgX, 0); // place first image
  image(background, bgX+background.width, 0); // place second image
  bgX = bgX - 4; // move background
  if(bgX == -background.width){ // check if both images are off screen
    bgX = 0;
  }
  
  //INFO
  showInformation(defender);
  
  // FOREGROUND
  defender.render(); // defender needs to be drawn before everything
  
  // ASTEROID
  asteroid.x -= asteroid.deltaX;
  asteroid.isOffScreen();
  asteroid.drawObject();
  
  // EXPLOSIONS
  for(int i=0; i<storedExplosions.size(); i++){ // loop for all bullets
    Explosion item = storedExplosions.get(i);
    item.growObject();
    item.drawObject();
    
    if(item.checkSize()){
      storedExplosions.remove(item);
    }
  }
    
  // ALIENS
  for(int i=0; i<storedAliens.size(); i++){ // loops for all the aliens
    Alien alien = storedAliens.get(i);
    alien.render();
    
    if(alien.checkOffScreen()){ 
      storedAliens.remove(alien);
      createNewAlien();
      continue;
    }
    
    Bullet killingBullet = alien.isShot(); // returns value of the shot that kills an alien //<>//
    
    if(killingBullet != null){ // checks if alien is actually shot
      storedExplosions.add(new Explosion(alien.x, alien.y));
      storedAliens.remove(alien);
      storedBullets.remove(killingBullet);
      createNewAlien();
      
      score += 10;
      defender.bullets += 1;
    }
    
  }
  
  for(int i=0; i<storedBullets.size(); i++){ // loop for all bullets
    Bullet bullet = storedBullets.get(i);
    
    bullet.x += bullet.deltaX;
    bullet.drawBullet();
    
    if(bullet.isOffScreen()){
      defender.bullets += 1;
      storedBullets.remove(bullet);
    }
  }
  
  defender.detectCrash();
}

void keyPressed(){
  if(keyCode == UP){
    defender.y -= defender.deltaY;
  }else if(keyCode == DOWN){
    defender.y += defender.deltaY;
  }
  if(key == ' '){ // spacebar
    if(defender.bullets > 0){
      defender.bullets -= 1;
      storedBullets.add(new Bullet(defender.x + 65, defender.y + 15));
    }
  }
}
