class Platform{
  int x, y, w, h;
  ElementType type;
  
  Rectangle Hitbox;
  public Platform(int x, int y, int w, int h, ElementType type){
    this.x = x;
    this.y = y;
    this.w = w; 
    this.h = h;
    Hitbox = new Rectangle(x, y, w, h);
    this.type = type;
  }

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

    Hitbox.display();
  }
}
