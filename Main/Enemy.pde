class Enemy extends Moveable {


float speedLimit = 1.5;
  



  public Enemy(int x, int y){
    super(x,y,30,30,ElementType.ENEMY);
    vx = 1;
  }
  
  void display() {
    fill(0,0,0);
    rect(x,y,w,h);
  }
  
  void update(){
    ay = g; // By default, set gravity to g

    checkBoxCollisions();
    checkPlatformCollisions();

    if(y + h >= height || collisions.contains(CollisionType.Bottom) || boxCollisions.contains(CollisionType.Bottom)){
      ay -= g; // Normal force cancels out gravity force
      vy = 0;
      
    }
    
    if (collisions.contains(CollisionType.Right)) {
      
      vx *= -1;
    
    } else if (collisions.contains(CollisionType.Left)) {
      
      vx *= -1;
    
    }
    
    
    
    vy += ay;


    x += vx;
    y += vy;

    checkBoundaries();
    isTouchingPlayers();
  }
  
  void isTouchingPlayers() {
  
    if (rectangleCollisions(Fireboy)|| rectangleCollisions(Watergirl)) {
    reset();
    }
  
  }
  
     boolean rectangleCollisions(Character p){
  
  // Rectangular collision occurs when the components distances between the centers
  // is less than the the sum of half the widths and the sum of half the heights
  
  
  // Displacements between the rcenters
  // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract
  
  float dx = (this.x + this.w / 2.0) - (p.x + p.w / 2.0);
  float dy = (this.y + this.h / 2.0) - (p.y + p.h / 2.0);
  
  // The combined half dimensions are essentially component "radii"
  float combinedHalfWidths = (this.w / 2.0) + (p.w / 2.0);
  float combinedHalfHeights = (this.h / 2.0) + (p.h / 2.0);
  
  return abs(dx) < combinedHalfWidths && abs(dy) < combinedHalfHeights;
  
}










}
