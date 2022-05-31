class Box {

  int x, y, w, h;
  float vx,vy,ax,ay = 0;
  
  boolean isOnGround = true;

  public Box(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    
  }

  void display() {
    fill(204, 102, 0);
    rect(x, y, w, h);
  }
  
  void update(){
  
    y += vy;
    x += vx;
    vx *= ax;
    vy *= ay;
    
    checkBoundaries();
    gravity();
    
    
    
  }
  
  void gravity(){
  
  if (!isOnGround){
  ay = 0.4;
  
  } else ay = 0;
  
  if (vy <= 0.5 && vy >= -0.5 && isOnGround) vy = 0;
  
  }
  
  void checkBoundaries(){
   if(x < 0){
     x = 0;
     vx = 0;
   }

   if(x + w > width){
     x = width - w;
     vx = 0;
   }

   if(y < 0){
     y = 0;
     vy = 0;
   }

   if(y + h > height){
     y = height - h;
     vy = 0;
   }
  }
  
}
