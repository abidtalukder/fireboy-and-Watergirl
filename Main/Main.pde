enum ElementType{
  DEFAULT, FIRE, WATER, POISON;
}

Character Fireboy, Watergirl;
Platform p;
void setup(){
  size(500, 500);
   Fireboy = new Character(20, 470, 20, 30, ElementType.FIRE);
   Watergirl = new Character(50, 470, 20, 30, ElementType.WATER);
   p = new Platform(80, 470, 380, 30, ElementType.DEFAULT);
}

void draw(){
  background(255);
  Fireboy.display();
  Watergirl.display();
  p.display();
}
