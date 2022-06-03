class Portal {

  int x, y, w, h, wait, counter;

  public Portal(int xa, int ya) {
    x = xa;
    y = ya;
    wait = 20;
    counter = 0;
    w=30;
    h=50;
  }
  
  void display(){
  
    fill(0,102,204);
    ellipse(x,y,w,h);
    
  }
  
  
}
