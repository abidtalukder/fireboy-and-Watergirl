//import java.util.ArrayDeque;

class Portal {

  int x, y, w, h, wait, counter;
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();

  //ArrayDeque<Enemy> deadEnemies = new ArrayDeque<Enemy>();

  public Portal(int xa, int ya) {
    x = xa;
    y = ya;
    wait = 250;
    counter = 0;
    w=30;
    h=50;
  }

  void display() {

    fill(0, 102, 204);
    ellipse(x, y, w, h);
  }

  void update() {

    counter ++;

    for (int i = 0; i < enemies.size(); i++) {

      if (enemies.get(i).isDead) {
        if (counter==wait) {

          enemies.get(i).isDead = false;
          enemies.get(i).x = x;
          enemies.get(i).y = y;

          counter = 0;
        }
      } else {
        enemies.get(i).update();
        enemies.get(i).display();
      }
    }

    if (counter == wait) {

      enemies.add(new Enemy(x, y));
      counter = 0;
      enemies.get(enemies.size()-1).update();
      enemies.get(enemies.size()-1).display();
    }
  }
}
