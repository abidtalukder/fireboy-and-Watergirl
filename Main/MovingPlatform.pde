class MovingPlatform{
  int x, initialY, y, w, h, t, yDisp, numIterations;
  public MovingPlatform(int x, int y, int w, int h, int yDisp){
    this.x = x;
    this.initialY = y;
    this.w = w;
    this.h = h;
    this.yDisp = yDisp;
    t = 0;
    numIterations = 20;
  }
  
  
   void update(boolean isPushed, HashSet characterCollisions){
    
    if(isPushed){
      if(t != numIterations){
        t += 1;
      }
    }
    else if(t > 0){
       t -= 1;
    }
    y = initialY + ((t * yDisp) / (numIterations));
  }
  
  void display(){
    fill(124);
    y = y + ((t * yDisp) / (numIterations));
    rect(x, y, w, h);
  }
  
}
