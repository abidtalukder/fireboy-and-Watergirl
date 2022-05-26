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
  Fireboy.update();
  CollisionType side = rectangleCollisions(Fireboy, p);
  Fireboy.display();
  p.display();
  text(side + "", 250, 250);
  
  
  // "r" is pressed
  if(controller.currentlyHeld.contains(KeyEvent.VK_R)){
    reset();
    controller.keyRemove(KeyEvent.VK_R);
  }
  // Fireboy death
  if(Fireboy.actions.contains(Action.Reset) ){
    Fireboy.actions.remove(Action.Reset);
    reset();
  }
  

  //Watergirl.update();
  //Watergirl.display();

  //// Watergirl death
  //if(Watergirl.actions.contains(Action.Reset) ){
  //  Watergirl.actions.remove(Action.Reset);
  //  reset();
  //}
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

CollisionType rectangleCollisions(Character c, Platform p){
  
  // Rectangular collision occurs when the components distances between the centers
  // is less than the the sum of half the widths and the sum of half the heights
  
  
  // Displacements between the centers
  // Identify the center coordinates (left top translated by halfWidth, halfHeight) and subtract
  
  float dx = (c.x + c.w / 2.0) - (p.x + p.w / 2.0);
  float dy = (c.y + c.h / 2.0) - (p.y + p.h / 2.0);
  
  // The combined half dimensions are essentially component "radii"
  float combinedHalfWidths = (c.w / 2.0) + (p.w / 2.0);
  float combinedHalfHeights = (c.h / 2.0) + (p.h / 2.0);
  
  if(abs(dx) < combinedHalfWidths && abs(dy) < combinedHalfHeights){
    // Overlap is "signed" here (positive / negative) for simplicity
    float overlapX = combinedHalfWidths - abs(dx);
    float overlapY = combinedHalfHeights - abs(dy);
    if(overlapX >= overlapY){
      if(dy > 0){
        c.y += overlapY;
        return CollisionType.Top;
      }
      
      c.y -= overlapY;
      return CollisionType.Bottom;
    }
    
    if(dx > 0){
      
      c.x += overlapX;
      return CollisionType.Right;
    }
    c.x -= overlapX;
    return CollisionType.Left;
    
  }
  return CollisionType.None;
}
