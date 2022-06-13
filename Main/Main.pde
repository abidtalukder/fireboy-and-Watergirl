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
ArrayList<Platform> PlatformsLevelTwo;

ArrayList<Box> Boxes;
Door d1, d2, d1Two, d2Two;
boolean haveWon;
boolean haveWonLevelTwo;

Button b1;
Portal p;
// Door d1Two, d2Two;

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
  Platforms.add(new Platform(2, 0, 519, 10, ElementType.DEFAULT));
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
  
  PlatformsLevelTwo = new ArrayList<Platform>();
  PlatformsLevelTwo.add(new Platform(1, 5, 13, 496, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(2, 483, 499, 17, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(481, 4, 24, 484, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(171, 457, 190, 27, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(220, 413, 106, 44, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(13, 384, 164, 14, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(340, 380, 152, 18, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(75, 306, 352, 17, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(143, 253, 215, 58, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(1, 1, 505, 22, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(8, 155, 207, 20, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(299, 156, 197, 19, ElementType.DEFAULT));
  PlatformsLevelTwo.add(new Platform(228, 200, 50, 55, ElementType.DEFAULT));

  d1Two = new Door(40, 120, ElementType.FIRE);
  d2Two = new Door(420, 120, ElementType.WATER);
  
  d1 = new Door(400, 15, 30, 40, ElementType.FIRE);    
  d2 = new Door(440, 15, 30, 40, ElementType.WATER);
  b1 = new Button(110, 310, 30, 15);
   Platforms.add(new Platform(20,320,100,b1));
  
  map.put(KeyEvent.VK_R, Action.Reset);

  map.put(KeyEvent.VK_UP, Action.Up);
  map.put(KeyEvent.VK_LEFT, Action.Left);
  map.put(KeyEvent.VK_RIGHT, Action.Right);

  Fireboy = new Character(37, 470, ElementType.FIRE, map, controller);


  map = new HashMap<Integer, Action>();

  map.put(KeyEvent.VK_W, Action.Up);
  map.put(KeyEvent.VK_A, Action.Left);
  map.put(KeyEvent.VK_D, Action.Right);

  Watergirl = new Character(37, 381, ElementType.WATER, map, controller);
  
  
}

void characterCollisions(Character Player){
  for(Platform p : Platforms){
    CollisionType collision = Player.rectangleCollisions(p);
    if(collision != CollisionType.None){
      if((Player.type == ElementType.FIRE && p.type == ElementType.WATER) || (Player.type == ElementType.WATER && p.type == ElementType.FIRE) || p.type == ElementType.POISON){
        reset();
      }
    }
    Player.collisions.add(collision);
  }
  Player.update();
  Player.collisions = new HashSet<CollisionType>();
}

void draw(){
  if(!haveWon){
  background(255);
  
  if(controller.currentlyHeld.contains(KeyEvent.VK_R)){
    reset();
    controller.keyRemove(KeyEvent.VK_R);
  }
  p.update();
  for(Platform p : Platforms){
    CollisionType collision = Fireboy.rectangleCollisions(p);
    if(collision != CollisionType.None && (p.type == ElementType.WATER || p.type == ElementType.POISON)){
      reset();
    }
    Fireboy.collisions.add(collision);
  }
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

  
  Watergirl.collisions = new HashSet<CollisionType>();
  
  for(Platform po : Platforms){
    po.display();
  }
  d1.update(Fireboy.isTouchingDoor(d1));
  d2.update(Watergirl.isTouchingDoor(d2));
  boolean portalTouched = false;
  for (Enemy e : p.enemies) {
  
    if (e.isTouchingButton(b1)) {
    portalTouched = true;
    break;
    }
  
  }
  
  b1.update(Fireboy.isTouchingButton(b1) || Watergirl.isTouchingButton(b1) || Boxes.get(0).isTouchingButton(b1));

  
    d1.display();
    d2.display();
    b1.display();

    Boxes.get(0).update();
    Boxes.get(0).display();

    p.display();
    Fireboy.display();
    Watergirl.display();
    haveWon = d1.isOpen && d2.isOpen;
    if(haveWon){
      Fireboy.x = 37;
      Fireboy.y = 470;
      Watergirl.x = 463;
      Watergirl.y = 470;
    }
  }
  else if(!haveWonLevelTwo){
  background(255);
  
  if(controller.currentlyHeld.contains(KeyEvent.VK_R)){
    reset();
    controller.keyRemove(KeyEvent.VK_R);
  }
  
  for(Platform p : PlatformsLevelTwo){
    CollisionType collision = Fireboy.rectangleCollisions(p);
    if(collision != CollisionType.None && (p.type == ElementType.WATER || p.type == ElementType.POISON)){
      reset();
    }
    Fireboy.collisions.add(collision);
  }
  Fireboy.update();
  Fireboy.collisions = new HashSet<CollisionType>(); 
  
  for(Platform p : PlatformsLevelTwo){
     CollisionType collision = Watergirl.rectangleCollisions(p);
     if(collision != CollisionType.None && (p.type == ElementType.FIRE || p.type == ElementType.POISON)){
      reset();
    }
    Watergirl.collisions.add(collision);
  }
  Watergirl.update();

  
  Watergirl.collisions = new HashSet<CollisionType>();
  
  for(Platform po : PlatformsLevelTwo){
    po.display();
  }
  d1Two.update(Fireboy.isTouchingDoor(d1Two));
  d2Two.update(Watergirl.isTouchingDoor(d2Two));
    
    d1Two.display();
    d2Two.display();
    
    Fireboy.display();
    Watergirl.display();
    haveWonLevelTwo = d1Two.isOpen && d2Two.isOpen;  
  }
  else{
    background(255);
    textSize(75);
    text("You Won!", 100, 250);
  }
}

void reset(){
  setup(); 
}

void keyPressed(){
   controller.keyAdd(keyCode);
}

void mousePressed(){
  println(mouseX + ", " + mouseY);
}
void keyReleased(){
  controller.keyRemove(keyCode);
}
