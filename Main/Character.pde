class Character{
  float x, y, w, h, vx, vy, ax, ay;

  float g = 0.4; // Gravitational constant
  float friction = 0.7; // Friction constant
  float speedLimit = 3; // Speed Limit
  float jumpConstant = -7; // Jump constant (up y-accel when jumping)
  
  ElementType type;
  Controller controller;
  HashMap<Integer, Action> map;
  HashSet<Action> actions;
  HashSet<CollisionType> collisions;
  public Character(int x, int y, ElementType type, HashMap<Integer, Action> map, Controller controller){
    this(x, y, 20, 30, type, map, controller);
  }
  
  public Character(int x, int y, int w, int h, ElementType type, HashMap<Integer, Action> map, Controller controller){
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
    ax = 0;
    ay = 0;

    this.map = map;
    this.controller = controller;
    collisions = new HashSet<CollisionType>();
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

    if(y + h >= height || collisions.contains(CollisionType.Bottom)){
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


  void checkBoundaries(){
   // Border collisions - generalize this to Platforms too later
   if(x < 0){
     x = 0;
     vx = 0;
   }

   if(x + w > width){
     x = width - w;
     vx = 0;
   }

   if(y < 0){
     y = 0;
     vy = 0;
   }

   if(y + h > height){
     y = height - h;
     vy = 0;
   }
  }
  CollisionType rectangleCollisions(Platform p){
  
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
        this.y += overlapY;
        return CollisionType.Top;
      }
      
      this.y -= overlapY;
      return CollisionType.Bottom;
    }
    
    if(dx > 0){
      this.x += overlapX;
      return CollisionType.Right;
    }
    this.x -= overlapX;
    return CollisionType.Left;
    
  }
  return CollisionType.None;
}

  
}
