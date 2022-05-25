import java.util.HashMap;
import java.util.HashSet;

enum ElementType{
  DEFAULT, FIRE, WATER, POISON;
}

enum Action{
  Up, Left, Right, Reset
  // Down

}

Character Fireboy, Watergirl;
Platform p;
HashSet keysPressed = new HashSet();

void setup(){
  size(500, 500);

   p = new Platform(80, 470, 380, 30, ElementType.DEFAULT);

    HashMap<String, Action> map = new HashMap<String, Action>();

    // For now, IJKL for Fireboy - easier than having to deal with keyCODED and a different type
    map.put("i", Action.Up);
    map.put("j", Action.Left);
    // map.put("k", Action.Down);
    map.put("l", Action.Right);
    map.put("r", Action.Reset);
    Fireboy = new Character(20, 470, 20, 30, ElementType.FIRE, map);

    map = new HashMap<String, Action>();
    map.put("w", Action.Up);
    map.put("a", Action.Left);
    // map.put("s", Action.Down);
    map.put("d", Action.Right);
    map.put("r", Action.Reset);
    Watergirl = new Character(50, 470, 20, 30, ElementType.WATER, map);

}

void draw(){
  background(255);
  if(Fireboy.currentlyHeld.contains("r") ){
      reset();
  }

  Fireboy.update();
  Fireboy.display();
  Watergirl.update();
  Watergirl.display();
  // p.display();
}

void reset(){
  setup(); // For now, we can just setup the level from scratch
}

void keyPressed(){
  Fireboy.currentlyHeld.add(key + "");
  Watergirl.currentlyHeld.add(key + "");
}


void keyReleased(){
  Fireboy.currentlyHeld.remove(key + "");
  Watergirl.currentlyHeld.remove(key + "");
}
