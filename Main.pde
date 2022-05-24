import java.util.HashMap;
import java.util.HashSet;

enum ElementType{
  DEFAULT, FIRE, WATER, POISON;
}
Character Fireboy, Watergirl;
Platform p;
HashSet keysPressed = new HashSet();

boolean wUp, wLeft, wDown, wRight;
boolean fUp, fLeft, fDown, fRight;

void setup(){
  size(500, 500);


   p = new Platform(80, 470, 380, 30, ElementType.DEFAULT);

   /**
   Hashmap Idea
   **/
   // Fireboy Hashmap:

   // HashMap<String, enum> map = new HashMap<String, enum>();
   // map.add("i", Action.UP);
   // map.add("j", Action.LEFT);
   // map.add("k", Action.DOWN);
   // map.add("l", Action.RIGHT);
   // Fireboy = new Character(20, 470, 20, 30, ElementType.FIRE, map);

   // map = new HashMap<String, enum>();
   // map.add("w", Action.UP);
   // map.add("a", Action.LEFT);
   // map.add("s", Action.DOWN);
   // map.add("d", Action.RIGHT);
   // Watergirl = new Character(50, 470, 20, 30, ElementType.WATER, map);

}

void draw(){
  background(255);
  //Fireboy.display();
  //Watergirl.display();
  p.display();
}

void keyPressed(){
  keysPressed.add(key + "");
}


void keyReleased(){
  keysPressed.remove(key + "");
}
