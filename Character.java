class Character{
  int x, y, w, h;
  ElementType type;
  public Character(int x, int y, int w, int h, ElementType type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
  }

  void display(){
    if(type == ElementType.FIRE){
      fill(255, 165, 0); // Orange - can change as desired
    }
    else if(type == ElementType.WATER){
      fill(0, 0, 255); // Orange - can change as desired
    }
    rect(x, y, w, h);
  }
}
