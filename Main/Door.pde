class Door{
  int t, numFrames;
  boolean isOpen;
  ElementType type;
  Rectangle Hitbox;
  
  public Door(int x, int y, int w, int h, ElementType type){
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
    
    Hitbox.display();
    fill(0);
    rect(Hitbox.x + 1, Hitbox.y + 1, Hitbox.w - 2, Hitbox.h - 1);
    
    if(type == ElementType.FIRE){
      fill(165, 42, 42);
    }
    else{
      fill(0, 255, 255);
    }
    
    rect(Hitbox.x + 2, Hitbox.y + 2 + (t * Hitbox.h) / numFrames , Hitbox.w - 4, Hitbox.h - 2 - (t * Hitbox.h) / numFrames);
  }
  
}
