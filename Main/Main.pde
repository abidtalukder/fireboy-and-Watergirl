import java.util.HashMap;
import java.util.HashSet;
import java.awt.event.KeyEvent;
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Arrays;

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

ArrayList<Object> levelOne;
ArrayList<Object> levelTwo;
ArrayList<Object> levelThree;

void setup(){
  size(500, 500);
  noStroke();
  controller = new Controller();

  HashMap<Integer, Action> map = new HashMap<Integer, Action>();
  Platforms = new ArrayList<Platform>();
  Gems = new ArrayList<Gem>();

  String[] levelOneStrings = new String[0];
  try{
    levelOneStrings = loadStrings("LevelOne.txt");
    levelOne =  objectParser(levelOneStrings, controller);
  }

  catch(Exception e){
   System.out.println("LevelOne.txt not found");
  }
  //String[] levelTwoStrings = new String[0];
  //try{
  //  levelTwoStrings = loadStrings("LevelTwo.txt");
  //  levelTwo =  objectParser(levelTwoStrings);
  //}

  //catch(Exception e){
  // System.out.println("LevelTwo.txt not found");
  //}
    //String[] levelTwoStrings = new String[0];
  //try{
  //  levelThreeStrings = loadStrings("LevelThree.txt");
  //  levelThree =  objectParser(levelThreeStrings);
  //}

  //catch(Exception e){
  // System.out.println("LevelThree.txt not found");
  //}






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

//void characterCollisions(Character Player){
//  for(Platform p : Platforms){
//    CollisionType collision = Player.rectangleCollisions(p);
//    if(collision != CollisionType.None){
//      if((Player.type == ElementType.FIRE && p.type == ElementType.WATER) || (Player.type == ElementType.WATER && p.type == ElementType.FIRE) || p.type == ElementType.POISON){
//        reset();
//      }
//    }
//    Player.collisions.add(collision);
//  }
//  Gem removed = null;
//  for(Gem g : Gems){
//    if(Player.type == g.type && Player.isTouchingGem(g)){
//      removed = g; // This is to avoid ConcurrentModificationException
//    }
//  }
//  if(removed != null){
//    Gems.remove(removed);
//  }
//  Player.collisions.add(Player.rectangleCollisions(mp1));
//  Player.update();
//}
void characterCollisions(Character Player, ArrayList<Object> objects){
  //for(Platform p : Platforms){
  //  CollisionType collision = Player.rectangleCollisions(p);
  //  if(collision != CollisionType.None){
  //    if((Player.type == ElementType.FIRE && p.type == ElementType.WATER) || (Player.type == ElementType.WATER && p.type == ElementType.FIRE) || p.type == ElementType.POISON){
  //      reset();
  //    }
  //  }
  //  
  //}
  for(Object o : Platforms){
    if(o instanceof Platform){
      Platform p = (Platform) o; 
      CollisionType collision = Player.rectangleCollisions(p);
      if(collision != CollisionType.None){
      if((Player.type == ElementType.FIRE && p.type == ElementType.WATER) || (Player.type == ElementType.WATER && p.type == ElementType.FIRE) || p.type == ElementType.POISON){
        reset();
      }
    }
    Player.collisions.add(collision);
    }
  }
  
  
  Gem removed = null;
  for(Object o : objects){
    if(o instanceof Gem){
      Gem g = (Gem) o;
      if(Player.type == g.type && Player.isTouchingGem(g)){
        removed = g; // This is to avoid ConcurrentModificationException (by deleting stuff in the collection while you're iterating through it)
      }
    }
  }
  if(removed != null){
    objects.remove(removed);
  }
  
  
  // Player.collisions.add(Player.rectangleCollisions(mp1));
  Player.update();
}


void draw(){
  if(!haveWon){
  background(255);

  // "r" is pressed => Reset
  if(controller.currentlyHeld.contains(KeyEvent.VK_R)){
    reset();
    controller.keyRemove(KeyEvent.VK_R);
  }

    //characterCollisions(Fireboy);
    //characterCollisions(Watergirl);

    //d1.update(Fireboy.isTouchingDoor(d1));
    //d2.update(Watergirl.isTouchingDoor(d2));
    //b1.update(Fireboy.isTouchingButton(b1) || Watergirl.isTouchingButton(b1));
    //b2.update(Fireboy.isTouchingButton(b2) || Watergirl.isTouchingButton(b2));
    //mp1.update(b1.isPushed || b2.isPushed);
    //Fireboy.collisions = new HashSet<CollisionType>();
    //Watergirl.collisions = new HashSet<CollisionType>();

    //for(Platform p : Platforms){
    //  p.display();
    //}
    //for(Gem g : Gems){
    //  g.display();
    //}

    //d1.display();
    //d2.display();
    //b1.display();
    //b2.display();
    //mp1.display();
    //Fireboy.display();
    //Watergirl.display();


    /* NEW IMPlEMENTATION IDEAS:
    - Make an object arraylist of all the things in the level
    - Have every "displayable" implement Displayable, to avoid cluttering Main
    */
    
    //Character fireboy, watergirl;
    //for(Object o : levelOne){
    //  if(o instanceof Character){
    //    if(((Character) o).type == ElementType.FIRE){
    //      fireboy = (Character) o;
    //    }
    //    if(((Character) o).type == ElementType.WATER){
    //      watergirl = (Character) o;
    //    }        
    //  }
    //}
    
    //characterCollisions(Fireboy, levelOne);
    //characterCollisions(Watergirl, levelOne);    
    
    for(Object o : levelOne){
      if(o instanceof Character){
        characterCollisions((Character) o, levelOne);
//        ((Character) o).collisions = new HashSet<CollisionType>();
      }
    }
    ArrayList<Character> characters = new ArrayList<Character>();
    for(Object o : levelOne){
      if(o instanceof Character){
        characters.add((Character) o);
      }
    }
    
/*

    //d1.update(Fireboy.isTouchingDoor(d1));
    //d2.update(Watergirl.isTouchingDoor(d2));
    //b1.update(Fireboy.isTouchingButton(b1) || Watergirl.isTouchingButton(b1));
    //b2.update(Fireboy.isTouchingButton(b2) || Watergirl.isTouchingButton(b2));
    //mp1.update(b1.isPushed || b2.isPushed);
    //Fireboy.collisions = new HashSet<CollisionType>();
    //Watergirl.collisions = new HashSet<CollisionType>();
*/
    for(Object o : levelOne){
      if(o instanceof Door){
        ((Door) o).update(characters);
      }
      if(o instanceof ButtonElevatorGroup){
        ((ButtonElevatorGroup) o).update(characters);
      }
    }
    
    for(Character c : characters){
      c.collisions = new HashSet<CollisionType>();
    }
    
    for(Object o : levelOne){
      if(o instanceof Displayable){
        ((Displayable) o).display();
      }
    }


   // haveWon = d1.isOpen && d2.isOpen;
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

ArrayList<Object> objectParser(String[] tokens, Controller controller){
  ArrayList<Object> objects = new ArrayList<Object>();
  String[] objTokens;
  // objects.add()
  for(int i = 0; i < tokens.length; i++){
      objTokens = split(tokens[i], " ");
      if(objTokens[0].equals("Character")){
        int x = new Integer(objTokens[1]);
        int y = new Integer(objTokens[2]);
        HashMap<Integer, Action> map = new HashMap<Integer, Action>();
        if(objTokens[3].equals("FIRE")){
            map.put(KeyEvent.VK_UP, Action.Up);
            map.put(KeyEvent.VK_LEFT, Action.Left);
            map.put(KeyEvent.VK_RIGHT, Action.Right);
            objects.add(new Character(x, y, ElementType.FIRE, map, controller));
        }
        if(objTokens[3].equals("WATER")){
          map.put(KeyEvent.VK_W, Action.Up);
          map.put(KeyEvent.VK_A, Action.Left);
          map.put(KeyEvent.VK_D, Action.Right);
          objects.add(new Character(x, y, ElementType.WATER, map, controller));
        }

      }

      if(objTokens[0].equals("Platform")){
        ElementType type = ElementType.DEFAULT;
        if(objTokens[5].equals("DEFAULT")){
          type = ElementType.DEFAULT;
        }
        if(objTokens[5].equals("FIRE")){
          type = ElementType.FIRE;
        }
        if(objTokens[5].equals("WATER")){
          type = ElementType.WATER;
        }
        if(objTokens[5].equals("POISON")){
          type = ElementType.POISON;
        }
        int x = new Integer(objTokens[1]);
        int y = new Integer(objTokens[2]);
        int w = new Integer(objTokens[3]);
        int h = new Integer(objTokens[4]);
        objects.add(new Platform(x, y, w, h, type));
      }

       if(objTokens[0].equals("Gem")){
         ElementType type = ElementType.FIRE;
         if(objTokens[5].equals("FIRE")){
           type = ElementType.FIRE;
         }
         if(objTokens[5].equals("WATER")){
           type = ElementType.WATER;
         }
         int x = new Integer(objTokens[1]);
         int y = new Integer(objTokens[2]);
         int w = new Integer(objTokens[3]);
         int h = new Integer(objTokens[4]);
         objects.add(new Gem(x, y, w, h, type));
       }

       if(objTokens[0].equals("Door")){

         ElementType type = ElementType.FIRE;
         if(objTokens[5].equals("FIRE")){
           type = ElementType.FIRE;
         }
         if(objTokens[5].equals("WATER")){
           type = ElementType.WATER;
         }
         int x = new Integer(objTokens[1]);
         int y = new Integer(objTokens[2]);
         int w = new Integer(objTokens[3]);
         int h = new Integer(objTokens[4]);
         objects.add(new Door(x, y, w, h, type));
       }
       if(objTokens[0].equals("BUTTONGROUP")){
         ButtonElevatorGroup b = new ButtonElevatorGroup();
         i++;
         objTokens = split(tokens[i], " ");
         while(objTokens.length > 1){
           if(objTokens[0].equals("Button")){
            int x = new Integer(objTokens[1]);
            int y = new Integer(objTokens[2]);
            int w = new Integer(objTokens[3]);
            int h = new Integer(objTokens[4]);
            b.add(new Button(x, y, w, h));
           }

           if(objTokens[0].equals("MovingPlatform")){
            int x = new Integer(objTokens[1]);
            int y = new Integer(objTokens[2]);
            int w = new Integer(objTokens[3]);
            int h = new Integer(objTokens[4]);
            int yDisp = new Integer(objTokens[5]);
            b.add(new MovingPlatform(x, y, w, h, yDisp));
           }

           i++;
           objTokens = split(tokens[i], " ");
         }
         objects.add(b);
       }
  }

  return objects;
}
