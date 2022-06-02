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
ArrayList<Gem> Gems;
Door d1, d2;
boolean haveWon;
Button b1, b2;
MovingPlatform mp1;

void setup(){
  size(500, 500);
  noStroke();
  controller = new Controller();
  
  HashMap<Integer, Action> map = new HashMap<Integer, Action>();
  Platforms = new ArrayList<Platform>();
  Gems = new ArrayList<Gem>();
  
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
  
  Gems.add(new Gem(260, 470, 10, 5, ElementType.WATER));
  Gems.add(new Gem(280, 470, 10, 5, ElementType.WATER));
  Gems.add(new Gem(360, 470, 10, 5, ElementType.FIRE));
  Gems.add(new Gem(380, 470, 10, 5, ElementType.FIRE));
  
  d1 = new Door(400, 15, 30, 40, ElementType.FIRE);    
  d2 = new Door(440, 15, 30, 40, ElementType.WATER);
  b1 = new Button(140, 310, 30, 15);
  b2 = new Button(140, 228, 30, 15);
  mp1 = new MovingPlatform(35, 250, 65, 15, 60);
  
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
  Gem removed = null;
  for(Gem g : Gems){
    if(Player.type == g.type && Player.isTouchingGem(g)){
      removed = g; // This is to avoid ConcurrentModificationException
    }
  }
  if(removed != null){
    Gems.remove(removed);
  }
  Player.collisions.add(Player.rectangleCollisions(mp1));
  Player.update();
  // Player.collisions = new HashSet<CollisionType>();
  
}

void draw(){
  if(!haveWon){
  background(255);
  
  // "r" is pressed => Reset
  if(controller.currentlyHeld.contains(KeyEvent.VK_R)){
    reset();
    controller.keyRemove(KeyEvent.VK_R);
  }
  
    characterCollisions(Fireboy);
    characterCollisions(Watergirl);

    d1.update(Fireboy.isTouchingDoor(d1));
    d2.update(Watergirl.isTouchingDoor(d2));
    b1.update(Fireboy.isTouchingButton(b1) || Watergirl.isTouchingButton(b1));
    b2.update(Fireboy.isTouchingButton(b2) || Watergirl.isTouchingButton(b2));
    mp1.update(b1.isPushed || b2.isPushed);
    Fireboy.collisions = new HashSet<CollisionType>();
    Watergirl.collisions = new HashSet<CollisionType>();
    
    for(Platform p : Platforms){
      p.display();
    }
    for(Gem g : Gems){
      g.display();
    }
    
    d1.display();
    d2.display();
    b1.display();
    b2.display();
    mp1.display();
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
