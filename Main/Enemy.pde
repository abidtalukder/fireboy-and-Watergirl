class Enemy extends Moveable {


float speedLimit = 1.5;
  



  public Enemy(int x, int y){
    super(x,y,20,20,ElementType.ENEMY);
  }
  
  void display() {
    fill(255,255,255);
    rect(x,y,w,h);
  }
  
  void update(){
    ay = g; // By default, set gravity to g

    checkBoxCollisions();

    if(y + h >= height || collisions.contains(CollisionType.Bottom) || boxCollisions.contains(CollisionType.Bottom)){
      ay -= g; // Normal force cancels out gravity force
      vy = 0;
      
    }
    
    vy += ay;


    x += vx;
    y += vy;

    checkBoundaries();
  }










}
