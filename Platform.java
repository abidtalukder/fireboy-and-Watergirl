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

  void display(){
    if(type == ElementType.DEFAULT){
      fill(205,133,63);
    }
    if(type == ElementType.FIRE){
      fill(165, 42, 42);
    }

    if(type == ElementType.WATER){
      fill(0, 255, 255);
    }

    if(type == ElementType.POISON){
      fill(77, 181, 96);
    }
    rect(x, y, w, h);
  }
}
