class Character extends Moveable{
  //float x, y, w, h, vx, vy, ax, ay;

  //float g = 0.4; // Gravitational constant
  //float friction = 0.7; // Friction constant
  //float speedLimit = 3; // Speed Limit
  //float jumpConstant = -8; // Jump constant (up y-accel when jumping)
  
  ElementType type;
  Controller controller;
  HashMap<Integer, Action> map;
  HashSet<Action> actions;
  //HashSet<CollisionType> collisions = new HashSet<CollisionType>();
  //HashSet<CollisionType> boxCollisions = new HashSet<CollisionType>();
  public Character(int x, int y, ElementType type, HashMap<Integer, Action> map, Controller controller){
    this(x, y, 20, 30, type, map, controller);
  }
  
  public Character(int x, int y, int w, int h, ElementType type, HashMap<Integer, Action> map, Controller controller){
    super(x,y,w,h,type);
    
    if(type != ElementType.FIRE && type != ElementType.WATER){
      throw new RuntimeException("Character Element Type is invalid");
    }

    this.map = map;
    this.controller = controller;
  
  }
  
  

    HashSet<Action> currActions() {
        HashSet<Action> set = new HashSet<Action>();
        for (Integer k : controller.currentlyHeld) {
            if (map.containsKey(k)) {
                set.add(map.get(k)); // Map the key (char / String) to an Action that the Character can perform
            }
        }
        return set;
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

  void update(){
    actions = currActions();
    ax = 0;
    ay = g; // By default, set gravity to g

    if (actions.contains(Action.Left)) {
       ax -= 0.2;
    }
    if(actions.contains(Action.Right)){
       ax += 0.2;
    }
    
    checkBoxCollisions();

    if(y + h >= height || collisions.contains(CollisionType.Bottom) || boxCollisions.contains(CollisionType.Bottom)){
      ay -= g; // Normal force cancels out gravity force
      vy = 0;
      if(actions.contains(Action.Up)){
        ay += jumpConstant;
      }
    }
    
    friction = 1;
    if(actions.size() == 0){
      friction = 0.95;
    }
    vx += ax;
    vy += ay;

    vx *= friction;
    if(Math.abs(vx) < 0.2) {
      vx  = 0;
    }

    if(Math.abs(vx) >= speedLimit){
      vx = Math.signum(vx) * speedLimit;
    }

    x += vx;
    y += vy;

    checkBoundaries();
  }
  
  CollisionType rectangleCollisions(Enemy p){
  
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


  //void checkBoundaries(){
  // if(x < 0){
  //   x = 0;
  //   vx = 0;
  // }

  // if(x + w > width){
  //   x = width - w;
  //   vx = 0;
  // }

  // if(y < 0){
  //   y = 0;
  //   vy = 0;
  // }

  // if(y + h > height){
  //   y = height - h;
  //   vy = 0;
  // }
  //}
  
  //void checkBoxCollisions() {
  
  //boxCollisions.clear();

  //  for (Box p : Boxes) {
  //    CollisionType temp = rectangleCollisions(p);
  //    if (temp != CollisionType.None) {
  //      boxCollisions.add(temp);
  //    }
  //  }
  //}
  
//  CollisionType rectangleCollisions(Platform p){
  
//  // Rectangular collision occurs when the components distances between the centers
//  // is less than the the sum of half the widths and the sum of half the heights
  
  
//  // Displacements between the centers
//  // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract
  
//  float dx = (this.x + this.w / 2.0) - (p.x + p.w / 2.0);
//  float dy = (this.y + this.h / 2.0) - (p.y + p.h / 2.0);
  
//  // The combined half dimensions are essentially component "radii"
//  float combinedHalfWidths = (this.w / 2.0) + (p.w / 2.0);
//  float combinedHalfHeights = (this.h / 2.0) + (p.h / 2.0);
  
//  if(abs(dx) < combinedHalfWidths && abs(dy) < combinedHalfHeights){
//    // Overlap is "signed" here (positive / negative) for simplicity
//    float overlapX = combinedHalfWidths - abs(dx);
//    float overlapY = combinedHalfHeights - abs(dy);
//    if(overlapX >= overlapY){
//      if(dy > 0){
//        this.y += overlapY;
//        return CollisionType.Top;
//      }
      
//      this.y -= overlapY;
//      return CollisionType.Bottom;
//    }
    
//    if(dx > 0){
//      this.x += overlapX;
//      return CollisionType.Right;
//    }
//    this.x -= overlapX;
//    return CollisionType.Left;
    
//  }
//  return CollisionType.None;
//}

//CollisionType rectangleCollisions(Box p) {

//    // Rectangular collision occurs when the components distances between the centers
//    // is less than the the sum of half the widths and the sum of half the heights


//    // Displacements between the centers
//    // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract

//    float dx = (this.x + this.w / 2.0) - (p.x + p.w / 2.0);
//    float dy = (this.y + this.h / 2.0) - (p.y + p.h / 2.0);

//    // The combined half dimensions are essentially component "radii"
//    float combinedHalfWidths = (this.w / 2.0) + (p.w / 2.0);
//    float combinedHalfHeights = (this.h / 2.0) + (p.h / 2.0);

//    if (abs(dx) < combinedHalfWidths && abs(dy) < combinedHalfHeights) {
//      // Overlap is "signed" here (positive / negative) for simplicity
//      float overlapX = combinedHalfWidths - abs(dx);
//      float overlapY = combinedHalfHeights - abs(dy);
//      if (overlapX >= overlapY) {
//        if (dy > 0) {
//          this.y += overlapY;
//          return CollisionType.Top;
//        }

//        this.y -= overlapY;
//        return CollisionType.Bottom;
//      }

//      if (dx > 0) {
//        this.x += overlapX;
//        return CollisionType.Right;
//      }
//      this.x -= overlapX;
//      return CollisionType.Left;
//    }
//    return CollisionType.None;
//  }

///**
// REALLY NEED TO SETUP INHERITANCE FOR MOVING PLATFORMS TOMORROW
// IN GENERAL, NEED TO IMPLEMENT MORE CLASS HEIRARCHIES AND INTERFACES
//**/
///*
//  CollisionType rectangleCollisions(MovingPlatform p){
  
//  // Rectangular collision occurs when the components distances between the centers
//  // is less than the the sum of half the widths and the sum of half the heights
  
  
//  // Displacements between the centers
//  // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract
  
//  float dx = (this.x + this.w / 2.0) - (p.x + p.w / 2.0);
//  float dy = (this.y + this.h / 2.0) - (p.y + p.h / 2.0);
  
//  // The combined half dimensions are essentially component "radii"
//  float combinedHalfWidths = (this.w / 2.0) + (p.w / 2.0);
//  float combinedHalfHeights = (this.h / 2.0) + (p.h / 2.0);
  
//  if(abs(dx) < combinedHalfWidths && abs(dy) < combinedHalfHeights){
//    // Overlap is "signed" here (positive / negative) for simplicity
//    float overlapX = combinedHalfWidths - abs(dx);
//    float overlapY = combinedHalfHeights - abs(dy);
//    if(overlapX >= overlapY){
//      if(dy > 0){
//        this.y += overlapY;
//        return CollisionType.Top;
//      }
      
//      this.y -= overlapY;
//      return CollisionType.Bottom;
//    }
    
//    if(dx > 0){
//      this.x += overlapX;
//      return CollisionType.Right;
//    }
//    this.x -= overlapX;
//    return CollisionType.Left;
    
//  }
//  return CollisionType.None;
//}
//*/
//  boolean isTouchingDoor(Door d){
//      return (this.x + this.w >= d.x &&    
//      this.x <= d.x + d.w &&    
//      this.y + this.h >= d.y &&    
//      this.y <= d.y + d.h);     
//  }
  
//  // Have to standardize the interactions between the Character to buttons / doors / platforms [Rectangle abstract class?]
//    boolean isTouchingButton(Button b){
//      return (this.x + this.w >= b.x &&    
//      this.x <= b.x + b.w &&    
//      this.y + this.h >= b.y &&    
//      this.y <= b.y + b.h);     
//  }
//  /*
//  boolean isTouchingMovingPlatform(MovingPlatform p){
//      return (this.x + this.w >= p.x &&    
//      this.x <= p.x + p.w &&    
//      this.y + this.h >= p.currY &&    
//      this.y <= p.currY + p.h);     
//  }
// */ 
}
