import java.util.HashMap;
import java.util.HashSet;
import java.awt.event.KeyEvent;

enum ElementType{
  DEFAULT, FIRE, WATER, POISON, ELEVATOR, ENEMY;
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
ArrayList<Box> Boxes;
Door d1, d2;
boolean haveWon;
Button b1;
//Enemy e;
Portal p;
// MovingPlatform mp1;


void setup(){
  size(500, 500);
  noStroke();
  controller = new Controller();
  p = new Portal(200,120);
  
  HashMap<Integer, Action> map = new HashMap<Integer, Action>();
  Platforms = new ArrayList<Platform>();
  Boxes = new ArrayList<Box>();
  Boxes.add(new Box(50,300, 30, 30));
  Platforms.add(new Platform(0, 487, 511, 18, ElementType.DEFAULT));
  Platforms.add(new Platform(0, 0, 20, 500, ElementType.DEFAULT));
  Platforms.add(new Platform(2, 11, 519, -35, ElementType.DEFAULT));
  Platforms.add(new Platform(485, 5, 116, 507, ElementType.DEFAULT));
  Platforms.add(new Platform(7, 412, 174, 20, ElementType.DEFAULT));
  Platforms.add(new Platform(12, 324, 311, 19, ElementType.DEFAULT));
  Platforms.add(new Platform(318, 324, 20, 69, ElementType.DEFAULT));
  Platforms.add(new Platform(322, 376, 102, 17, ElementType.DEFAULT));
  Platforms.add(new Platform(112, 242, 379, 21, ElementType.DEFAULT));
  Platforms.add(new Platform(11, 93, 111, 87, ElementType.DEFAULT));
  Platforms.add(new Platform(90, 155, 205, 25, ElementType.DEFAULT));
  Platforms.add(new Platform(185, 54, 305, 16, ElementType.DEFAULT));
  Platforms.add(new Platform(450, 450, 500, 500, ElementType.DEFAULT));
  
  Platforms.add(new Platform(350, 200, 200, 50, ElementType.DEFAULT));
  
  Platforms.add(new Platform(350, 486, 50, 10, ElementType.FIRE));
  Platforms.add(new Platform(250, 486, 50, 10, ElementType.WATER));
  Platforms.add(new Platform(200, 323, 50, 10, ElementType.POISON));
  
  
  d1 = new Door(400, 15, 30, 40, ElementType.FIRE);    
  d2 = new Door(440, 15, 30, 40, ElementType.WATER);
  b1 = new Button(110, 310, 30, 15);
  // mp1 = new MovingPlatform(35, 250, 65, 15, 50);
   Platforms.add(new Platform(20,320,100,b1));
  
  map.put(KeyEvent.VK_R, Action.Reset);

  map.put(KeyEvent.VK_UP, Action.Up);
  map.put(KeyEvent.VK_LEFT, Action.Left);
  map.put(KeyEvent.VK_RIGHT, Action.Right);

  Fireboy = new Character(37, 470, ElementType.FIRE, map, controller);
  //e = new Enemy(200,120);

  map = new HashMap<Integer, Action>();


  map.put(KeyEvent.VK_W, Action.Up);
  map.put(KeyEvent.VK_A, Action.Left);
  map.put(KeyEvent.VK_D, Action.Right);

  Watergirl = new Character(37, 381, ElementType.WATER, map, controller);
  
}

void draw(){
  if(!haveWon){
  background(255);
  
  // "r" is pressed => Reset
  if(controller.currentlyHeld.contains(KeyEvent.VK_R)){
    reset();
    controller.keyRemove(KeyEvent.VK_R);
  }
  
  for(Platform p : Platforms){
    CollisionType collision = Fireboy.rectangleCollisions(p);
    if(collision != CollisionType.None && (p.type == ElementType.WATER || p.type == ElementType.POISON)){
      reset();
    }
    Fireboy.collisions.add(collision);
  }
  // Fireboy.collisions.add(Fireboy.rectangleCollisions(mp1));
  Fireboy.update();
  Fireboy.collisions = new HashSet<CollisionType>(); // Resetting the collisions
  
  for(Platform p : Platforms){
     CollisionType collision = Watergirl.rectangleCollisions(p);
     if(collision != CollisionType.None && (p.type == ElementType.FIRE || p.type == ElementType.POISON)){
      reset();
    }
    Watergirl.collisions.add(collision);
  }
  Watergirl.update();
 // e.update();
  p.update();
  // Watergirl.collisions.add(Watergirl.rectangleCollisions(mp1));
  Watergirl.collisions = new HashSet<CollisionType>();
  
  for(Platform po : Platforms){
    po.display();
  }
  d1.update(Fireboy.isTouchingDoor(d1));
  d2.update(Watergirl.isTouchingDoor(d2));
  
  b1.update(Fireboy.isTouchingButton(b1) || Watergirl.isTouchingButton(b1) || Boxes.get(0).isTouchingButton(b1));
  // mp1.update(b1.isPushed);
  
    d1.display();
    d2.display();
    b1.display();
    // mp1.display();
    Boxes.get(0).update();
    Boxes.get(0).display();
    //e.display();
    p.display();
    Fireboy.display();
    Watergirl.display();
    haveWon = d1.isOpen && d2.isOpen;
  }
  else{
    background(255);
    textSize(75);
    text("You Won!", 100, 250);
  }
}

void reset(){
  setup(); // For now, we will just setup the level from scratch
}

void keyPressed(){
   controller.keyAdd(keyCode);
}


void keyReleased(){
  controller.keyRemove(keyCode);
}

void mousePressed(){
  println(mouseX + ", " + mouseY);
}
