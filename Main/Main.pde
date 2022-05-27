import java.util.HashMap;
import java.util.HashSet;
import java.awt.event.KeyEvent;

enum ElementType{
  DEFAULT, FIRE, WATER, POISON;
}

enum Action{
  Up, Left, Right, Reset
  // Down  (Redundant for now)p

}

enum CollisionType{
  // The names of the directions indicate the directions relative to the Character (e. g. a ceiling ~ Top to a Character)
  Top, Left, Bottom, Right, None
}

Character Fireboy, Watergirl;
Platform p;
Controller controller;
HashSet keysPressed = new HashSet();

void setup(){
  size(500, 500);

  controller = new Controller();
  
  HashMap<Integer, Action> map = new HashMap<Integer, Action>();
  p = new Platform(70, 440, 400, 10, ElementType.DEFAULT);
  /**
  Adding "r" to trigger a reset, since both Characters store the current keys pressed
  Will try to make a global container later to avoid adding "r" to the Character hashmaps
  **/
  map.put(KeyEvent.VK_R, Action.Reset);

  map.put(KeyEvent.VK_UP, Action.Up);
  map.put(KeyEvent.VK_LEFT, Action.Left);
  map.put(KeyEvent.VK_RIGHT, Action.Right);

  Fireboy = new Character(20, 470, ElementType.FIRE, map, controller);

  map = new HashMap<Integer, Action>();


  map.put(KeyEvent.VK_W, Action.Up);
  map.put(KeyEvent.VK_A, Action.Left);
  map.put(KeyEvent.VK_D, Action.Right);

  Watergirl = new Character(50, 470, ElementType.WATER, map, controller);

}

void draw(){
  background(255);
  // "r" is pressed
  if(controller.currentlyHeld.contains(KeyEvent.VK_R)){
    reset();
    controller.keyRemove(KeyEvent.VK_R);
  }
  
  
  Fireboy.collisions.add(Fireboy.rectangleCollisions(p));
  Fireboy.update();
  Fireboy.collisions = new HashSet<CollisionType>();
  
  // Fireboy death
  if(Fireboy.actions.contains(Action.Reset) ){
    Fireboy.actions.remove(Action.Reset);
    reset();
  }
  

  Watergirl.collisions.add(Watergirl.rectangleCollisions(p));
  Watergirl.update();
  Watergirl.collisions = new HashSet<CollisionType>();
  
  Fireboy.display();
  Watergirl.display();

  // Watergirl death
  if(Watergirl.actions.contains(Action.Reset) ){
    Watergirl.actions.remove(Action.Reset);
    reset();
  }
  
  p.display();
}

void reset(){
  setup(); // For now, we can just setup the level from scratch
}

void keyPressed(){
   controller.keyAdd(keyCode);
}


void keyReleased(){
  controller.keyRemove(keyCode);
}
