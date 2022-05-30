class Box {

  int x, y, w, h;
  double vx,vy,ax,ay = 0;
  
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
  
    vy += ay;
    vx += ax;
    vx *= ax;
    vy *= ay;
    
    checkBoundaries();
    
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
