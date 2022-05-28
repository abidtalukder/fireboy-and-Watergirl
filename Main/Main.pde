import java.util.HashMap;
import java.util.HashSet;
import java.awt.event.KeyEvent;

enum ElementType{
  DEFAULT, FIRE, WATER, POISON;
}

enum Action{
  Up, Left, Right, Reset
}

enum CollisionType{
  // The names of the directions indicate the directions relative to the Character (e. g. a ceiling ~ Top to a Character)
  Top, Left, Bottom, Right, None
}

Character Fireboy, Watergirl;
Controller controller;
HashSet keysPressed = new HashSet();
ArrayList<Platform> Platforms;
Door d1, d2;
void setup(){
  size(500, 500);
  noStroke();
  controller = new Controller();
  
  HashMap<Integer, Action> map = new HashMap<Integer, Action>();
  Platforms = new ArrayList<Platform>();
  Platforms.add(new Platform(0, 487, 511, 18, ElementType.DEFAULT));
  Platforms.add(new Platform(0, 0, 20, 500, ElementType.DEFAULT));
  Platforms.add(new Platform(2, 11, 519, -35, ElementType.DEFAULT));
  Platforms.add(new Platform(485, 5, 116, 507, ElementType.DEFAULT));
  Platforms.add(new Platform(7, 412, 174, 20, ElementType.DEFAULT));
  Platforms.add(new Platform(12, 324, 311, 19, ElementType.DEFAULT));
  Platforms.add(new Platform(318, 325, 20, 72, ElementType.DEFAULT));
  Platforms.add(new Platform(322, 381, 102, 17, ElementType.DEFAULT));
  Platforms.add(new Platform(112, 242, 379, 21, ElementType.DEFAULT));
  Platforms.add(new Platform(11, 93, 111, 87, ElementType.DEFAULT));
  Platforms.add(new Platform(97, 154, 205, 25, ElementType.DEFAULT));
  Platforms.add(new Platform(185, 54, 305, 16, ElementType.DEFAULT));
  d1 = new Door(364, 447, 30, 40);    
  d2 = new Door(438, 14, 30, 40);
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
  
  for(Platform p : Platforms){
    Fireboy.collisions.add(Fireboy.rectangleCollisions(p));
  }
  Fireboy.update();
  Fireboy.collisions = new HashSet<CollisionType>();
  
  // Fireboy death
  if(Fireboy.actions.contains(Action.Reset) ){
    Fireboy.actions.remove(Action.Reset);
    reset();
  }
  
  for(Platform p : Platforms){
    Watergirl.collisions.add(Watergirl.rectangleCollisions(p));
  }
  Watergirl.update();
  Watergirl.collisions = new HashSet<CollisionType>();
  


  // Watergirl death
  if(Watergirl.actions.contains(Action.Reset) ){
    Watergirl.actions.remove(Action.Reset);
    reset();
  }
  for(Platform p : Platforms){
    p.display();
  }
  d1.update(Fireboy.isTouchingDoor(d1) || Watergirl.isTouchingDoor(d1));
  d2.update(Fireboy.isTouchingDoor(d2) || Watergirl.isTouchingDoor(d2));
  
  d1.display();
  d2.display();
  Fireboy.display();
  Watergirl.display();
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
