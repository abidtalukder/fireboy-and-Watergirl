public class Gem{
  ElementType type;
  Rectangle Hitbox;
  
  public Gem(int x, int y, int w, int h, ElementType type){
    Hitbox = new Rectangle(x, y, w, h);
    this.type = type;
  }
  
  void display(){
    if(type == ElementType.FIRE){
      fill(165, 42, 42);
    }
    else{
      fill(0, 255, 255);
    }
    Hitbox.display();
  }
}
