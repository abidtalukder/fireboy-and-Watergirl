class Character{
  int x, y, w, h, vx, vy;
  boolean[] directions;
  ElementType type;
  public Character(int x, int y, int w, int h, ElementType type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    if(type != ElementType.FIRE && type != ElementType.WATER){
      throw new RuntimeException("Character Element Type is invalid");
    }
    this.type = type;

    vx = 0;
    vy = 0;
    directions = new boolean[4];
  }

  void display(){
    if(type == ElementType.FIRE){
      fill(255, 165, 0);
    }
    else{
      fill(0, 0, 255);
    }

    rect(x, y, w, h);
  }






}
