class Door{
  int x, y, w, h, t;
  
  public Door(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w; 
    this.h = h;
    t = 0;
  }
  
  void update(boolean isTouchingPlayer){
    if(isTouchingPlayer){
      if(t == 10){
        this.t = this.t - 1;
        // Have to figure out how to terminate and determine whether both doors are open
      }
      this.t = this.t + 1;
    }
    else{
      if(t > 0)
        this.t = this.t - 1;
    }
  }

  
  void display(){
    fill(244,164,96);
    rect(x, y, w, h);
    fill(0);
    rect(x + 1, y + 1, w - 2, h - 1);
    fill(244,164,96);
    rect(x + 2, y + 2 + (t * h) / 10 , w - 4, h - 2 - (t * h) / 10);
  }
  
}
