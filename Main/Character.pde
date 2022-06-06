class Character implements Displayable{
  float x, y, w, h, vx, vy, ax, ay;

  float g = 0.4; // Gravitational constant
  float friction = 0.7; // Friction constant
  float speedLimit = 3; // Speed Limit
  float jumpConstant = -8; // Jump constant (up y-accel when jumping)
  
  ElementType type;
  Controller controller;
  HashMap<Integer, Action> map;
  HashSet<Action> actions;
  HashSet<CollisionType> collisions;
  Rectangle Hitbox;
  
  public Character(int x, int y, ElementType type, HashMap<Integer, Action> map, Controller controller){
    this(x, y, 20, 30, type, map, controller);
  }
  
  public Character(int x, int y, int w, int h, ElementType type, HashMap<Integer, Action> map, Controller controller){
    Hitbox = new Rectangle(x, y, w, h);
    
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

    Hitbox.display();
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

    if(collisions.contains(CollisionType.Bottom)){
      ay = 0; 
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
    // Avoid the code multiplying by friction too often - just set the velocity to 0
    if(Math.abs(vx) < 0.2) {
      vx = 0;
    }

    if(Math.abs(vx) >= speedLimit){
      vx = Math.signum(vx) * speedLimit;
    }
    
    Hitbox.x += vx;
    Hitbox.y += vy;
    // Diagnostics
    /*
    print("x: " + Hitbox.x + ", y: " + Hitbox.y + "vx: " + vx + ", vy: " + vy + ", ax: " + ax + ", ay: " + ay);
    for(CollisionType c : collisions){
      print(" " + c);
    }
    println();
    */
    
  }

  CollisionType rectangleCollisions(Platform p){
    return Hitbox.rectangleCollisions(p.Hitbox);
  }
  
  CollisionType rectangleCollisions(MovingPlatform p){
    return Hitbox.rectangleCollisions(p.Hitbox);
  }


  boolean isTouchingDoor(Door d){
     return Hitbox.isTouching(d.Hitbox);
  }
  
  boolean isTouchingButton(Button b){
      return Hitbox.isTouching(b.Hitbox);
  }
  boolean isTouchingGem(Gem g){
      return Hitbox.isTouching(g.Hitbox);     
  }
  
  
  
}
