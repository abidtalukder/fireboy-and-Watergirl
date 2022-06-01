class Door{
  int x, y, w, h, t, numFrames;
  boolean isOpen;
  ElementType type;
  Rectangle Hitbox;
  
  public Door(int x, int y, int w, int h, ElementType type){
    this.x = x;
    this.y = y;
    this.w = w; 
    this.h = h;
    Hitbox = new Rectangle(x, y, w, h);
    t = 0;
    numFrames = 15; // Higher number => slower speed // lower number => higher speed
    this.type = type;
  }
  
  void update(boolean isTouchingPlayer){
    if(isTouchingPlayer){
      if(t == numFrames && !isOpen){
        isOpen = true;
      }
      else if(!isOpen){
        this.t = this.t + 1;
      }
    }
    else{
      isOpen = false;
      if(t > 0)
        this.t = this.t - 1;
    }
  }

  
  void display(){
    if(type == ElementType.FIRE){
      fill(165, 42, 42);
    }
    else{
      fill(0, 255, 255);
    }
    
    rect(x, y, w, h);
    fill(0);
    rect(x + 1, y + 1, w - 2, h - 1);
    
    if(type == ElementType.FIRE){
      fill(165, 42, 42);
    }
    else{
      fill(0, 255, 255);
    }
    
    rect(x + 2, y + 2 + (t * h) / numFrames , w - 4, h - 2 - (t * h) / numFrames);
  }
  
}
