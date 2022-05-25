import java.util.HashMap;
import java.util.HashSet;

enum ElementType{
  DEFAULT, FIRE, WATER, POISON;
}

enum Action{
  Up, Left, Right, Reset
  // Down  (Redundant for now)

}

Character Fireboy, Watergirl;
Platform p;
HashSet keysPressed = new HashSet();

void setup(){
  size(500, 500);
  
  p = new Platform(80, 470, 380, 30, ElementType.DEFAULT);
  
  // For now, IJKL for Fireboy - easier than having to deal with keyCODED and a different type
  HashMap<String, Action> map = new HashMap<String, Action>();
  
  /**
  Adding "r" to trigger a reset, since both Characters store the current keys pressed
  Will try to make a global container later to avoid adding "r" to the Character hashmaps
  **/ 
  map.put("r", Action.Reset); 
   
  map.put("i", Action.Up);
  map.put("j", Action.Left);
  // map.put("k", Action.Down);
  map.put("l", Action.Right);
  
  Fireboy = new Character(20, 470, 20, 30, ElementType.FIRE, map);
  
  map = new HashMap<String, Action>();
  
  
  map.put("w", Action.Up);
  map.put("a", Action.Left);
  // map.put("s", Action.Down);
  map.put("d", Action.Right);
  
  Watergirl = new Character(50, 470, 20, 30, ElementType.WATER, map);

}

void draw(){
  background(255);
  
  Fireboy.update();
  Fireboy.display();
  
  // "r" is pressed or a Reset is triggered when Fireboy dies
  if(Fireboy.actions.contains(Action.Reset) ){
    Fireboy.actions.remove(Action.Reset);  
    reset();
  }
  
  
  
  Watergirl.update();
  Watergirl.display();
  
  // A Reset is triggered when Watergirl dies
  if(Watergirl.actions.contains(Action.Reset) ){
    Watergirl.actions.remove(Action.Reset);  
    reset();
  }
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
