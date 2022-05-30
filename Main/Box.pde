class Box {

  int x, y, w, h;

  public Box(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    fill(204, 102, 0);
    rect(x, y, w, h);
  }
}
