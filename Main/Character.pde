class Character{
  float x, y, w, h, vx, vy, ax, ay;


  float g = 0.4; // Gravitational constant
  float mu = 0.7; // Friction constant
  float speedLimit = 7; // Speed Limit
  float jumpConstant = -5; // Jump constant (up y-accel when jumping)

  ElementType type;
  HashMap<String, Action> map;

  HashSet<String> currentlyHeld;
  HashSet<Action> actions;
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
    ax = 0;
    ay = 0;

    this.map = map;
    currentlyHeld = new HashSet<String>();
  }

    // Instead of dealing with FB and WG's separately with a set of 8 booleans,
    // we can organize the current actions by checking if they're part of the character's moveset - like WASD or IJKL
    HashSet<Action> currActions() {
        HashSet<Action> set = new HashSet<Action>();
        for (String k : this.currentlyHeld) {
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

    ay = g; // By default, set gravity to g

    vx = 0;
    if (actions.contains(Action.Left)) {
       vx += -3;
    }
    if(actions.contains(Action.Right)){
       vx += 3;
    }

    if(y + h >= height){
      vy = 0; // stop the Character from moving vertically
      // (just cancelling out the gravity with the normal force => no net acceleration but velocity remains the same)
      ay -= g;
      y = height - h;
      if(actions.contains(Action.Up)){
        ay += jumpConstant;
      }
    }

    vx += ax;
    vy += ay; // Have to work on a jump
    if(Math.abs(vx) >= speedLimit){
      vx = Math.signum(vx) * speedLimit;
    }

    x += vx;
    y += vy;
  }

}
