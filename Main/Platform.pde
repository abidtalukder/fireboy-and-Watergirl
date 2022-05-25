class Platform {
  int x, y, w, h;
  ElementType type;
  public Platform(int x, int y, int w, int h, ElementType type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.type = type;
  }

  void display() {
    switch(type) {
    case DEFAULT:
      fill(205, 133, 63);
      break;
    case FIRE:
      fill(165, 42, 42);
      break;
    case WATER:
      fill(0, 255, 255);
      break;
    case POISON:
      fill(77, 181, 96);
      break;
    }

    rect(x, y, w, h);
  }

  void defaultTexture() {


    color c1 = color(153, 76, 0);
    color c2 = color(255, 128, 0);
    color c3 = color(102, 51, 0);

    for (int i = x; i < x + w; i++) {

      for (int j = y; j < y + h; j++) {
        if (j-y>=3){
        int select = (int) (Math.random()*3);
        if (select == 0) fill(c1);
        else if (select == 1) fill(c2);
        else fill(c3);
        } else {
        fill(0,204,0);
        }
        rect(i, j, 1, 1);
      }
    }
  }
  
  
  
}
