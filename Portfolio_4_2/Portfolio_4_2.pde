color ALIEN1 = color(0, 255, 0);
color ALIEN2 = color(50, 100, 0);
color BULLET = color(255, 255, 0);
color ASTEROID = color(255, 0, 0);

class Alien{
  int x;
  int y;
  
  int moveRange = 5; // amount of pixels the alien will move up and down
  int currentMove = 0; // amount of pixels the alien has moved up or down
  int currentDirection = 1; // direction of alien
  
  Alien(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void render(){
    adjustAlien();
    this.x -= 3;
    drawAlien();
  }
  
  void drawAlien(){
    fill(ALIEN1);
    ellipse(x, y, 30, 30);
    fill(ALIEN2);
    ellipse(x, y, 50, 15);
  }
  
  void adjustAlien(){ // moves alien up and down
    if(currentMove >= moveRange || currentMove <= -moveRange){ // checks if out of moveRange's area
      currentDirection = -currentDirection;
    }
    currentMove += currentDirection;
    this.y += currentMove;
  }
  
  Bullet isShot(){
    for(int i=0; i<storedBullets.size(); i++){
      Bullet bullet = storedBullets.get(i);
      
      if(bullet.x + 25 <= this.x + 25 && bullet.x >= this.x - 25){
        if(bullet.y + 10 >= this.y - 8 && bullet.y <= this.y + 8){
          return bullet;
        }
      }
    }
    return null;
  }
  
  Boolean checkOffScreen(){
    return (this.x+50<0);
  }
}

class Defender{
  int x = 50;
  int y;
  int deltaY = 6; // how much the ship will go up or down 
  int crashRange = 40; // range infront of ship user will use
  int bullets = 3;
  
  Defender(int y){
    this.y = y;
  }
  
  void render(){
    drawCrashLine();
    drawDefender();
  }
  
  void drawDefender(){
    fill(0,0,200);
    rect(x,y,20,10); //draw top box
    fill(255,0,0); //draw rocket
    rect(x,y+10,50,20);
    triangle(x+50,y+10,x+50,y+30,x+60,y+20);
  }
  
  void detectCrash(){
    for(int i=0; i<crashRange; i++){ //loops for each possible chance
      color test = get(x + 65, y + i);
      
      if (ALIEN1 == test || ALIEN2 == test){ // checking if crashing into alien
        print("Crashed into alien");
        stop();
      }else if(ASTEROID == test){
        print("Crashed into asteroid");
        stop();
      }
  }
  }
  
  void drawCrashLine(){
    for(int i=0; i<crashRange; i++){
      point(x + 65, y + i);
    }
  }
}

class Bullet{
  int x;
  int y;
  int deltaX = 5;
  
  Bullet(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void drawBullet(){
    fill(BULLET);
    rect(this.x, this.y, 25, 10);
  }
  
  Boolean isOffScreen(){
    return (this.x - 25 > width);
  }
}

class Asteroid{
  int x;
  int y;
  int deltaX = 8;
  
  Asteroid(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void drawObject(){
    fill(ASTEROID);
    ellipse(x, y, 40, 40);
  }
  
  void isOffScreen(){
    if(x + 40 < 0){
      this.x = (int)random(1200, 2500);
      this.y = (int)random(1,9) * 50;
    }
  }
}

class Explosion{
  int x;
  int y;
  int size = 0;
  int maxSize = 60;
  
  Explosion(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void growObject(){
    this.size += 4;
  }
  
  void drawObject(){
    fill(255, 215, 0);
    ellipse(x, y, size, size);
  }
  
  Boolean checkSize(){
    return (size >= maxSize);
  }
    
  
}
