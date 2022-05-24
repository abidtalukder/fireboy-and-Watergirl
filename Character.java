enum Action{
  UP, LEFT, DOWN, RIGHT;
}
class Character{
  int x, y, w, h, vx, vy;

  ElementType type;
  HashMap<String, Enum> map;
  public Character(int x, int y, int w, int h, ElementType type, HashMap<String, Action> map){
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
    this.map = map;
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

  void update(HashSet keysPressed){

  }




}
