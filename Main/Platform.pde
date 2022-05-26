class Platform{
  int x, y, w, h;
  ElementType type;
  public Platform(int x, int y, int w, int h, ElementType type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
  }
  
  //Rectangle getHurtBox(){
  //  return new Rectangle( (int) x, (int) y, (int) w, (int) h );
  //}

  void display(){
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
    }

    rect(x, y, w, h);
  }
}
