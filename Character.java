class Character{
  int x, y, w, h, vx, vy, ax, ay;

  ElementType type;
  HashMap<String, Action> map;
  HashSet<String> currentlyHeld;
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
    HashSet<Action> actions = currActions();

    vx = 0;
    if (actions.contains(Action.Left)) {
       vx += -3;
    }
    if(actions.contains(Action.Right)){
       vx += 3;
    }
    vx += ax;
    vy += ay; // Have to work on a jump

    x += vx;
    y += vy;
  }

}
