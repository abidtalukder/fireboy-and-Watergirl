class Enemy extends Moveable {


float speedLimit = 1.5;

boolean isDead = false;
  
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
    
    if (boxCollisions.contains(CollisionType.Right) || boxCollisions.contains(CollisionType.Left)) {
    ay += jumpConstant;
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
    isDead();
    isTouchingPlayers();
    
  }
  
  void isTouchingPlayers() {
    
    boolean f = rectangleCollisions(Fireboy)==CollisionType.Bottom || rectangleCollisions(Fireboy)==CollisionType.Left|| rectangleCollisions(Fireboy)==CollisionType.Right;
    boolean w = rectangleCollisions(Watergirl)==CollisionType.Left || rectangleCollisions(Watergirl)==CollisionType.Right || rectangleCollisions(Watergirl)==CollisionType.Bottom;
  
    if ((!Fireboy.isKilled && f) || (!Watergirl.isKilled && w) ) {
      reset();
    }
  
  }
  
  void isDead(){
  
    boolean f = rectangleCollisions(Fireboy)==CollisionType.Top;
    boolean w = rectangleCollisions(Watergirl) == CollisionType.Top;
    
    //isDead = f || w;
     
    if (f) {
   isDead = true;
   Fireboy.isKilled = true;
    //Fireboy.vy -= 4;
    //HashSet<Action> actions = Fireboy.currActions();
    //if (actions.contains(Action.Right)) {
    //Fireboy.vx = 0.2;
    //} else if (actions.contains(Action.Left)) {
    //Fireboy.vx = -0.2;
    //}
    
    
    //Fireboy.x += Fireboy.vx;
    //Fireboy.y += Fireboy.vy;
    //Fireboy.display();
    
    }
    
    if (w) {
    isDead = true;
    Watergirl.isKilled= true;
    //Watergirl.ay -= 4;
    //HashSet<Action> actions = Watergirl.currActions();
    //if (actions.contains(Action.Right)) {
    //Watergirl.vx = 0.2;
    //} else if (actions.contains(Action.Left)) {
    //Watergirl.vx = -0.2;
    //}
    
    //Watergirl.vy += Watergirl.ay;
    //Watergirl.x += Watergirl.vx;
    //Watergirl.y += Watergirl.vy;
    //Watergirl.display();
    
    }
    //if (isDead) {System.out.println("Top");}
    
  
  }
  
CollisionType rectangleCollisions(Character p){
  
  // Rectangular collision occurs when the components distances between the centers
  // is less than the the sum of half the widths and the sum of half the heights  
  // Displacements between the centers
  // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract
  
  float dx = (this.x + this.w / 2.0) - (p.x + p.w / 2.0);
  float dy = (this.y + this.h / 2.0) - (p.y + p.h / 2.0);
  
  // The combined half dimensions are essentially component "radii"
  float combinedHalfWidths = (this.w / 2.0) + (p.w / 2.0);
  float combinedHalfHeights = (this.h / 2.0) + (p.h / 2.0);
  
  if(abs(dx) < combinedHalfWidths && abs(dy) < combinedHalfHeights){
    // Overlap is "signed" here (positive / negative) for simplicity
    float overlapX = combinedHalfWidths - abs(dx);
    float overlapY = combinedHalfHeights - abs(dy);
    if(overlapX >= overlapY){
      if(dy > 0){
        
        return CollisionType.Top;
      }
      
      
      return CollisionType.Bottom;
    }
    
    if(dx > 0){
      
      return CollisionType.Right;
    }
    //this.x -= overlapX;
    return CollisionType.Left;
    
  }
  return CollisionType.None;
}










}
