class Platform{
  int x, y, w, h;
  
  int range;
  ElementType type;
  int wait = 0;
  int counter = 0;
  Button activate = null;
  public Platform(int x, int y, int w, int h, ElementType type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
    range = 0;
  }
  
  public Platform(int x, int y, int r, Button a) {
    
    this.x = x;
    this.y = y;
    h = 10;
    w = 60;
    range = r;
    activate = a;
    type = ElementType.ELEVATOR;
    
  }
  
  //Rectangle getHurtBox(){
  //  return new Rectangle( (int) x, (int) y, (int) w, (int) h );
  //}

  void display(){
    
    
    
    move();
    switch(type){
      case DEFAULT:
        fill(205,133,63);
        break;
      case FIRE:
        fill(165, 42, 42);
        break;
      case WATER:
        fill(0, 255, 255);
        break;
      case POISON:
        fill(77, 181, 96);
        break;
      case ELEVATOR:
        fill(128,128,128);
        break;
    }

    rect(x, y, w, h);
  }
  
  
 void move() {
  
    if (type == ElementType.ELEVATOR){
    
    if (activate != null && activate.isPushed){
      System.out.println("pressed");
    wait++;
    if (wait >= 10) {
     wait = 0;
      
     
     
     if (counter < range) {
     counter ++;
     y++;
     }
    
    }
    
    } else {
    
      wait --;
      
      if (wait >= 10){
      
        wait = 0;
        
        
        if (counter != 0){
        y--;
        counter --;
        
        
        
        }
      
      }
      
    
    }
    
    }
  
  
  }
}
