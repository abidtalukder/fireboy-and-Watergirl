class Button{
  int x, y, w, h, t, numFrames;
  boolean isPushed;
  public Button(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    t = 0;
    numFrames = 5; // Will mimic the door's open / close structure
  }
  
    void update(boolean isTouchingPlayer){
    if(isTouchingPlayer){
      if(t == numFrames && !isPushed){
        isPushed = true;
      }
      else if(!isPushed){
        this.t = this.t + 1;
      }
    }
    else{
      isPushed = false;
      if(t > 0)
        this.t = this.t - 1;
    }
  }

  
  void display(){
    fill(124);
    rect(x + 2, y + 2 + (t * h) / numFrames , w - 4, h - 2 - (t * h) / numFrames);
  }
}
