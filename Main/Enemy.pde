class Enemy extends Moveable {


float speedLimit = 1.5;
  



  public Enemy(int x, int y){
    super(x,y,20,20,ElementType.ENEMY);
  }
  
  void display() {
    fill(255,255,255);
    rect(x,y,w,h);
  }










}
