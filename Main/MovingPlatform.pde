/*
class MovingPlatform{
  int x, y, w, h, t, yDisp, numIterations;
  int currY;
  public MovingPlatform(int x, int y, int w, int h, int yDisp){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.yDisp = yDisp;
    t = 0;
    numIterations = 15;
  }
  
  
   void update(boolean isPushed){
    
    if(isPushed){
      if(t != numIterations){
        t += 1;
      }
    }
    else if(t > 0){
       t -= 1;
    }
    currY = y + ((t * yDisp) / (numIterations));
  }

  
  void display(){
    fill(124);
    currY = y + ((t * yDisp) / (numIterations));
    rect(x, currY, w, h);
  }
  
}
*/
