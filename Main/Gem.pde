public class Gem{
  int x, y, w, h;
  ElementType type;
  public Gem(int x, int y, int w, int h, ElementType type){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
  }
  
  void display(){
    if(type == ElementType.FIRE){
      fill(165, 42, 42);
    }
    else{
      fill(0, 255, 255);
    }
    rect(x, y, w, h);
  }
}
